//
//  GeoJSON.swift
//  azure-search-basics
//
//  Created by Mark Hamilton on 3/10/16.
//  Copyright © 2016 dryverless. All rights reserved.
//

import Foundation
import CoreLocation

struct AZSLocation {
    
    enum InitializationError: ErrorType {
        
        case InvalidFormat
        
        case MissingLocationType
        
        case MissingCoordinates
        
        case MissingCRS
        
    }
    
    enum ExportLocation: ErrorType {
        
        case InvalidCoordinates
        
    }
    
    private var _type: String! // "Point" unless "Polygon"
    private var _coordinates: [Double]! // Longitude 0.0, Latitude 0.0
    private var _crs: CRS! // type: "name", properties: [name: "EPSG:4326"]
    
    var type: String {
        
        get {
         
            return _type
            
        }
        
    }
    
    var coordinates: [Double] {
        
        get {
            
            return _coordinates
            
        }
        
    }
    
    var longitude: Double {
        
        get {
            
            return _coordinates[0] ?? 0.0
            
        }
        
    }
    
    var latitude: Double {
        
        get {
            
            return _coordinates[1] ?? 0.0
            
        }
        
    }
    
    var crs: CRS {
        
        get {
            
            if let CRS: CRS = _crs ?? CRS() {
                
                return CRS
                
            }
            
        }
        
    }
    
    internal func asCoordinate2D() throws -> CLLocationCoordinate2D {
        
        guard let coord2D: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude) else {
            
            throw ExportLocation.InvalidCoordinates
            
        }
        
        return coord2D ?? CLLocationCoordinate2D()
        
    }
    
    init(location: [String : AnyObject]) throws {
        
        if location.count == 0 {
            
            throw InitializationError.InvalidFormat
            
        }
        
        guard let typ = location["type"] as? String else {
            
            throw InitializationError.MissingLocationType
            
        }
        
        guard let locCRS: [String: AnyObject] = location["crs"] as? [String : AnyObject] else {
            
            throw InitializationError.MissingCRS
            
        }
        
        guard let coords: [Double] = location["coordinates"] as? [Double] else {
            
            throw InitializationError.MissingCoordinates
            
        }
        
        self._type = typ
        self._coordinates = coords
        
        do {
            
            self._crs = try CRS(crs: locCRS)
        
        } catch let err as NSError {
            
            print(err.debugDescription)
            
            self._crs = CRS()
        
        }
        
    }
    
    init(coords: [Double], crs: CRS) {
        
        self._coordinates = coords
        self._crs = crs
    
    }
    
    init(coords: [Double]) {
        
        self._type = "Point"
        self._coordinates = coords
        self._crs = CRS()
        
    }
    
    init() {
        
        self._type = "Point"
        self._coordinates = [0.0,0.0]
        self._crs = CRS()
        
    }
    
    
}