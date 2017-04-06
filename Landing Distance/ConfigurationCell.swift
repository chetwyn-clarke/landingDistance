//
//  ConfigurationCell.swift
//  Landing Distance
//
//  Created by Chetwyn on 4/6/17.
//  Copyright © 2017 Clarke Enterprises. All rights reserved.
//

import UIKit

class ConfigurationCell: UITableViewCell {
    
    @IBOutlet weak var configurationLbl: UILabel!
    @IBOutlet weak var flapLbl: UILabel!
    
    func configureCell(configuration: Configuration) {
        configurationLbl.text = configuration.name
        flapLbl.text = configuration.flapSetting
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}
