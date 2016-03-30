//
//  IBInspectableExtensions.swift
//  azure-search-basics
//
//  Created by Mark Hamilton on 3/25/16.
//  Copyright © 2016 dryverless. All rights reserved.
//

import Foundation
import UIKit

/// Add Corner Radius to Any View
extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        
        get {
        
            return layer.cornerRadius
        
        }
        
        set {
        
            layer.cornerRadius = newValue
            
            layer.masksToBounds = newValue > 0

        }

    }

}
