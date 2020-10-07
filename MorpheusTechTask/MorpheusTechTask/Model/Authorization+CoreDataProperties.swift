//
//  Authorization+CoreDataProperties.swift
//  MorpheusTechTask
//
//  Created by Jack Bridges on 06/10/2020.
//
//

import Foundation
import CoreData


extension Authorization {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Authorization> {
        return NSFetchRequest<Authorization>(entityName: "Authorization")
    }

    @NSManaged public var authToken: String?

}

extension Authorization : Identifiable {

}
