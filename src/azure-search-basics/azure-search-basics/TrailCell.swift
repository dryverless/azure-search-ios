//
//  TrailCell.swift
//  azure-search-basics
//
//  Created by Mark Hamilton on 3/18/16.
//  Copyright © 2016 dryverless. All rights reserved.
//

import Foundation
import UIKit

class TrailCell: UITableViewCell {
    
    @IBOutlet weak var trailTitleLabel: UILabel!
    @IBOutlet weak var trailCountyLabel: UILabel!
    @IBOutlet weak var trailElevationLabel: UILabel!
    
    internal var trail: Trail!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func configureCell(trail: Trail) {
        
        self.trail = trail
        
        defer { self.trailTitleLabel.text = self.trail.name.capitalizedString
        self.trailCountyLabel.text = self.trail.county.capitalizedString
            self.trailElevationLabel.text = "\(String(self.trail.elevation)) m" }
        
    }
    
}
