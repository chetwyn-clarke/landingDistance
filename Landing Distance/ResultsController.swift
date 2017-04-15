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
    private var _runwaySlope: Double = -2.0 // Hard coded for now, but need to change this to reflect actual data once I have database.
    
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
    
    var runwaySlope: Double {
        get {
            return _runwaySlope
        } set {
            _runwaySlope = newValue
        }
    }
    
    var aircraftWeight: Double {
        get {
            return _aircraftWeight
        } set {
            _aircraftWeight = newValue
        }
    }
    
    var approachSpdAdditive: Double {
        get {
            return _approachSpdAdditive
        } set {
            _approachSpdAdditive = newValue
        }
    }
    
    
    
    
    
    // Functions
    
    
    func attemptCalculation() {
        
        for data in advisoryData {
            
            let weightAdjustment = calculateWeightAdjustment(aircraftWeight: aircraftWeight, data: data)
            
            let altitudeAdjustment = calculateAltitudeAdjustment(airportAltitude: airportAltitude, data: data)
            
            let slopeAdjustment = calculateSlopeAdjustment(runwaySlope: runwaySlope, data: data)
            
            let approachSpeedAdjustment = calculateApproachSpeedAdjustment(adjustmentToRefSpd: approachSpdAdditive, data: data)
            
            //wind adjustment, temp adjustment, reverse thrust adjustment
            
            let landingDistance = data.refDistance + weightAdjustment + altitudeAdjustment + slopeAdjustment + approachSpeedAdjustment
            
            print("Calculated landing distance: \(landingDistance)")
            
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
        
        var altitudeAdjustment: Double = 0
        
        if airportAltitude <= 8000 {
            altitudeAdjustment = (data.altAdjStd / 1000) * airportAltitude
            
        } else if airportAltitude > 8000 {
            altitudeAdjustment = (data.altAdjStd * 8) + ((airportAltitude - 8000) * (data.altAdjHigh / 1000))
            
        }
        
        print("Altitude adjustment: \(altitudeAdjustment)")
        
        return altitudeAdjustment
    }
    
    // TO DO: Wind adjustment function
    
    func calculateSlopeAdjustment(runwaySlope: Double, data: AdvisoryData) -> Double {
        
        var slopeAdjustment: Double = 0
        
        if runwaySlope > 0 {
            slopeAdjustment = runwaySlope * data.slopeAdjUp
            
        } else if runwaySlope < 0 {
            slopeAdjustment = runwaySlope * data.slopeAdjDown
            
        } else {
            
        }
        
        print("Uphill slope factor: \(data.slopeAdjUp)")
        print("Downhill slope factor: \(data.slopeAdjDown)")
        print("Slope adjustment: \(round(slopeAdjustment))")
        
        return slopeAdjustment
        
    }
    
    //TO DO: Temperature adjustment
    
    func calculateApproachSpeedAdjustment(adjustmentToRefSpd: Double, data: AdvisoryData) -> Double {
        
        let refAdjustment: Double = adjustmentToRefSpd * (data.appSpeedAdj / 5)
        
        print("Approach speed adjustment factor: \(data.appSpeedAdj)")
        print("Approach speed adustment: \(round(refAdjustment))")
        
        return refAdjustment
        
    }
    
}
