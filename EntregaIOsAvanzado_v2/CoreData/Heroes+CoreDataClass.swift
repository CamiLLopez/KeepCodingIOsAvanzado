//
//  Heroes+CoreDataClass.swift
//  EntregaIOsAvanzado_v2
//
//  Created by Camila Laura Lopez on 23/2/23.
//

import Foundation
import CoreData

@objc(Heroes)
public class Heroes: NSManagedObject {
    
}

public extension Heroes {
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<Heroes> {
        return NSFetchRequest<Heroes>(entityName: "Hero")
    }
    
    @NSManaged var name: String?
    @NSManaged var details: String?
    @NSManaged var photo: String?
    @NSManaged var id: UUID
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
}

