//
//  AZSCorsOptions.swift
//  azure-search-basics
//
//  Created by Mark Hamilton on 3/21/16.
//  Copyright © 2016 dryverless. All rights reserved.
//

import Foundation

struct AZSCorsOptions {
    
    enum InitializationError: ErrorType {
        
        case InvalidOrigins
        
        case InvalidMaxAge
        
    }
    
    private var _allowedOrigins: [String] = ["*"] // ["origin1", "origin2",...,"n"] or ["*"] for Allow All
    private var _maxAgeInSeconds: Int?
    
    var allowedOrigins: [String] {
        
        get {
            
            return _allowedOrigins ?? ["*"]
            
        }
        
    }
    
    // Optional
    var maxAgeInSeconds: Int {
        
        get {
            
            return _maxAgeInSeconds ?? 300 // Default is 5 Minutes
            
        }
        
    }
    
    init(allowedOrigins: [String], maxAgeInSeconds: Int?) throws {
        
        guard let allowOrigins: [String] = allowedOrigins where allowOrigins.count > 0 else {
            
            throw InitializationError.InvalidOrigins
            
        }
        
        guard let maxAge: Int = maxAgeInSeconds where maxAge >= 0 else {
            
            throw InitializationError.InvalidMaxAge
            
        }
        
        self._allowedOrigins = allowOrigins ?? ["*"]
        self._maxAgeInSeconds = maxAge
        
    }
    
}