//
//  ResultsCell.swift
//  Landing Distance
//
//  Created by Chetwyn on 4/28/17.
//  Copyright © 2017 Clarke Enterprises. All rights reserved.
//

import UIKit

class ResultsCell: UITableViewCell {
    
    
    @IBOutlet weak var brakeConfiguration: UILabel!
    @IBOutlet weak var landingDistance: UILabel!
    
    func configureCell(result: Result) {
        brakeConfiguration.text = result.brakeConfig + ":"
        landingDistance.text = "\(result.distanceRequired)"
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}
