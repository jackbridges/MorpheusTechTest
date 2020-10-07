//
//  SessionAuthorization.swift
//  MorpheusTechTask
//
//  Created by Jack Bridges on 07/10/2020.
//

import Foundation

struct SessionAuthorization: Codable {
    var logInData: LogInData
    
    enum CodingKeys: String, CodingKey {
        case logInData = "data"
    }
}

struct LogInData: Codable {
    var auth_token: String
}
