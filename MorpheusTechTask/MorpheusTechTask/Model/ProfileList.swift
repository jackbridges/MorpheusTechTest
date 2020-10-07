//
//  ProfileList.swift
//  MorpheusTechTask
//
//  Created by Jack Bridges on 07/10/2020.
//

import Foundation

struct ProfileList: Codable {
    var data: ProfileData
}

struct ProfileData: Codable {
    var user_message: String
    var profiles: [Profile]
}

struct Profile: Codable {
    var name: String
    var star_level: Int
    var distance_from_user: String
    var num_ratings: Int
    var profile_image: String
}
