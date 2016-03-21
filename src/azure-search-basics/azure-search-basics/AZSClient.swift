//
//  AZSClient.swift
//  azure-search-basics
//
//  Created by Mark Hamilton on 3/13/16.
//  Copyright © 2016 dryverless. All rights reserved.
//

import Foundation

class AZSClient {
    
    static let sharedAZSClient = AZSClient()
    
    // Query Index
    /*
    
    func performSearch(searchText: String) {
        
        let _searchUrl = "\(BASE_URL)\(searchText)"
        
        let url = NSURL(string: _searchUrl)!
        
        Alamofire.request(.GET, url, headers: SEARCH_HEADERS).responseJSON { response in
            
            let result = response.result
            
            if let results = result.value as? [String : AnyObject] {
                
                print(results.debugDescription)
                
                
            }
            
        }
        
    } 
    
    */
    
//    var image:UIImage = UIImage(
//    
//    var selectedFields: String = "&$select="
    
    // &$select=id,title
//    for field in fields {
//    
//        selectedFields = "\(selectedFields)&field=\(field)"
//    
//    }
//    
    
    // Lookup Document
    
    // GET https://[service name].search.windows.net/indexes/[index name]/docs/key?[query parameters]
    // api-key: [admin key]
    
    // Count Documents
    // GET https://[service name].search.windows.net/indexes/[index name]/docs/$count?api-version=[api-version]
    // Accept: text/plain
    // api-key: [admin key]
    // https://azs-playground.search.windows.net/indexes/movies/docs/$count?&api-version=2015-02-28
    
    
    // Add To Index
    
    /*

    POST https://visitusa.search.windows.net/indexes/trails?api-version=2015-02-28
    
    Headers: api-key / Content-Type: application/json; charset=utf-8
    
    Body:
    
    See AddTrails.json
    
    */
    
    func addToIndex() {
        
    }
    
    
    // Delete Index
    /*

    DELETE https://visitusa.search.windows.net/indexes/trails?api-version=2015-02-28
    
    Headers: api-key / Content-Type: application/json; charset=utf-8
    
    */
    
    func deleteIndex() {
        
        
    }
    
    
    // Create Index
    
    /*

    PUT https://visitusa.search.windows.net/indexes/trails?api-version=2015-02-28
    
    Headers: api-key / Content-Type: application/json; charset=utf-8
    
    Body:
    
    {
        "name": "trails",
        
        "fields": [
    
            {"name": "id", "type": "Edm.String", "key": true, "searchable": false},
    
            {"name": "name", "type": "Edm.String"},
    
            {"name": "county", "type": "Edm.String"},
    
            {"name": "elevation", "type": "Edm.Int32"},
    
            {"name": "location", "type": "Edm.GeographyPoint"}
    
        ]
    
    }
    
    */
    
    func createIndex() {
        
        
    }
    
    
}