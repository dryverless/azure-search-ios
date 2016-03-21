//
//  AZSIndex.swift
//  azure-search-basics
//
//  Created by Mark Hamilton on 3/21/16.
//  Copyright © 2016 dryverless. All rights reserved.
//

import Foundation

struct AZSIndex {
    
    /*

    name
    
    fields that will be fed into this index, including name, data type, and properties that define allowable actions on that field.
    
    suggesters used for auto-complete or type-ahead queries.
    
    scoringProfiles used for custom search score ranking. See Add scoring profiles to a search index (Azure Search Service REST API).
    
    defaultScoringProfile used to overwrite the default scoring behaviors.
    
    corsOptions to allow cross-origin queries against your index.
    
    */
    
    private var _name: String!
    //private var _fields: [AZSIndexField]!
    //private var _suggesters: [AZSSuggester]?
    //private var _scoringProfiles: [AZSScoringProfile]?
    private var _defaultScoringProfile: String?
    private var _corsOptions: AZSCorsOptions?
    
}