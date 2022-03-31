//
//  Measurement_data+CoreDataProperties.swift
//  CSVShareApp
//
//  Created by Sun Huang on 2022/3/30.
//
//

import Foundation
import CoreData


extension Measurement_data {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Measurement_data> {
        return NSFetchRequest<Measurement_data>(entityName: "Measurement_data")
    }

    @NSManaged public var date: Date?
    @NSManaged public var deviceId: Int16
    @NSManaged public var measuredPerson: MeasuredPerson?
    @NSManaged public var measurementFunc: NSSet?

}

// MARK: Generated accessors for measurementFunc
extension Measurement_data {

    @objc(addMeasurementFuncObject:)
    @NSManaged public func addToMeasurementFunc(_ value: Measurement_func)

    @objc(removeMeasurementFuncObject:)
    @NSManaged public func removeFromMeasurementFunc(_ value: Measurement_func)

    @objc(addMeasurementFunc:)
    @NSManaged public func addToMeasurementFunc(_ values: NSSet)

    @objc(removeMeasurementFunc:)
    @NSManaged public func removeFromMeasurementFunc(_ values: NSSet)

}

extension Measurement_data : Identifiable {

}
