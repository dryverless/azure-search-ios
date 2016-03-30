//
//  CRS.swift
//  azure-search-basics
//
//  Created by Mark Hamilton on 3/10/16.
//  Copyright © 2016 dryverless. All rights reserved.
//

import Foundation

struct CRS {
    
    /*
    
    FORMAT OF JSON

    "crs": {
    
        "type": "name",
        
        "properties": {
            "name": "EPSG:4326"
        }
    
    }
    
    */
    
    enum InitializationError: ErrorType {
        
        case InvalidFormat
        
        case MissingType
        
        case MissingProperties
        
    }
    
    private var _type: String = "name"
    private var _properties: [String : AnyObject]!
    
    var type: String {
        
        get {
            
            return _type
            
        }
        
    }
    
    var properties: [String : AnyObject] {
        
        get {
            
            return _properties
            
        }
        
    }
    
    init(crs: [String : AnyObject]) throws {
        
        if crs.count == 0 {
            
            throw InitializationError.InvalidFormat
            
        }
        
        guard let typ = crs["type"] as? String else {
            
            throw InitializationError.MissingType
            
        }
        
        guard let props = crs["properties"] as? [String : AnyObject] else {
            
            throw InitializationError.MissingProperties
            
        }
        
        self._type = typ
        self._properties = props
        
    }
    
    init(name: String) {
        
        self._properties = [ "name" : name ]
        
    }
    
    init() {

        self._properties = [ "name" : "EPSG:4326" ]
        
    }
    
}