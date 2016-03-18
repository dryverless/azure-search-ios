//
//  AZSSuggestionCell.swift
//  azure-search-basics
//
//  Created by Mark Hamilton on 3/18/16.
//  Copyright © 2016 dryverless. All rights reserved.
//

import Foundation
import UIKit

class AZSSuggestionCell: UITableViewCell {
    
    @IBOutlet weak var suggestionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(suggestion: AZSSuggestion) {
        
        if let attStr: NSAttributedString = suggestion.attributedText {
            
            suggestionLabel.attributedText = attStr
            
        } else {
            
            if let str: String = suggestion.searchText {
             
                suggestionLabel.text = str
                
            }
            
        }
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
