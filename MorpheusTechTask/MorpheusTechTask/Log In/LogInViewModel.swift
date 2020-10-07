//
//  LogInViewModel.swift
//  MorpheusTechTask
//
//  Created by Jack Bridges on 05/10/2020.
//

import Foundation
import UIKit

protocol LogInViewModelProtocol {
    func authenticateLogInCredentials(username: String?,
                                      password:String?,
                                      completion: @escaping (_ error: Error?, _ valid: Bool) -> Void)
}

class LogInViewModel: LogInViewModelProtocol {
    
    var coreDataService: CoreDataService?
    
    init(coreDataService: CoreDataService) {
        self.coreDataService = coreDataService
    }
    
    func authenticateLogInCredentials(username: String?,
                                      password:String?,
                                      completion: @escaping (_ error: Error?, _ valid: Bool) -> Void) {
        guard let username = username else {
            completion(LogInError.usernameTooShort, false)
            return
        }
        guard let password = password else {
            completion(LogInError.passwordTooShort, false)
            return
        }
        
        let session = URLSession.shared
        if let url = URL(string: "https://ho0lwtvpzh.execute-api.us-east-1.amazonaws.com/DummyLogin") {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let bodyJSON = [
                "username": username,
                "password": password
            ]
            
            if let jsonData = try? JSONSerialization.data(withJSONObject: bodyJSON) {
                
                request.httpBody = jsonData
                let task = session.uploadTask(with: request, from: jsonData) { data, response, error in
                    if let error = error {
                        completion(error, false)
                    }
                    guard let data = data else {
                        return
                    }
                    
                    var sessionAuthorization: SessionAuthorization?
                    
                    do {
                        sessionAuthorization = try JSONDecoder().decode(SessionAuthorization.self, from: data)
                    } catch {
                        completion(LogInError.logInFailed, false)
                    }
                    
                    do {
                        if let authorisation = sessionAuthorization {
                            try self.coreDataService?.saveAuthTokenToContainer(authToken: authorisation.logInData.auth_token)
                            completion(nil, true)
                        }
                    } catch {
                        completion(LogInError.bearerTokenNotSaved, false)
                    }
                }
                task.resume()
            }
        }
    }
}
