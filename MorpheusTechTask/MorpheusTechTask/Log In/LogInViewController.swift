//
//  LogInViewController.swift
//  MorpheusTechTask
//
//  Created by Jack Bridges on 05/10/2020.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var errorMessageView: UIView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    var viewModel: LogInViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = LogInViewModel(coreDataService: CoreDataService())
        self.setUpView()
    }
    
    func setUpView() {
        self.setUpErrorView()
        self.setUpLogInButton()
        self.setUpRegisterLabel()
        self.setUpTextFields()
        self.setUpTextFieldLabelling()
        self.addKeyboardObservers()
    }
    
    func setUpTextFieldLabelling() {
        self.usernameLabel.text = "Username"
        self.passwordLabel.text = "Password"
        self.usernameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.passwordLabel.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    func setUpTextFields() {
        self.usernameTextField.layer.borderWidth = 1.0
        self.usernameTextField.layer.borderColor = UIColor.clear.cgColor
        self.usernameTextField.placeholder = "E.g Gary123"
        self.passwordTextField.layer.borderWidth = 1.0
        self.passwordTextField.layer.borderColor = UIColor.clear.cgColor
        self.passwordTextField.delegate = self
        self.usernameTextField.delegate = self
        let tapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tapGestureRecogniser)
    }
    
    func setUpLogInButton() {
        self.logInButton.setTitle("LOG IN", for: .normal)
        self.logInButton.setTitleColor(.white, for: .normal)
        self.logInButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.logInButton.layer.cornerRadius = self.logInButton.bounds.height / 2
        self.logInButton.backgroundColor = Constants.Colours.blueColor
    }
    
    func setUpRegisterLabel() {
        self.registerLabel.textColor = .lightGray
        self.registerLabel.textAlignment = .center
        self.registerLabel.font = UIFont.systemFont(ofSize: 12)
        let attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(string: "Don't have an account? ",
                                                   attributes: [.underlineStyle: 0]))
        attributedString.append(NSAttributedString(string: "Register",
                                                   attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue, .foregroundColor: UIColor.black ]))
        self.registerLabel.attributedText = attributedString
    }
    
    func setUpErrorView() {
        self.errorMessageView.isHidden = true
        self.errorMessageView.backgroundColor = UIColor.red
        self.errorMessageView.layer.cornerRadius = 5
        self.errorMessageLabel.text = "Please enter a valid username and password"
        self.errorMessageLabel.textColor = UIColor.white
        self.errorMessageLabel.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    @IBAction func logInButtonClicked() {
        self.logInButton.isEnabled = false
        self.viewModel?.authenticateLogInCredentials(username: self.usernameTextField?.text,
                                                     password: self.passwordTextField?.text,
                                                     completion: { (error, validLogIn) in
                                                        if validLogIn {
                                                            self.navigateToProfilePage()
                                                        } else {
                                                            if let _ = error {
                                                                self.showErrorMessageAndEnableLogInButton()
                                                            }
                                                        }
        })
    }
    
    func showErrorMessageAndEnableLogInButton() {
        DispatchQueue.main.async {
            self.errorMessageView.isHidden = false
            self.logInButton.isEnabled = true
        }
    }
    
    func navigateToProfilePage() {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(ProfileListViewController(),
                                                          animated: false)
        }
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        // this adds some additional padding to the scrollview when the keyboard is shown
        if let userInfo = notification.userInfo, var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardFrame = self.view.convert(keyboardFrame, from: nil)
            
            var contentInset:UIEdgeInsets = self.scrollView.contentInset
            contentInset.bottom = keyboardFrame.size.height
            scrollView.contentInset = contentInset
        }
    }

    @objc func keyboardWillHide(notification:NSNotification){
        // this removes the additional padding when keyboard is closed
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.usernameTextField {
            self.usernameTextField.endEditing(true)
            self.passwordTextField.becomeFirstResponder()
        } else  if textField == self.passwordTextField {
            self.passwordTextField.endEditing(true)
            self.logInButtonClicked()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // highlighting the selected textfield with a blue border
        if textField == self.usernameTextField {
            self.usernameTextField.layer.borderColor = Constants.Colours.blueColor.cgColor
        } else if textField == self.passwordTextField {
            self.passwordTextField.layer.borderColor = Constants.Colours.blueColor.cgColor
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // removing the highlighting border on textfield
        if textField == self.usernameTextField {
            self.usernameTextField.layer.borderColor = UIColor.clear.cgColor
        } else if textField == self.passwordTextField {
            self.passwordTextField.layer.borderColor = UIColor.clear.cgColor
        }
    }
}
