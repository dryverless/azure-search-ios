//
//  AZSSuggestion.swift
//  azure-search-basics
//
//  Created by Mark Hamilton on 3/14/16.
//  Copyright © 2016 dryverless. All rights reserved.
//

import Foundation

class AZSSuggestion: NSObject {
    
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
    private var _title: String?
    private var _attributedText: NSAttributedString?
    
    var id: String {
        
        return _id ?? String()
    }
    
    var title: String {
        
        return _title ?? String()
    }
    
}