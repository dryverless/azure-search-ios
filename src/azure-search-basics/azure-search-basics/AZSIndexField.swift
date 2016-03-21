//
//  AZSIndexField.swift
//  azure-search-basics
//
//  Created by Mark Hamilton on 3/21/16.
//  Copyright © 2016 dryverless. All rights reserved.
//

import Foundation

struct AZSIndexField {
    
    /*
    
    JSON STRUCTURE:
    
    {
        "name": "name_of_field",
        
        "type": "Edm.String | Collection(Edm.String) | Edm.Int32 | Edm.Int64 | Edm.Double | Edm.Boolean | Edm.DateTimeOffset | Edm.GeographyPoint",
        
        "searchable": true (default where applicable) | false (only Edm.String and Collection(Edm.String) fields can be searchable),
        
        "filterable": true (default) | false,
        
        "sortable": true (default where applicable) | false (Collection(Edm.String) fields cannot be sortable),
        
        "facetable": true (default where applicable) | false (Edm.GeographyPoint fields cannot be facetable),
        
        "key": true | false (default, only Edm.String fields can be keys),
        
        "retrievable": true (default) | false,
        
        "analyzer": "name of text analyzer"
    }
    
    */
    
    enum InitializationError: ErrorType {
        
        case InvalidName
        
        case InvalidType
        
        case InvalidSearchable
        
        case InvalidFilterable
        
        case InvalidSortable
        
        case InvalidFacetable
        
        case InvalidKey
        
        case InvalidRetrievable
        
        case InvalidAnalyzer
        
    }
    
    private var _name: String!
    private var _type: String!
    private var _searchable: Bool?
    private var _filterable: Bool?
    private var _sortable: Bool?
    private var _facetable: Bool?
    private var _key: Bool?
    private var _retrievable: Bool?
    private var _analyzer: String?
    
    var name: String {
        
        get {
            
            return _name
            
        }
        
    }
    
    var type: String {
        
        get {
            
            return _type
            
        }
        
    }
    
    var searchable: Bool {
        
        get {
            
            return _searchable ?? true
            
        }
        
    }
    
    var filterable: Bool {
        
        get {
            
            return _filterable ?? true
            
        }
        
    }
    
    var sortable: Bool {
        
        get {
            
            return _sortable ?? true
            
        }
        
    }
    
    var facetable: Bool {
        
        get {
            
            return _facetable ?? true
            
        }
        
    }
    
    var isKey: Bool {
        
        get {
            
            return _key ?? false
            
        }
        
    }
    
    var retrievable: Bool {
        
        get {
            
            return _retrievable ?? true
            
        }
        
    }
    
    var analyzer: String {
        
        get {
            
            return _analyzer ?? "en.microsoft" // Localization?
            
        }
        
    }
    
    init(name: String, type: String, _ searchable: Bool?, _ filterable: Bool?, _ sortable: Bool?, _ facetable: Bool?, _ isKey: Bool?, _ retrievable: Bool?, _ analyzer: String?) throws {
        
        guard let nm: String = name where nm != "" else {
            
            InitializationError.InvalidName
            return
            
        }
        
        guard let typ: String = type where typ != "" else {
            
            InitializationError.InvalidType
            return
            
        }
        
        guard let searchabl: Bool = searchable! else {
            
            InitializationError.InvalidSearchable
            
        }
        
        guard let filterabl: Bool = filterable! else {
            
            InitializationError.InvalidFilterable
            
        }
        
        guard let sortabl: Bool = sortable! else {
            
            InitializationError.InvalidSortable
            
        }
        
        guard let facetabl: Bool = facetable! else {
            
            InitializationError.InvalidFacetable
            
        }
        
        guard let iskey: Bool = isKey! else {
            
            InitializationError.InvalidKey
            
        }
        
        guard let retrievabl: Bool = retrievable! else {
            
            InitializationError.InvalidRetrievable
        
        }
        
        guard let analyzr: String = analyzer! else {
            
            InitializationError.InvalidAnalyzer
            
        }
        
        self._name = nm
        self._type = typ
        self._searchable = searchabl ?? true // default
        self._filterable = filterabl ?? true
        self._sortable = sortabl ?? true
        self._facetable = facetabl ?? true
        self._key = iskey ?? false
        self._retrievable = retrievabl ?? true
        self._analyzer = analyzr ?? "en.microsoft" // default 
        
        /* Full list of analyzers: https://msdn.microsoft.com/en-us/library/azure/dn879793.aspx */
        
    }
    
}