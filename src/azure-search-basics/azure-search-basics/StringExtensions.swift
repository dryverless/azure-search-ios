//
//  StringExtensions.swift
//  azure-search-basics
//
//  Created by Mark Hamilton on 3/31/16.
//  Copyright © 2016 dryverless. All rights reserved.
//

import Foundation

// In case they ever let subscripts throw
//public extension String {
//    
//    internal enum SubscriptError: ErrorType {
//        
//        case InvalidFirstChar
//        
//        case InvalidLastChar
//        
//    }
//
//
//    subscript(range: Range<Int>) throws -> String {
//        
//        guard let firstChar = startIndex.advancedBy(range.startIndex) else {
//    
//            throw SubscriptError.InvalidFirstChar
//        }
//    
//        guard  let lastChar = startIndex.advancedBy(range.endIndex) else {
//    
//            throw SubscriptError.InvalidLastChar
//    
//        }
//    
//        return self[firstChar...<lastChar]
//        
//        
//    }
//
//}

public extension String {
    
    subscript(index: Int) -> Character {
        
        return self[startIndex.advancedBy(index)]
        
    }
    
    subscript(range: Range<Int>) -> String {
        
        let char0 = startIndex.advancedBy(range.startIndex)
        
        let charN = startIndex.advancedBy(range.endIndex)
        
        return self[char0..<charN]
        
    }
    
}