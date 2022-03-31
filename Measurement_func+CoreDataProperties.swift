//
//  Measurement_func+CoreDataProperties.swift
//  CSVShareApp
//
//  Created by Sun Huang on 2022/3/30.
//
//

import Foundation
import CoreData


extension Measurement_func {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Measurement_func> {
        return NSFetchRequest<Measurement_func>(entityName: "Measurement_func")
    }

    @NSManaged public var func_Id: Int16
    @NSManaged public var numberX10: Int64
    @NSManaged public var times: Int16
    @NSManaged public var measurementData: Measurement_data?

}

extension Measurement_func : Identifiable {

}
