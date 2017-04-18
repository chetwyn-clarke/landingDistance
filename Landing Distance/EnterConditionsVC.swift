//
//  EnterConditionsVC.swift
//  Landing Distance
//
//  Created by Chetwyn on 4/10/17.
//  Copyright © 2017 Clarke Enterprises. All rights reserved.
//

import UIKit

class EnterConditionsVC: UIViewController {
    
    private var _advisoryData: NSSet!
    
    //Text fields
    
    @IBOutlet weak var altitude: UITextField!
    @IBOutlet weak var windDirection: UITextField!
    @IBOutlet weak var windSpeed: UITextField!
    @IBOutlet weak var windGusts: UITextField!
    @IBOutlet weak var temperature: UITextField!
    
    //@IBOutlet weak var slope: UITextField!  (for future implementation)
    
    @IBOutlet weak var runwayHeading: UITextField!
    @IBOutlet weak var aircraftWeight: UITextField!
    @IBOutlet weak var approachSpdAdditive: UITextField!
    
    //Buttons
    
    @IBOutlet weak var dryBtn: UIButton!
    @IBOutlet weak var goodBtn: UIButton!
    @IBOutlet weak var goodToMediumBtn: UIButton!
    @IBOutlet weak var mediumBtn: UIButton!
    @IBOutlet weak var mediumToPoorBtn: UIButton!
    @IBOutlet weak var poorBtn: UIButton!
    @IBOutlet weak var twoReversersBtn: UIButton!
    @IBOutlet weak var oneReverserBtn: UIButton!
    @IBOutlet weak var noReversersBtn: UIButton!
    @IBOutlet weak var calculateBtn: UIButton!
    
    var advisoryData: NSSet {
        get {
            return _advisoryData
        } set {
            _advisoryData = newValue
        }
    }
    
    var alertString: String = ""
    
    //For shortcut purposes.
    let rc = ResultsController.controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //How can I transfer these to a view swift file?
    func selectButton (button: UIButton) {
        
        button.isSelected = true
        button.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)
        let titleColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
        button.setTitleColor(titleColor, for: .selected)
        
    }
    
    func deSelectButton (button: UIButton) {
        
        button.isSelected = false
        button.tintColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)
        button.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 0.5)
        
    }
    
    func gatherInfoForResultsController() {
        
        rc.advisoryData = Array(advisoryData) as! [AdvisoryData]
        
        if let altitude = altitude.text {
            rc.airportAltitude = Double(altitude)!
        } else {
            alertString.append("Please enter airport altitude.\n")
        }
        
        if let windDirection = windDirection.text {
            rc.windDirection = Double(windDirection)!
        } else {
            alertString.append("Please enter wind direction.\n")
        }
        
        if let windSpeed = windSpeed.text {
            rc.windSpeed = Double(windSpeed)!
        } else {
            alertString.append("Please enter wind speed.\n")
        }
        
        if let windGust = windGusts.text {
            rc.windGust = Double(windGust)!
        } else {
            rc.windGust = 0
        }
        
        if let temperature = temperature.text {
            rc.airportTemperature = Double(temperature)!
        } else {
            alertString.append("Please enter airport temperature.\n")
        }
        
        if let runwayHeading = runwayHeading.text {
            rc.runwayHeading = Double(runwayHeading)!
        } else {
            alertString.append("Please enter runway heading.\n")
        }
        
        //Hard code the runway slope
        rc.runwaySlope = -2.0
        
        if let weight = aircraftWeight.text {
            rc.aircraftWeight = Double(weight)!
        } else {
            alertString.append("Please enter aircraft weight.\n")
        }
        
        if let approachSpeedAdditive = approachSpdAdditive.text {
            rc.approachSpdAdditive = Double(approachSpeedAdditive)!
        } else {
            alertString.append("Please enter wind correction to VREF.\n")
        }
        
        if dryBtn.isSelected {
            rc.runwayCondition = "Dry"
        } else if goodBtn.isSelected {
            rc.runwayCondition = "Good"
        } else if goodToMediumBtn.isSelected {
            rc.runwayCondition = "Good to Medium"
        } else if mediumBtn.isSelected {
            rc.runwayCondition = "Medium"
        } else if mediumToPoorBtn.isSelected {
            rc.runwayCondition = "Medium to Poor"
        } else if poorBtn.isSelected {
            rc.runwayCondition = "Poor"
        }
        
        if oneReverserBtn.isSelected {
            rc.reversersAvailable = 1
        } else if noReversersBtn.isSelected {
            rc.reversersAvailable = 0
        }
        
    }
    
    @IBAction func brakingActionBtnPressed(_ sender: UIButton) {
        
        switch sender {
            
        case dryBtn:
            
            selectButton(button: dryBtn)
            deSelectButton(button: goodBtn)
            deSelectButton(button: goodToMediumBtn)
            deSelectButton(button: mediumBtn)
            deSelectButton(button: mediumToPoorBtn)
            deSelectButton(button: poorBtn)
            
        case goodBtn:
            
            selectButton(button: goodBtn)
            deSelectButton(button: dryBtn)
            deSelectButton(button: goodToMediumBtn)
            deSelectButton(button: mediumBtn)
            deSelectButton(button: mediumToPoorBtn)
            deSelectButton(button: poorBtn)
            
        case goodToMediumBtn:
            
            selectButton(button: goodToMediumBtn)
            deSelectButton(button: goodBtn)
            deSelectButton(button: dryBtn)
            deSelectButton(button: mediumBtn)
            deSelectButton(button: mediumToPoorBtn)
            deSelectButton(button: poorBtn)
            
        case mediumBtn:
            
            selectButton(button: mediumBtn)
            deSelectButton(button: goodBtn)
            deSelectButton(button: goodToMediumBtn)
            deSelectButton(button: dryBtn)
            deSelectButton(button: mediumToPoorBtn)
            deSelectButton(button: poorBtn)
            
        case mediumToPoorBtn:
            
            selectButton(button: mediumToPoorBtn)
            deSelectButton(button: goodBtn)
            deSelectButton(button: goodToMediumBtn)
            deSelectButton(button: mediumBtn)
            deSelectButton(button: dryBtn)
            deSelectButton(button: poorBtn)
            
        case poorBtn:
            
            selectButton(button: poorBtn)
            deSelectButton(button: goodBtn)
            deSelectButton(button: goodToMediumBtn)
            deSelectButton(button: mediumBtn)
            deSelectButton(button: mediumToPoorBtn)
            deSelectButton(button: dryBtn)
            
        default:
            
            deSelectButton(button: dryBtn)
            deSelectButton(button: goodBtn)
            deSelectButton(button: goodToMediumBtn)
            deSelectButton(button: mediumBtn)
            deSelectButton(button: mediumToPoorBtn)
            deSelectButton(button: poorBtn)
            
        }
    }
    
    @IBAction func reverseThrustBtnPressed(_ sender: UIButton) {
        
        switch sender {
            
        case twoReversersBtn:
            selectButton(button: twoReversersBtn)
            deSelectButton(button: oneReverserBtn)
            deSelectButton(button: noReversersBtn)
            
        case oneReverserBtn:
            selectButton(button: oneReverserBtn)
            deSelectButton(button: twoReversersBtn)
            deSelectButton(button: noReversersBtn)
            
        case noReversersBtn:
            selectButton(button: noReversersBtn)
            deSelectButton(button: oneReverserBtn)
            deSelectButton(button: twoReversersBtn)
            
        default:
            deSelectButton(button: twoReversersBtn)
            deSelectButton(button: oneReverserBtn)
            deSelectButton(button: noReversersBtn)
            
        }
        
    }
    
    @IBAction func onCalculateBtnPressed(_ sender: Any) {
        
        gatherInfoForResultsController()
        
        if alertString.isEmpty {
            rc.attemptCalculation()
            //Do segue to results display page.
        } else {
            // throw the alert
        }
        
    }
    
    
    


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
