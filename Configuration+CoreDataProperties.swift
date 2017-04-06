//
//  Configuration+CoreDataProperties.swift
//  Landing Distance
//
//  Created by Chetwyn on 4/5/17.
//  Copyright © 2017 Clarke Enterprises. All rights reserved.
//

import Foundation
import CoreData


extension Configuration {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Configuration> {
        return NSFetchRequest<Configuration>(entityName: "Configuration")
    }

    @NSManaged public var name: String?
    @NSManaged public var type: String?
    @NSManaged public var flapSetting: String?
    @NSManaged public var notes: String?
    @NSManaged public var advisoryData: NSSet?
    @NSManaged public var aircraft: Aircraft?

}

// MARK: Generated accessors for advisoryData
extension Configuration {

    @objc(addAdvisoryDataObject:)
    @NSManaged public func addToAdvisoryData(_ value: AdvisoryData)

    @objc(removeAdvisoryDataObject:)
    @NSManaged public func removeFromAdvisoryData(_ value: AdvisoryData)

    @objc(addAdvisoryData:)
    @NSManaged public func addToAdvisoryData(_ values: NSSet)

    @objc(removeAdvisoryData:)
    @NSManaged public func removeFromAdvisoryData(_ values: NSSet)

}
