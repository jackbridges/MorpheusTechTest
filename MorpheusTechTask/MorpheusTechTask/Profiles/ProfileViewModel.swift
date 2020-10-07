//
//  ProfileViewModel.swift
//  MorpheusTechTask
//
//  Created by Jack Bridges on 06/10/2020.
//

import Foundation
import UIKit

protocol ProfileViewModelProtocol {
    func getProfileDetails(completion: @escaping (_ profileList: [Profile]?, _ error: Error?) -> Void)
}

class ProfileViewModel: ProfileViewModelProtocol {
        
    var coreDataService: CoreDataService?
    
    init(coreDataService: CoreDataService) {
        self.coreDataService = coreDataService
    }
    
    func getProfileDetails(completion: @escaping (_ profileList: [Profile]?, _ error: Error?) -> Void) {
        let session = URLSession.shared
        if let url = URL(string: "https://ypznjlmial.execute-api.us-east-1.amazonaws.com/DummyProfileList") {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            do {
                request.setValue(try self.coreDataService?.getAuthToken(), forHTTPHeaderField: "authorization")
            } catch {
                completion(nil, error)
            }
            
            let task = session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completion(nil, error)
                }
                guard let data = data else {
                    completion(nil, error)
                    return
                }

                let profileDetails = try? JSONDecoder().decode(ProfileList.self, from: data)
                if let profileArray = profileDetails?.data.profiles {
                    completion(self.getSortedArray(profileArray: profileArray), nil)
                }
            }
            task.resume()
        }
    }
    
    func getSortedArray(profileArray: [Profile]) -> [Profile] {
        let sortedArray = profileArray.sorted(by: {
            $0.star_level > $1.star_level
        })
        return sortedArray
    }
}
