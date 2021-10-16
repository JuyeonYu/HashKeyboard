//
//  Tag+CoreDataProperties.swift
//  hashKeyboard
//
//  Created by Juyeon on 2021/10/16.
//
//

import Foundation
import CoreData


extension Tag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag")
    }

    @NSManaged public var id: UUID
    @NSManaged public var value: String
    @NSManaged public var key: String

}

extension Tag : Identifiable {

}
