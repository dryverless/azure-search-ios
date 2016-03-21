//
//  AZSSuggestions.swift
//  azure-search-basics
//
//  Created by Mark Hamilton on 3/14/16.
//  Copyright © 2016 dryverless. All rights reserved.
//

import Foundation
import UIKit

struct AZSSuggestions {
    
    private var _value: [String : AnyObject]?
    private var _context: String?
    private var _suggestions = [AZSSuggestion]()
    
    var context: String {
        
        get {
            
            return _context ?? ""
            
        }
        
    }
    
    var suggestions: [AZSSuggestion] {
        
        get {
            
            if let suggest: [AZSSuggestion] = _suggestions ?? [AZSSuggestion]() {
                
                return suggest
                
            }
            
        }
        
    }
    
    func returnFirstSuggestion() -> NSAttributedString {
        
        if let s: AZSSuggestion = suggestions[0] {
            
            if let attStr: NSAttributedString = s.attributedText {
                
                return attStr
                
            } else {
            
                if let baseStr: String = s.searchText {
                    
                    return NSAttributedString(string: baseStr)
                    
                }
                
            }
            
        }
        
    }
    
    init(value: [String : AnyObject]) {
        
        self._value = value
        
        if let ctx = value["@odata.context"] as? String {
            
            self._context = ctx
            
        }
        
        if let sArr = value["value"] as? [[String : AnyObject]] {
            
            for s in sArr {
                
                self._suggestions.append(AZSSuggestion(value: s))
                
            }
            
        }
        
    }
    
}