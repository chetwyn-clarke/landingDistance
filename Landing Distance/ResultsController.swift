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
    private var _runwayHeading: Double!
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
        
    var windDirection: Double {
        get {
            return _windDirection
        } set {
            _windDirection = newValue
        }
    }
    
    var windSpeed: Double {
        get {
            return _windSpeed
        } set {
            _windSpeed = newValue
        }
    }
    
    var windGust: Double {
        get {
            return _windGust
        } set {
            _windGust = newValue
        }
    }
    
    var airportTemperature: Double {
        get {
            return _temperature
        } set {
            _temperature = newValue
        }
    }
    
    var runwayHeading: Double {
        get {
            return _runwayHeading
        } set {
            _runwayHeading = newValue
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
        
        //Need to get the advisory data.
        
        for data in advisoryData {
            
            let weightAdjustment = calculateWeightAdjustment(aircraftWeight: _aircraftWeight, data: data)
            
            let altitudeAdjustment = calculateAltitudeAdjustment(airportAltitude: _airportAltitude, data: data)
            
            let windAdjustment = calculateWindAdjustment(runwayHeading: _runwayHeading, data: data)
            
            let slopeAdjustment = calculateSlopeAdjustment(runwaySlope: _runwaySlope, data: data)
            
            let temperatureAdjustment = calculateTemperatureAdjustment(airportElevation: _airportAltitude, airportTemperature: _temperature, data: data)
            
            let approachSpeedAdjustment = calculateApproachSpeedAdjustment(adjustmentToRefSpd: _approachSpdAdditive, data: data)
            
            //reverse thrust adjustment
            
            let landingDistance = data.refDistance + weightAdjustment + altitudeAdjustment + windAdjustment + slopeAdjustment + temperatureAdjustment + approachSpeedAdjustment
            
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
    
    // Note: Wind Adjustment consists of two functions:  calculating windComponents, and then calculating the windAdjustment.
    
    func calculateWindComponents(runwayHeading: Double, windDirection: Double, windSpeed: Double) -> (headwind: Double, tailwind: Double, crosswind: Double) {
        
        var headwind: Double = 0
        var tailwind: Double = 0
        
        let windAngle: Double = abs(windDirection - runwayHeading)
        
        let windAngleInRadians = windAngle * 0.01745
        
        //Alternative is to create a nested function to find the most precise radians value.
        
        let parallelWind = abs(cos(windAngleInRadians) * windSpeed)
        
        if windAngle == 90 || windAngle == 270 {
            
            //Do nothing; headwind or tailwind = 0
            
        } else if windAngle < 90 || windAngle > 270 {
            //Dealing with a headwind, and round downwards.
            headwind = floor(parallelWind)
            
        } else {
            //Dealing with a tailwind, and round upwards.
            tailwind = ceil(parallelWind)
        }
        
        let crosswind = abs(sin(windAngleInRadians) * windSpeed)
        
        print("Headwind: \(headwind); tailwind: \(tailwind), crosswind: \(crosswind)")
        
        return (headwind, tailwind, crosswind)
        
    }
    
    func calculateWindAdjustment(runwayHeading: Double, data: AdvisoryData) -> Double {
        
        var windAdjustment: Double = 0
        
        let windGroup = calculateWindComponents(runwayHeading: runwayHeading, windDirection: _windDirection, windSpeed: _windSpeed)
        
        if windGroup.headwind == 0 && windGroup.tailwind == 0 {
            
            windAdjustment = 0
            
        } else if windGroup.headwind != 0 {
            
            windAdjustment = (windGroup.headwind * (data.windAdjHeadwind / 10))
            
        } else if windGroup.tailwind != 0 {
            
            windAdjustment = (windGroup.tailwind * (data.windAdjTailwind / 10))
            
        }
        
        print("Wind adjustment: \(windAdjustment)")
        
        return windAdjustment
        
    }
    
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
    
    func calculateTemperatureAdjustment(airportElevation: Double, airportTemperature: Double, data: AdvisoryData) -> Double {
        
        var temperatureAdjustment: Double = 0
        
        func calculateISATemperature() -> Double {
            
            let lapseRatePerFoot: Double = (2.00 / 1000)
            
            // Most accurate lapse rate is 1.98 / 1000
            
            let isa_Temperature_At_Airport = (15 - (airportElevation * lapseRatePerFoot))
            
            print("ISA temperature at airport: \(isa_Temperature_At_Airport)")
            
            return isa_Temperature_At_Airport
        }
        
        let isa_Temperature_At_Airport = calculateISATemperature()
        
        let temperatureDifference = airportTemperature - isa_Temperature_At_Airport
        
        if temperatureDifference > 0 {
            
            temperatureAdjustment = (abs(temperatureDifference) * (data.tempAdjAbvISA / 10))
            
        } else if temperatureDifference < 0 {
            
            temperatureAdjustment = (abs(temperatureDifference) * (data.tempAdjBlwISA / 10))
            
        } else {
            
            //Do nothing, tempAdjustment = 0
            
        }
        
        print("Temperature adjustment: \(temperatureAdjustment)")
        
        return temperatureAdjustment
        
    }
    
    func calculateApproachSpeedAdjustment(adjustmentToRefSpd: Double, data: AdvisoryData) -> Double {
        
        let refAdjustment: Double = adjustmentToRefSpd * (data.appSpeedAdj / 5)
        
        print("Approach speed adjustment factor: \(data.appSpeedAdj)")
        print("Approach speed adustment: \(round(refAdjustment))")
        
        return refAdjustment
        
    }
    
    // TO DO: Reverse thrust adjustment
    
}
