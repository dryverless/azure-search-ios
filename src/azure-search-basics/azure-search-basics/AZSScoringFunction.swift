//
//  AZSScoringFunction.swift
//  azure-search-basics
//
//  Created by Mark Hamilton on 3/21/16.
//  Copyright © 2016 dryverless. All rights reserved.
//

import Foundation

struct AZSScoringFunction: AZSScoring {
    
    enum InitializationErrors: ErrorType {
        
        case InvalidType
        
        case InvalidBoost
        
        case InvalidFieldName
        
        case InvalidInterpolation
        
        
    }
    
    private var _type: String // magnitude | freshness | distance | tag
    private var _boost: Int
    private var _fieldName: String
    private var _interpolation: String?
    
    var type: String {
        
        get {
            return _type
        }
        
    }
    
    var boost: Int {
        
        get {
            
            return _boost ?? 10
            
        }
        
    }
    
    var fieldName: String {
        
        get {
            
            return _fieldName
        }
        
    }
    
    var interpolation: String {
        
        get {
            
            return _interpolation ?? "linear" // default
            
        }
        
    }
    
    init(type: String, boost: Int, fieldName: String, _ interpolation: String) throws {
        
        guard let typ: String = type where (typ == "magnitude" || typ == "freshness" || typ == "distance" || typ == "tag") else {
            
            throw InitializationErrors.InvalidType
            
        }
        
        guard let bst: Int = boost where bst > 1 else {
            
            throw InitializationErrors.InvalidBoost
            
        }
        
        guard let fieldNm: String = fieldName else {
            
            throw InitializationErrors.InvalidFieldName
            
        }
        
        guard let intrpol: String = interpolation where (intrpol == "constant" || intrpol == "linear" || intrpol == "quadratic" || intrpol == "logarithmic") else {
            
            throw InitializationErrors.InvalidInterpolation
            
        }
        
        self._type = typ
        self._boost = bst ?? 10
        self._fieldName = fieldNm
        self._interpolation = intrpol ?? "linear" // default
        
        
    }
    
}