//
//  CustomErrors.swift
//  MorpheusTechTask
//
//  Created by Jack Bridges on 07/10/2020.
//

import Foundation

enum LogInError: Error {
    case usernameTooShort
    case passwordTooShort
    case logInDetailsIncorrect
    case bearerTokenNotSaved
    case logInFailed
}

enum CoreDataError: Error {
    case couldNotSaveToContainer
    case couldNotGetAuthToken
    case couldNotDeleteTokens
}
