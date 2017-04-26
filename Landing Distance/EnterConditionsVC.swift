//
//  EnterConditionsVC.swift
//  Landing Distance
//
//  Created by Chetwyn on 4/10/17.
//  Copyright © 2017 Clarke Enterprises. All rights reserved.
//

import UIKit
import CoreData

class EnterConditionsVC: UIViewController {
    
    //MARK: - IBOutlets
    
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
    
    
    
    //MARK: - Variables
    
    private var _advisoryData: NSSet!
    
    var advisoryData: NSSet! {
        get {
            return _advisoryData
        } set {
            _advisoryData = newValue
        }
    }
    
    var alertString: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    //MARK: - Set values in Results Controller
    
    let rc = ResultsController.controller
    
    func gatherInfoForResultsController() {
        
        rc.advisoryData = advisoryData
        
        if let altitude = altitude.text {
            if let dAltitude = Double(altitude) {
                rc.airportAltitude = dAltitude
            } else {
                alertString.append("Please enter airport altitude.\n")
            }
        }
        
        if let windDirection = windDirection.text {
            if let dWindDirection = Double(windDirection) {
                rc.windDirection = dWindDirection
            } else {
                alertString.append("Please enter wind direction.\n")
            }
        }
        
        if let windSpeed = windSpeed.text {
            if let dWindSpeed = Double(windSpeed) {
                rc.windSpeed = dWindSpeed
            } else {
                alertString.append("Please enter wind speed.\n")
            }
        }
        
        if let windGust = windGusts.text {
            if let dWindGust = Double(windGust) {
                rc.windGust = dWindGust
            } else {
                rc.windGust = 0
            }
        }
        
        if let temperature = temperature.text {
            if let dTemperature = Double(temperature) {
                rc.airportTemperature = dTemperature
            } else {
                alertString.append("Please enter airport temperature.\n")
            }
        }
        
        if let runwayHeading = runwayHeading.text {
            if let dRunwayHeading = Double(runwayHeading) {
                rc.runwayHeading = dRunwayHeading
            } else {
                alertString.append("Please enter runway heading.\n")
            }
        }
        
        //Hard code the runway slope
        rc.runwaySlope = -2.0
        
        if let weight = aircraftWeight.text {
            if let dWeight = Double(weight) {
                rc.aircraftWeight = dWeight
            } else {
                alertString.append("Please enter aircraft weight.\n")
            }
        }
        
        if let approachSpeedAdditive = approachSpdAdditive.text {
            if let dAdditive = Double(approachSpeedAdditive) {
                rc.approachSpdAdditive = dAdditive
            } else {
                alertString.append("Please enter wind correction to VREF.\n")
            }
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
        } else {
            alertString.append("Please select the runway condition.\n")
        }
        
        if twoReversersBtn.isSelected {
            rc.reversersAvailable = 2
        } else if oneReverserBtn.isSelected {
            rc.reversersAvailable = 1
        } else if noReversersBtn.isSelected {
            rc.reversersAvailable = 0
        } else {
            alertString.append("Please select the amount of thrust reversers available.\n")
        }
        
        print("Alert string: \(alertString)")
        
    }
    
    
    
    //MARK: - IBActions
    
    @IBAction func brakingActionBtnPressed(_ sender: UIButton) {
        
        let buttons: [UIButton] = [dryBtn, goodBtn, goodToMediumBtn, mediumBtn, mediumToPoorBtn, poorBtn]
        
        for button in buttons {
            
            if button == sender {
                selectButton(button: button)
            } else if button != sender {
                deSelectButton(button: button)
            }
        }
    }
    
    @IBAction func reverseThrustBtnPressed(_ sender: UIButton) {
        
        let buttons: [UIButton] = [twoReversersBtn, oneReverserBtn, noReversersBtn]
        
        for button in buttons {
            
            if button == sender {
                selectButton(button: button)
            } else if button != sender {
                deSelectButton(button: button)
            }
        }
    }
    
    @IBAction func onCalculateBtnPressed(_ sender: Any) {
        
        gatherInfoForResultsController()
        
        if alertString.isEmpty {
            rc.attemptCalculation()
            print("Calculation attempted.")
            
            //TODO: Segue to results display page.
            
        } else {
            
            let alertController = UIAlertController(title: "Please review the following:", message: alertString, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(okAction)
            
            let presenterHandler = { self.alertString = ""}
            
            present(alertController, animated: true, completion: presenterHandler)
            
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



//Functions

extension EnterConditionsVC {
    
    //TODO: Create a View file that controls configuration of the buttons.
    
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
    
}

extension EnterConditionsVC: AdvisoryDataSentDelegate {
    
    func userDidSelectConfiguration(advisoryDataSet: NSSet) {
        advisoryData = advisoryDataSet
        print("AdvisoryData Sent to Enter Conditions VC")
    }
    
}


