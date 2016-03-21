//
//  AZSScoring.swift
//  azure-search-basics
//
//  Created by Mark Hamilton on 3/21/16.
//  Copyright © 2016 dryverless. All rights reserved.
//

import Foundation

protocol AZSScoring {
    
    var type: String { get }
    var boost: Int { get }
    var fieldName: String { get }
    var interpolation: String { get }
    
}