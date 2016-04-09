//
//  Extensions.swift
//  azure-search-basics
//
//  Created by Mark Hamilton on 3/23/16.
//  Copyright © 2016 dryverless. All rights reserved.
//

import Foundation


public extension Int {
    
    public func add(num: Int) {
        
        self.advancedBy(num)
        
    }
    
}

public extension NSObject {
    
    /*
     
     example:
     
     object.delay(2) {
     // do after 2 seconds
     }
     
     */
    
    public func delay(delay:Double, closure:(() -> Void)) {

        dispatch_after(
            
            dispatch_time(
                
                DISPATCH_TIME_NOW,
            
                Int64(delay * Double(NSEC_PER_SEC))
            
            ), GlobalMainQueue, closure)
    
    }

}

/*

 example:
 
 delay(2) {
   // do after 2 seconds
 }
 
*/

public func delay(delay:Double, closure:(() -> Void)) {
    
    dispatch_after(
        
        dispatch_time(
            
            DISPATCH_TIME_NOW,
            
            Int64(delay * Double(NSEC_PER_SEC))
            
        ), GlobalMainQueue, closure)
    
}

// Minimize 3
public func min3(a: Int, b: Int, c: Int) -> Int {

    return min( min(a, c), min(b, c))

}