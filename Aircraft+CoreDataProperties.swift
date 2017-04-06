//
//  Aircraft+CoreDataProperties.swift
//  Landing Distance
//
//  Created by Chetwyn on 4/5/17.
//  Copyright © 2017 Clarke Enterprises. All rights reserved.
//

import Foundation
import CoreData


extension Aircraft {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Aircraft> {
        return NSFetchRequest<Aircraft>(entityName: "Aircraft")
    }

    @NSManaged public var type: String?
    @NSManaged public var engine: String?
    @NSManaged public var configuration: NSSet?
    @NSManaged public var advisoryData: NSSet?

}

// MARK: Generated accessors for configuration
extension Aircraft {

    @objc(addConfigurationObject:)
    @NSManaged public func addToConfiguration(_ value: Configuration)

    @objc(removeConfigurationObject:)
    @NSManaged public func removeFromConfiguration(_ value: Configuration)

    @objc(addConfiguration:)
    @NSManaged public func addToConfiguration(_ values: NSSet)

    @objc(removeConfiguration:)
    @NSManaged public func removeFromConfiguration(_ values: NSSet)

}

// MARK: Generated accessors for advisoryData
extension Aircraft {

    @objc(addAdvisoryDataObject:)
    @NSManaged public func addToAdvisoryData(_ value: AdvisoryData)

    @objc(removeAdvisoryDataObject:)
    @NSManaged public func removeFromAdvisoryData(_ value: AdvisoryData)

    @objc(addAdvisoryData:)
    @NSManaged public func addToAdvisoryData(_ values: NSSet)

    @objc(removeAdvisoryData:)
    @NSManaged public func removeFromAdvisoryData(_ values: NSSet)

}
