//
//  Movie.swift
//  azure-search-basics
//
//  Created by Mark Hamilton on 3/14/16.
//  Copyright © 2016 dryverless. All rights reserved.
//

import UIKit

struct Movie: AZSResult {
    
    enum InitializationError: ErrorType {
        
        case MissingScore
        
        case MissingId
        
        case MissingTitle
        
        case MissingPictureUrl
        
    }
    
    internal var _searchScore: Double
    internal var _id: String
    private var _title: String!
    private var _imdbPictureUrl: String?
    
    var title: String {
        
        get {
            
            if let mvtitle: String = _title ?? "" {
                
                return mvtitle
                
            }
            
        }
        
    }
    
    init(movie: [String: AnyObject]) throws {
        
        guard let score: Double = movie["@search.score"] as? Double else {
            
            throw InitializationError.MissingScore
            
        }
        
        guard let mId: String = movie["id"] as? String else {
            
            throw InitializationError.MissingId
            
        }
        
        guard let mTitle: String = movie["title"] as? String else {
            
            throw InitializationError.MissingTitle
            
        }
        
        guard let imdbPicUrl: String = movie["imdbPictureURL"] as? String else {
            
            throw InitializationError.MissingPictureUrl
        }
        
        self._searchScore = score ?? 1
        self._id = mId ?? ""
        self._title = mTitle ?? ""
        self._imdbPictureUrl = imdbPicUrl ?? ""
        
    }
    
    init(score: Double, id: String, title: String, imdbPictureUrl: String) {
        
        self._searchScore = score
        self._id = id
        self._title = title
        self._imdbPictureUrl = imdbPictureUrl
    
    }
    
    init(score: Double, id: String, title: String?) {
        
        self._searchScore = score
        self._id = id
        self._title = title ?? ""
        
    }
    
    init(score: Double, id: String) {
        
        self._searchScore = score
        self._id = id
        self._title = ""
        
    }
    
    init?() {
        
        self._searchScore = 1
        self._id = ""
        self._title = ""
        
    }
    
}
