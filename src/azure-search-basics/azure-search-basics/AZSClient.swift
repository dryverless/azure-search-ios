//
//  AZSClient.swift
//  azure-search-basics
//
//  Created by Mark Hamilton on 3/13/16.
//  Copyright © 2016 dryverless. All rights reserved.
//

import Foundation

class AZSClient: NSObject {
    
    static let sharedAZSClient = AZSClient()
    
    // Query Index
    /*
    
    func performSearch(searchText: String) {
        
        let _searchUrl = "\(BASE_URL)\(searchText)"
        
        let url = NSURL(string: _searchUrl)!
        
        Alamofire.request(.GET, url, headers: SEARCH_HEADERS).responseJSON { response in
            
            let result = response.result
            
            if let results = result.value as? Dictionary<String, AnyObject> {
                
                print(results.debugDescription)
                
                
            }
            
        }
        
    } 
    
    */
    
    var selectedFields: String = "&$select="
    
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
    
    func addToIndex() {
        
    }
    
    
    // Delete Index
    func deleteIndex() {
        
        
    }
    
    
    // Create Index
    func createIndex() {
        
        
    }
    
    
}