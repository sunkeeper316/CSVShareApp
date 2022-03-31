//
//  MeasuredPerson+CoreDataProperties.swift
//  CSVShareApp
//
//  Created by Sun Huang on 2022/3/30.
//
//

import Foundation
import CoreData


extension MeasuredPerson {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MeasuredPerson> {
        return NSFetchRequest<MeasuredPerson>(entityName: "MeasuredPerson")
    }

    @NSManaged public var birthday: Date?
    @NSManaged public var creatTime: Date?
    @NSManaged public var gender: Bool
    @NSManaged public var heightX1000: Int64
    @NSManaged public var idCode: String?
    @NSManaged public var lastdate: Date?
    @NSManaged public var lastX10: Int16
    @NSManaged public var name: String?
    @NSManaged public var account: Account?
    @NSManaged public var measurementData: NSSet?
    @NSManaged public var memo: NSSet?

}

// MARK: Generated accessors for measurementData
extension MeasuredPerson {

    @objc(addMeasurementDataObject:)
    @NSManaged public func addToMeasurementData(_ value: Measurement_data)

    @objc(removeMeasurementDataObject:)
    @NSManaged public func removeFromMeasurementData(_ value: Measurement_data)

    @objc(addMeasurementData:)
    @NSManaged public func addToMeasurementData(_ values: NSSet)

    @objc(removeMeasurementData:)
    @NSManaged public func removeFromMeasurementData(_ values: NSSet)

}

// MARK: Generated accessors for memo
extension MeasuredPerson {

    @objc(addMemoObject:)
    @NSManaged public func addToMemo(_ value: Memo)

    @objc(removeMemoObject:)
    @NSManaged public func removeFromMemo(_ value: Memo)

    @objc(addMemo:)
    @NSManaged public func addToMemo(_ values: NSSet)

    @objc(removeMemo:)
    @NSManaged public func removeFromMemo(_ values: NSSet)

}

extension MeasuredPerson : Identifiable {

}
