//
//  AircraftCell.swift
//  Landing Distance
//
//  Created by Chetwyn on 4/5/17.
//  Copyright © 2017 Clarke Enterprises. All rights reserved.
//

import UIKit

class AircraftCell: UITableViewCell {
    
    @IBOutlet weak var aircraftType: UILabel!
    @IBOutlet weak var aircraftEngine: UILabel!
    
    func configureCell(aircraft: Aircraft) {
        aircraftType.text = aircraft.type
        aircraftEngine.text = aircraft.engine
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
