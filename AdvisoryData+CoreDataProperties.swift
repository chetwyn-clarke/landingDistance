//
//  AdvisoryData+CoreDataProperties.swift
//  Landing Distance
//
//  Created by Chetwyn on 4/5/17.
//  Copyright © 2017 Clarke Enterprises. All rights reserved.
//

import Foundation
import CoreData


extension AdvisoryData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AdvisoryData> {
        return NSFetchRequest<AdvisoryData>(entityName: "AdvisoryData")
    }

    @NSManaged public var brakeAction: String?
    @NSManaged public var brakeConfiguration: String?
    @NSManaged public var refDistance: Double
    @NSManaged public var refWeight: Double
    @NSManaged public var weightAdjAbvRef: Double
    @NSManaged public var weightAdjBlwRef: Double
    @NSManaged public var altAdjStd: Double
    @NSManaged public var altAdjHigh: Double
    @NSManaged public var windAdjHeadwind: Double
    @NSManaged public var windAdjTailwind: Double
    @NSManaged public var slopeAdjUp: Double
    @NSManaged public var slopeAdjDown: Double
    @NSManaged public var tempAdjAbvISA: Double
    @NSManaged public var tempAdjBlwISA: Double
    @NSManaged public var refSpeed: String?
    @NSManaged public var appSpeedAdj: Double
    @NSManaged public var revThrustAdjOneRev: Double
    @NSManaged public var revThrustAdjNoRev: Double
    @NSManaged public var aircraft: Aircraft?
    @NSManaged public var configuration: Configuration?

}
