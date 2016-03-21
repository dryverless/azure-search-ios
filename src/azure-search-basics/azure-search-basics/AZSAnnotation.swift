//
//  AZSAnnotation.swift
//  azure-search-basics
//
//  Created by Mark Hamilton on 3/11/16.
//  Copyright © 2016 dryverless. All rights reserved.
//

import Foundation
import MapKit

// Not Implemented
protocol AZSAnnotation: MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D { get }
    
    var title: String { get }
    
    var subtitle: String { get }
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D)
    
    init(title: String, coordinate: CLLocationCoordinate2D)
    
    init(coordinate: CLLocationCoordinate2D)
    
}