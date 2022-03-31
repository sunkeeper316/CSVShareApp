//
//  Account+CoreDataProperties.swift
//  CSVShareApp
//
//  Created by Sun Huang on 2022/3/30.
//
//

import Foundation
import CoreData


extension Account {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Account> {
        return NSFetchRequest<Account>(entityName: "Account")
    }

    @NSManaged public var account: String?
    @NSManaged public var creatTime: Date?
    @NSManaged public var password: String?
    @NSManaged public var permission: Int16
    @NSManaged public var measuredPerson: NSSet?

}

// MARK: Generated accessors for measuredPerson
extension Account {

    @objc(addMeasuredPersonObject:)
    @NSManaged public func addToMeasuredPerson(_ value: MeasuredPerson)

    @objc(removeMeasuredPersonObject:)
    @NSManaged public func removeFromMeasuredPerson(_ value: MeasuredPerson)

    @objc(addMeasuredPerson:)
    @NSManaged public func addToMeasuredPerson(_ values: NSSet)

    @objc(removeMeasuredPerson:)
    @NSManaged public func removeFromMeasuredPerson(_ values: NSSet)

}

extension Account : Identifiable {

}
