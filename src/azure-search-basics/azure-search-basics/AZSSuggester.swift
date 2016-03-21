//
//  AZSSuggester.swift
//  azure-search-basics
//
//  Created by Mark Hamilton on 3/21/16.
//  Copyright © 2016 dryverless. All rights reserved.
//

import Foundation

struct AZSSuggester {
    
    enum InitializationError: ErrorType {
        
        case InvalidName
        
        case InvalidMode
        
        case InvalidSourceFields
        
    }
    
    private var _name: String
    private var _searchMode: String
    private var _searchFields: [String]
    
    var name: String {
        
        get {
            
            return _name
            
        }
        
    }
    
    var searchMode: String {
        
        get {
            
            return _searchMode
            
        }
        
    }
    
    var searchFields: [String] {
        
        get {
            
            return _searchFields
            
        }
        
    }
    
    init(name: String, searchMode: String, searchFields: [String]) throws {
        
        guard let nm: String = name where nm != "" else {
            
            throw InitializationError.InvalidName
            
        }
        
        guard let sMode: String = searchMode where sMode != "" else {
            
            throw InitializationError.InvalidMode
        
        }
        
        guard let sFields: [String] = searchFields where sFields.count > 0 else {
            
            throw InitializationError.InvalidSourceFields
            
        }
        
        self._name = nm ?? "default-suggester" // must not overlap
        self._searchMode = sMode ?? "analyzingInfixMatching" // can be any mode
        self._searchFields = sFields ?? ["id"]
        
    }
    
}