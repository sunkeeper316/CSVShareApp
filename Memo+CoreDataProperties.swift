//
//  Memo+CoreDataProperties.swift
//  CSVShareApp
//
//  Created by Sun Huang on 2022/3/30.
//
//

import Foundation
import CoreData


extension Memo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Memo> {
        return NSFetchRequest<Memo>(entityName: "Memo")
    }

    @NSManaged public var editTime: Date?
    @NSManaged public var memo: String?
    @NSManaged public var measuredPerson: MeasuredPerson?

}

extension Memo : Identifiable {

}
