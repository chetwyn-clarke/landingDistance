//
//  EnterConditionsVC.swift
//  Landing Distance
//
//  Created by Chetwyn on 4/10/17.
//  Copyright © 2017 Clarke Enterprises. All rights reserved.
//

import UIKit

class EnterConditionsVC: UIViewController {
    
    //Text fields
    
    @IBOutlet weak var altitude: UITextField!
    
    @IBOutlet weak var windDirection: UITextField!
    
    @IBOutlet weak var windSpeed: UITextField!
    
    @IBOutlet weak var windGusts: UITextField!
    
    @IBOutlet weak var temperature: UITextField!
    
    //@IBOutlet weak var slope: UITextField!  (for future implementation)
    
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
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func selectButton (button: UIButton) {
        
        button.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)
        button.tintColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
        
    }
    
    func deSelectButton (button: UIButton) {
        
        button.tintColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)
        button.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 0.5)
        
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
        
        if let weight = aircraftWeight.text {
            ResultsController.instance.aircraftWeight = Double(weight)!
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
