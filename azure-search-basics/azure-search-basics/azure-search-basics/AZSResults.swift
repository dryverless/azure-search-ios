//
//  AZSResults.swift
//  azure-search-basics
//
//  Created by Mark Hamilton on 3/10/16.
//  Copyright © 2016 dryverless. All rights reserved.
//

import Foundation

// Basic Structure
// "@odata.context": String
// "value": [Dictionary<String, AnyObject>]
// "@odata.nextLink": String

struct AZSResults {
    
    private var _context: String? // @odata.context
    private var _value:[Dictionary<String, AnyObject>]? // value
    private var _nextLink: String? // @odata.nextLink
    
    // Raw Results from API
    private var _results: Dictionary<String, AnyObject>!
    
    
    // MARK: - Downloaded Results
    
    //    var results: AnyObject {
    //
    //        mutating get {
    //
    //            if !isUniquelyReferencedNonObjC(&_results!) {
    //
    //                _results = _results.copy()
    //
    //            }
    //
    //            return _results // as! [AZSResult]
    //        }
    //
    //    }
    
    var results: Dictionary<String, AnyObject> {
        
        get {
            
            return _results
            
        }
        
        set {
            
            _results = newValue
        }
        
    }
    
    // MARK: - Properties of Downloaded Results
    
    var context: String {
        
        get {
         
            if let ctx: String = results["@odata.context"] as? String ?? String() {
                
                return ctx
                
            }
            
            return _context ?? String()
            
        }
        
    }
    
    var value: [Dictionary<String, AnyObject>] {
        
        get {
            
            if let results: [Dictionary<String, AnyObject>] = results["value"] as? [Dictionary<String, AnyObject>] ?? [Dictionary<String, AnyObject>]() {
                
                return results
                
            }
            
        }
        
    }
    
    var nextLink: String {
        
       
        get {
            
            if let nLink: String = results["@odata.nextLink"] as? String ?? String() {
                
                return nLink
            }
            
            return _nextLink ?? String()
            
        }
        
    }
    
    // MARK: - Initialize with results download from API.
    
    init(results: Dictionary<String, AnyObject>) {
        
        self.init()
        
        if let Results: Dictionary<String, AnyObject> = results {
            
            self._results = Results
            
        }
        
        
    }
    
    
    // MARK: - Initialize with already parsed results download from API.
    
    init(context: String, results: [Dictionary<String, AnyObject>], nextLink: String) {
        
        self.init()
        
        if let ctx: String = context where ctx != "" {
            
            self._context = ctx
            
        }
        
        
        if let values: [Dictionary<String, AnyObject>] = results where values.count > 0 {
            
            self._value = values
            
        }
        
        
        if let nxtLink: String = nextLink where nxtLink != "" {
            
            self._nextLink = nxtLink
            
        }
        
    }
    
    init() {
        
        self._results = Dictionary<String,AnyObject>()
        
    }
    
}