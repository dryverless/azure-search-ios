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
// "value": [[String : AnyObject]]
// "@odata.nextLink": String

struct AZSResults {
    
    private var _context: String? // @odata.context
    private var _value:[[String : AnyObject]]? // value
    private var _nextLink: String? // @odata.nextLink
    
    // Raw Results from API
    private var _results: [String : AnyObject]!
    
    
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
    
    var results: [String : AnyObject] {
        
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
         
            if let ctx: String = results["@odata.context"] as? String {
                
                return ctx
                
            }
            
            return _context ?? ""
            
        }
        
    }
    
    var value: [[String : AnyObject]] {
        
        get {
            
            if let results: [[String : AnyObject]] = results["value"] as? [[String : AnyObject]] ?? [[String : AnyObject]]() {
                
                return results
                
            }
            
        }
        
    }
    
    var nextLink: String {
        
       
        get {
            
            if let nLink: String = results["@odata.nextLink"] as? String {
                
                return nLink
            }
            
            return _nextLink ?? ""
            
        }
        
    }
    
    // MARK: - Initialize with results download from API.
    
    init(results: [String : AnyObject]) {
        
        self.init()
        
        if let Results: [String : AnyObject] = results {
            
            self._results = Results
//            for result in Results["value"] {
//                
//                // set as AZSResult Conforming Type
//                
//            }
        }
        
        
    }
    
    
    // MARK: - Initialize with already parsed results download from API.
    
    init(context: String, results: [[String : AnyObject]], nextLink: String) {
        
        self.init()
        
        if let ctx: String = context where ctx != "" {
            
            self._context = ctx
            
        }
        
        
        if let values: [[String : AnyObject]] = results where values.count > 0 {
            
            self._value = values
            
        }
        
        
        if let nxtLink: String = nextLink where nxtLink != "" {
            
            self._nextLink = nxtLink
            
        }
        
    }
    
    init() {
        
        self._results = [String : AnyObject]()
        
    }
    
}