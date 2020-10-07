//
//  CoreDataService.swift
//  MorpheusTechTask
//
//  Created by Jack Bridges on 07/10/2020.
//

import Foundation
import CoreData
import UIKit

class CoreDataService {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveAuthTokenToContainer(authToken: String) throws {
        try self.deletePreviousTokens()
        let authorisation = Authorization(context: self.context)
        authorisation.authToken = authToken

        do {
            try self.context.save()
        } catch {
            throw CoreDataError.couldNotSaveToContainer
        }
    }
    
    func getAuthToken() throws -> String {
        do {
            let fetchRequest = Authorization.fetchRequest() as NSFetchRequest<Authorization>
            let token = try self.context.fetch(fetchRequest)
            return token.first?.authToken ?? ""
        } catch {
            throw CoreDataError.couldNotGetAuthToken
        }
    }
    
    func deletePreviousTokens() throws {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Authorization")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            for managedObject in results {
                if let managedObjectData: NSManagedObject = managedObject as? NSManagedObject {
                    context.delete(managedObjectData)
                }
            }
        } catch {
            throw CoreDataError.couldNotDeleteTokens
        }
    }
}
