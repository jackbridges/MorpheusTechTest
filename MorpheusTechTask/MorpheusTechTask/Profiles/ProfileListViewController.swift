//
//  ProfileListViewController.swift
//  MorpheusTechTask
//
//  Created by Jack Bridges on 06/10/2020.
//

import UIKit

class ProfileListViewController: UIViewController {

    @IBOutlet weak var profilesTableView: UITableView!
    
    var viewModel: ProfileViewModelProtocol?
    var profileList: [Profile]? {
        didSet {
            DispatchQueue.main.async {
                self.profilesTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableView()
        self.removeBackButton()
        self.addLogoInNavigationBar()
        self.setBackgroundColour()
        self.viewModel = ProfileViewModel(coreDataService: CoreDataService())
        self.viewModel?.getProfileDetails(completion: { (profileList, error) in
            if let profileList = profileList {
                self.profileList = profileList
            } else {
                if let error = error {
                    self.showAlertWithError(error: error.localizedDescription)
                }
            }
        })
    }
    
    func showAlertWithError(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
              switch action.style{
              case .cancel:
                self.dismiss(animated: false, completion: nil)
              case .default:
                print("default")
              case .destructive:
                print("destructive")
              @unknown default:
                print("default")
              }}))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setBackgroundColour() {
        self.view.backgroundColor = Constants.Colours.backgroundGrayColor
    }
    
    func addLogoInNavigationBar() {
        let logo = UIImage(imageLiteralResourceName: "logo")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView.contentMode = .scaleAspectFit
        imageView.image = logo
        self.navigationItem.titleView = imageView
    }
    
    func removeBackButton() {
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    func registerTableView() {
        self.profilesTableView.delegate = self
        self.profilesTableView.dataSource = self
        self.profilesTableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil),
                                        forCellReuseIdentifier: "ProfileTableViewCell")
    }
}

extension ProfileListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.profileList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let profile = self.profileList?[indexPath.row],
           let cell = self.profilesTableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as? ProfileTableViewCell {
            if let url = URL(string: profile.profile_image) {
                cell.profileImageView.load(url: url)
            }
            cell.profileNameLabel.text = profile.name
            cell.profileDistanceLabel.text = cell.showFormattedDistance(distance: profile.distance_from_user)
            let ratingsFormat = "({NUMRATING})"
            cell.numberOfReviewsLabel.text = ratingsFormat.replacingOccurrences(of: "{NUMRATING}", with: String(profile.num_ratings))
            cell.showStars(rating: profile.star_level)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        
        let label = UILabel()
        label.frame = CGRect(x: 5, y: 5, width: headerView.frame.width, height: headerView.frame.height)
        label.text = "TOP RATED"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.white
        label.backgroundColor = Constants.Colours.blueColor
        label.layer.cornerRadius = 20
        label.layoutIfNeeded()
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

