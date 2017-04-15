//
//  ResultsController.swift
//  Landing Distance
//
//  Created by Chetwyn on 4/14/17.
//  Copyright © 2017 Clarke Enterprises. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ResultsController {
    
    static let instance = ResultsController()
    
    // Variables needed:
    
    private var _advisoryData: [AdvisoryData]!
    
    private var _airportAltitude: Double!
    private var _windDirection: Double!
    private var _windSpeed: Double!
    private var _windGust: Double!
    private var _temperature: Double!
    private var _landingRunway: Double!
    
    private var _aircraftWeight: Double!
    private var _approachSpdAdditive: Double!
    
    var advisoryData: [AdvisoryData] {
        get {
            return _advisoryData
        } set {
            _advisoryData = newValue
        }
    }
    
    var airportAltitude: Double {
        get {
            return _airportAltitude
        } set {
            _airportAltitude = newValue
        }
    }
    
    var aircraftWeight: Double {
        get {
            return _aircraftWeight
        } set {
            _aircraftWeight = newValue
        }
    }
    
    
    
    
    // Functions
    
    
    func attemptCalculation() {
        
        for data in advisoryData {
            
            var weightAdjustment = calculateWeightAdjustment(aircraftWeight: aircraftWeight, data: data)
            
            //alt adjustment, wind adjustment, slope adjustment, temp adjustment, approach speed adjustmeent, reverse thrust adjustment
            
        }
    }
    
    func calculateWeightAdjustment(aircraftWeight: Double, data: AdvisoryData) -> Double {
        
        // First, select the correct adjustment factor.
        
        var weightAdjustment: Double
        var weightAdjFactor: Double = 0
        
        if aircraftWeight < data.refWeight {
            weightAdjFactor = data.weightAdjBlwRef
            
        } else if aircraftWeight >= data.refWeight {
            weightAdjFactor = data.weightAdjAbvRef
            
        }
        
        // Find difference between aircraft weight and reference weight.
        
        let weightDifference = abs(aircraftWeight - data.refWeight)
        
        // Determine the correction
        
        weightAdjustment = (weightDifference * (weightAdjFactor / 10000))
        
        print("Weight adjustment: \(round(weightAdjustment))")
        
        return weightAdjustment
        
    }
    
    func calculateAltitudeAdjustment(airportAltitude: Double, data: AdvisoryData) -> Double {
        
        return 0.0
    }
    
    
}
