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
    
    @IBAction func selectionButtonPressed(_ sender: UIButton) {
        sender.reversesTitleShadowWhenHighlighted = true
        
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
