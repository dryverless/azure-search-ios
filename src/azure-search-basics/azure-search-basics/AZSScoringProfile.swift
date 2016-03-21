//
//  AZSScoringProfile.swift
//  azure-search-basics
//
//  Created by Mark Hamilton on 3/21/16.
//  Copyright © 2016 dryverless. All rights reserved.
//

import Foundation

struct AZSScoringProfile {
    
    /*
    
    JSON Format: https://msdn.microsoft.com/en-us/library/azure/dn798941.aspx
    
    "scoringProfiles": [
        {
            "name": "name of scoring profile",
            "text": (optional, only applies to searchable fields) {
            "weights": {
                "searchable_field_name": relative_weight_value (positive #'s),
                ...
            }
        },
        "functions": (optional) [
            {
                "type": "magnitude | freshness | distance | tag",
                "boost": # (positive number used as multiplier for raw score != 1),
                "fieldName": "...",
                "interpolation": "constant | linear (default) | quadratic | logarithmic",
                "magnitude": {
                    "boostingRangeStart": #,
                    "boostingRangeEnd": #,
                    "constantBoostBeyondRange": true | false (default)
                },
                "freshness": {
                    "boostingDuration": "..." (value representing timespan leading to now over which boosting occurs)
                },
                "distance": {
                    "referencePointParameter": "...", (parameter to be passed in queries to use as reference location)
                    "boostingDistance": # (the distance in kilometers from the reference location where the boosting range ends)
                },
                "tag": {
                    "tagsParameter": "..." (parameter to be passed in queries to specify a list of tags to compare against target fields)
                }
            }
        ],
        "functionAggregation": (optional, applies only when functions are specified)
            "sum (default) | average | minimum | maximum | firstMatching"
        }
    ],
    
    */
    
    enum InitializationErrors: ErrorType {
        
        case InvalidName
        
        case InvalidWeights
        
        case InvalidScoringFunctions
        
        case NoWeightsOrScoringFunction
        
    }
    
    private var _name: String // name of scoring profile
    private var _weights: [String : Double]? // weights applied to searchable fields
    private var _functions: [AZSScoringFunction]? // optional
 
    var name: String {
        
        get {
            
            return _name
            
        }
        
    }
    
    var weights: [String : Double] {
        
        get {
            
            return _weights ?? [String : Double]()
            
        }
        
    }
    
    var functions: [AZSScoringFunction] {
        
        get {
            
            return _functions ?? [AZSScoringFunction]()
            
        }
        
    }
    
    init(name: String, _ weights: [String : Double]?, _ functions: [AZSScoringFunction]?) throws {
        
        if (weights == nil && functions == nil) {
            
            throw InitializationErrors.NoWeightsOrScoringFunction
            
        }
        
        guard let nm: String = name else {
            
            throw InitializationErrors.InvalidName
            
        }
        
        guard let weightz: [String : Double] = weights! else {
            
            throw InitializationErrors.InvalidWeights
            
        }
        
        guard let scoringFuncs: [AZSScoringFunction] = functions else {
            
            throw InitializationErrors.InvalidScoringFunctions
            
        }
        
        self._name = nm ?? "default-scoring"
        self._weights = weightz
        self._functions = scoringFuncs
        
    }
    
}