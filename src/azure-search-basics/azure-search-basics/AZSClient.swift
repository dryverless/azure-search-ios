//
//  AZSClient.swift
//  azure-search-basics
//
//  Created by Mark Hamilton on 3/13/16.
//  Copyright © 2016 dryverless. All rights reserved.
//

import Foundation
import UIKit

public typealias ResultsDownloadComplete = ([String : AnyObject]) -> ()

public typealias CountDownloadComplete = (Int) -> ()

public typealias LookupDownloadComplete = ([String : AnyObject]) -> ()

public typealias IndexCreationComplete = (AnyObject) -> ()

public typealias IndexDeletionComplete = (AnyObject) -> ()

struct AZS {
    
    static let sharedClient = AZS()
    
    internal enum AZSClientError: ErrorType {
        
        case UnableToSerializeResponseData
        
        case UnableToConvertResponseData
        
    }
    
    internal enum HTTPMethod : String {
        case OPTIONS
        case GET
        case HEAD
        case POST
        case PUT
        case PATCH
        case DELETE
        case TRACE
        case CONNECT
    }
    
    internal enum apiVersion {
    
        case Select(String)
        
        case Default
    
    }
    
    internal enum searchService {
        
        case Select(String)
        
        case AZSPlayground
        
        case Demo
        
    }
    
    internal enum searchIndex {
        
        case Select(String)
        
        case AZSPlayground
        
        case Demo
        
        
    }
    
    internal enum apiKey {
        
        case Select(String)
        
        case AZSPlayground
        
        case Demo
        
    }
    
    internal enum contentType {
        
        case Select(String)
        
        case JSON
        
        case JSON_UTF8
        
        case TEXT_PLAIN
        
    }
    
    internal func returnAPIVersion(version: apiVersion) -> String {
        
        switch version {
            
            case let .Select(value):
                return value
            
            case .Default:
                return "2015-02-28"
            
        }
        
    }
    
    internal func returnSearchService(service: searchService) -> String {
        
        switch service {
            
            case let .Select(value):
                return value
            
            case .AZSPlayground:
                return "azs-playground"
            
            case .Demo:
                return "visitusa"
            
        }
        
    }
    
    internal func returnSearchIndex(index: searchIndex) -> String {
        
        switch index {
            
            case let .Select(value):
                return value
            
            case .AZSPlayground:
                return "movies"
            
            case .Demo:
                return "trails"
            
        }
        
    }
    
    internal func returnAPIKey(key: apiKey) -> String {
        
        switch key {
            
            case let .Select(value):
                return value
            
            case .AZSPlayground:
                return "54D83159A5E23BBF0AA35349F4DF1B31"
            
            case .Demo:
                return "0DF10F042FBF45B4B48D40BE9A51FF74"
            
        }
        
    }
    
    internal func returnContentType(type: contentType) -> String {
        
        switch type {
            
            case let .Select(value):
                return value
            
            case .JSON:
                return "application/json"
            
            case .JSON_UTF8:
                return "application/json; charset=utf-8"
            
            case .TEXT_PLAIN:
                return "text/plain"
            
        }
        
    }
    
    internal func returnBaseURL(version: apiVersion, service: searchService, index: searchIndex) -> String {
        
        let APIVersion: String = self.returnAPIVersion(version)
        
        let coreURL: String = self.returnCoreURL(service, index: index)
        
        return "\(coreURL)/docs?api-version=\(APIVersion)"
        
    }
    
    internal func returnLookupURL(version: apiVersion, service: searchService, index: searchIndex, doc: String) -> String {
        
        let APIVersion: String = self.returnAPIVersion(version)
        
        let coreURL: String = self.returnCoreURL(service, index: index)
        
        return "\(coreURL)/docs/\(doc)?api-version=\(APIVersion)"
        
    }
    
    internal func returnCountURL(version: apiVersion, service: searchService, index: searchIndex) -> String {
        
        let APIVersion: String = self.returnAPIVersion(version)
        
        let coreURL: String = self.returnCoreURL(service, index: index)
        
        return "\(coreURL)/docs/$count?api-version=\(APIVersion)"
    }
    
    internal func returnIndexStatsURL(version: apiVersion, service: searchService, index: searchIndex) -> String {
        
        let APIVersion: String = self.returnAPIVersion(version)
        
        let coreURL: String = self.returnCoreURL(service, index: index)
        
        return "\(coreURL)/stats?api-version=\(APIVersion)"
        
    }
    
    internal func returnCoreServiceURL(version: apiVersion, service: searchService) -> String {
        
        let ServiceURL: String = self.returnBaseServiceURL(service)
        
        let APIVersion: String = self.returnAPIVersion(version)
        
        return "\(ServiceURL)?api-version=\(APIVersion)"
    }
    
    internal func returnCoreIndexURL(version: apiVersion, service: searchService, index: searchIndex) -> String {
        
        let coreURL: String = self.returnCoreURL(service, index: index)
        
        let APIVersion: String = self.returnAPIVersion(version)
        
        return "\(coreURL)?api-version=\(APIVersion)"
        
    }
    
    internal func returnCoreURL(service: searchService, index: searchIndex) -> String {
        
        let ServiceURL: String = self.returnBaseServiceURL(service)
        
        let SearchIndex: String = self.returnSearchIndex(index)
        
        return "\(ServiceURL)/\(SearchIndex)"
        
    }
    
    internal func returnBaseServiceURL(service: searchService) -> String {
        
        let ServiceURL: String = self.returnSearchService(service)
        
        return "https://\(ServiceURL).search.windows.net/indexes"
        
    }
    
    internal func buildRESTCall(key: apiKey, url: NSURL, action: HTTPMethod) -> NSMutableURLRequest {
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = action.rawValue
        request.setValue(self.returnAPIKey(key), forHTTPHeaderField: "api-key")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        return request
        
    }
    
    internal func buildRESTCall(key: apiKey, url: NSURL, action: HTTPMethod, content: contentType) -> NSMutableURLRequest {
        
        let request = NSMutableURLRequest(URL: url)
        
        switch action {
            
            case .POST:
                request.HTTPMethod = action.rawValue
                request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
            
            default:
                request.HTTPMethod = action.rawValue
                request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
            
        }
        
        
        request.setValue(self.returnAPIKey(key), forHTTPHeaderField: "api-key")
        request.setValue(self.returnContentType(content), forHTTPHeaderField: "Content-Type")
        
        return request
        
    }
    
    // Query Index
    
    func performBasicSearch(key: apiKey, service: searchService, index: searchIndex, searchText: String, completion: ResultsDownloadComplete) {
        
        let baseURL: String = self.returnBaseURL(.Default, service: service, index: index)
        
        let _searchUrl = "\(baseURL)&search=\(searchText)"
        
        let url = NSURL(string: _searchUrl)!
        
        let request = self.buildRESTCall(key, url: url, action: .GET)
        
        dataTask(request) {
            
            (let response) in
            
            if let responseData: NSData = response as? NSData {
                
                do {
                    
                    let json = try NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.AllowFragments)
                    
                    if let jsonDict = json as? [String : AnyObject] {
                        
                        completion(jsonDict)
                        
                    }
                    
                } catch {
                    
                    NSLog("\(AZSClientError.UnableToSerializeResponseData)")
                }
                
            }
            
        }
        
    }
    
    // Lookup Document
    
    // GET https://[service name].search.windows.net/indexes/[index name]/docs/key?[query parameters]
    // api-key: [admin key]
    
    func lookupDocument(version: apiVersion, key: apiKey, service: searchService, index: searchIndex, docId: String, completion: LookupDownloadComplete) {
        
        let _lookupUrl: String = self.returnLookupURL(version, service: service, index: index, doc: docId)
        
        let url = NSURL(string: _lookupUrl)!
        
        let request = self.buildRESTCall(key, url: url, action: .GET)
        
        dataTask(request) {
            
            (let response) in
            
                if let responseData: NSData = response as? NSData {
                
                    do {
                    
                        let json = try NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.AllowFragments)
                    
                        if let jsonDict = json as? [String : AnyObject] {
                        
                            completion(jsonDict)
                        
                        }
                    
                    } catch {
                    
                        NSLog("\(AZSClientError.UnableToSerializeResponseData)")
                    }
                
                }
            
        }
        
    }
    
    // Get Index
    
    /*
 
     GET https://[service name].search.windows.net/indexes/[index name]?api-version=[api-version]
     api-key: [admin key]
     
    */
    func getIndex(version: apiVersion, key: apiKey, service: searchService, index: searchIndex, completion: ResultsDownloadComplete) {
        
        let baseURL: String = self.returnBaseURL(.Default, service: service, index: index)
        
        let url = NSURL(string: baseURL)!
        
        let request = self.buildRESTCall(key, url: url, action: .GET)
        
        dataTask(request) {
            
            (let response) in
            
            if let responseData: NSData = response as? NSData {
                
                do {
                    
                    let json = try NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.AllowFragments)
                    
                    if let jsonDict = json as? [String : AnyObject] {
                        
                        completion(jsonDict)
                        
                    }
                    
                } catch {
                    
                    NSLog("\(AZSClientError.UnableToSerializeResponseData)")
                }
                
            }
            
        }
        
    }
    
    // Get Index Statistics
    
    /*
     
     GET https://[service name].search.windows.net/indexes/[index name]/stats?api-version=[api-version]
     api-key: [admin key]
     
     */
    func getIndexStatistics(version: apiVersion, key: apiKey, service: searchService, index: searchIndex, completion: ResultsDownloadComplete) {
        
        let baseURL: String = self.returnIndexStatsURL(.Default, service: service, index: index)
        
        let url = NSURL(string: baseURL)!
        
        let request = self.buildRESTCall(key, url: url, action: .GET)
        
        dataTask(request) {
            
            (let response) in
            
            if let responseData: NSData = response as? NSData {
                
                do {
                    
                    let json = try NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.AllowFragments)
                    
                    if let jsonDict = json as? [String : AnyObject] {
                        
                        completion(jsonDict)
                        
                    }
                    
                } catch {
                    
                    NSLog("\(AZSClientError.UnableToSerializeResponseData)")
                }
                
            }
            
        }
        
    }
    
    // Count Documents
    // GET https://[service name].search.windows.net/indexes/[index name]/docs/$count?api-version=[api-version]
    // Accept: text/plain
    // api-key: [admin key]
    // https://azs-playground.search.windows.net/indexes/movies/docs/$count?&api-version=2015-02-28
    
    
    func countDocuments(version: apiVersion, key: apiKey, service: searchService, index: searchIndex, completion: CountDownloadComplete) {
        
        let _countUrl: String = self.returnCountURL(version, service: service, index: index)
        
        let url = NSURL(string: _countUrl)!
        
        let request = self.buildRESTCall(key, url: url, action: .GET, content: .TEXT_PLAIN)
        
        dataTask(request) {
            
            (let response) in
            
            if let responseData: NSData = response as? NSData {
                
                do {
                    
                    let count: String = try NSString(data: responseData, encoding: NSUTF8StringEncoding) as! String
                    
                    if let total: Int = Int(count) {
                        
                        completion(total)
                        
                    }
                    
                } catch {
                    
                    NSLog("\(AZSClientError.UnableToConvertResponseData)")
                    
                }
                
            }
            
        }
        
    }

    // List Indexes
    
    /*
 
     GET https://[service name].search.windows.net/indexes?api-version=[api-version]
     api-key: [admin key]
     
    */
    
    func listIndexes(version: apiVersion, key: apiKey, service: searchService, completion: ResultsDownloadComplete) {
        
        let baseURL: String = self.returnCoreServiceURL(.Default, service: service)
        
        let url = NSURL(string: baseURL)!
        
        let request = self.buildRESTCall(key, url: url, action: .GET)
        
        dataTask(request) {
            
            (let response) in
            
            if let responseData: NSData = response as? NSData {
                
                do {
                    
                    let json = try NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.AllowFragments)
                    
                    if let jsonDict = json as? [String : AnyObject] {
                        
                        completion(jsonDict)
                        
                    }
                    
                } catch {
                    
                    NSLog("\(AZSClientError.UnableToSerializeResponseData)")
                }
                
            }
            
        }
        
    }
    
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
    
    func deleteIndex(version: apiVersion, key: apiKey, service: searchService, index: searchIndex, completion: IndexDeletionComplete) {

        let baseURL: String = self.returnCoreIndexURL(version, service: service, index: index)
        
        let url = NSURL(string: baseURL)!
        
        let request = self.buildRESTCall(key, url: url, action: .DELETE)
        
        dataTask(request) {
            
            (let response) in
            
                completion(response)
            
        }
        
        
    }
    
    
    // Create Index
    
    /*

    POST https://visitusa.search.windows.net/indexes?api-version=2015-02-28
    
    Headers: api-key / Content-Type: application/json; charset=utf-8
    
    */
    
    func createIndex(version: apiVersion, key: apiKey, service: searchService, completion: IndexCreationComplete) {
        
        let baseURL: String = self.returnCoreServiceURL(.Default, service: service)
        
        let url = NSURL(string: baseURL)!
        
        let request = self.buildRESTCall(key, url: url, action: .POST)
        
        let demoData: NSData = NSData(contentsOfFile: "AddTrailsIndex.json")!
        
        uploadRequest(request, data: demoData) {
    
            (let response) in
            
                completion(response)
        
        }
        
    }
    
    
}