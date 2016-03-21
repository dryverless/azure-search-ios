//
//  MagnitudeScoringFunc.swift
//  azure-search-basics
//
//  Created by Mark Hamilton on 3/21/16.
//  Copyright © 2016 dryverless. All rights reserved.
//

import Foundation

struct MagnitudeScoringFunc {
    
    var boostingRangeStart: Int
    var boostingRangeEnd: Int
    var constantBoostBeyondRange: Bool // defaults to false
    
}