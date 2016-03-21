//
//  AZSSuggestion.swift
//  azure-search-basics
//
//  Created by Mark Hamilton on 3/14/16.
//  Copyright © 2016 dryverless. All rights reserved.
//

import Foundation
import UIKit

struct AZSSuggestion {
    
    // https://github.search.windows.net/indexes/homes/docs/suggest?q="ge"$orderby=count$select=city,state,zip&api-key=7244003F2B881848BB13CA6CA2565533&api-version=2015-02-28&highlightPostTag=%3C%2Fstrong%3E&highlightPreTag=%3Cstrong%3E&search=a&suggesterName=homes-sg
    
    /* 
    
        let stringAttributes = [
            NSFontAttributeName : UIFont(name: "Helvetica Neue", size: 17.0)!,
            NSUnderlineStyleAttributeName : 1,
            NSForegroundColorAttributeName : UIColor.orangeColor(),
            NSTextEffectAttributeName : NSTextEffectLetterpressStyle,
            NSStrokeWidthAttributeName : 2.0]
        
        let atrributedString = NSAttributedString(string: "Sample String: Attributed", attributes: stringAttributes)
        
        sampleLabel.attributedText = atrributedString
    
    */
    
    // id, title
    
    private var _id: String?
    private var _value: [String : AnyObject]?
    private var _searchText: String?
    private var _attributedText: NSAttributedString?
    
    var id: String {
        
        return _id ?? ""
    }
    
    var searchText: String {
        
        get {
        
            return _searchText ?? ""
            
        }
        
    }
    
    var attributedText: NSAttributedString {
        
        get {
            
            return _attributedText ?? NSAttributedString()
            
        }
        
    }
    
    init(value: [String : AnyObject]) {
        
        self._value = value
        
        if let i: String = value["id"] as? String {
            
            self._id = i
            
        }
        
        if let t: String = value["@search.text"] as? String {
            
            self._searchText = t
            
            do {
                
                let attributed: NSAttributedString = try NSAttributedString(data: t.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
                
                self._attributedText = attributed
            
            } catch let err as NSError {
            
                print(err.debugDescription)
            
            }
            
        }
        
    }
    
    
    
}