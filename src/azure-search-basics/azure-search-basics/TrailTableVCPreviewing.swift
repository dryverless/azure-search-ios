//
//  TrailTableVCPreviewing.swift
//  azure-search-basics
//
//  Created by Mark Hamilton on 3/21/16.
//  Copyright © 2016 dryverless. All rights reserved.
//

//import Foundation
//import UIKit
//
//extension TrailTableVC: UIViewControllerPreviewingDelegate {
//    
//    // MARK: UIViewControllerPreviewingDelegate
//    
//    /// Create a previewing view controller to be shown at "Peek".
//    
//    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
//        
//        // Obtain the index path and the cell that was pressed.
//        
//        guard let indexPath = tableView.indexPathForRowAtPoint(location),
//            
//            cell = tableView.cellForRowAtIndexPath(indexPath) else { return nil }
//        
//        // Create a AZSDetailVC and set its properties.
//        
//        guard let TrailDetailVC = storyboard?.instantiateViewControllerWithIdentifier("TrailDetailVC") as? TrailDetailVC else { return nil }
//        
//        //        var previewDetail: AnyObject!
//        //
//        //        if searchController.active {
//        //
//        //            if let result = self.suggestedSearchResults[indexPath.row] as? AZSResult {
//        //
//        //                previewDetail = result
//        //
//        //            }
//        //
//        //        } else {
//        //
//        //            if let result = self.searchResults[indexPath.row] {
//        //
//        //                previewDetail = result
//        //
//        //            }
//        //
//        //        }
//        
//        // Pass previewDetail to TrailDetailVC here
//        
//        TrailDetailVC.result = previewDetail
//        
//        TrailDetailVC.preferredContentSize = CGSize(width: 0.0, height: 0.0) // Default height and width
//        
//        // Set the source rect to the cell frame, so surrounding elements are blurred.
//        
//        previewingContext.sourceRect = cell.frame
//        
//        return TrailDetailVC
//        
//    }
//    
//    
//    /// Present the view controller for the "Pop" action.
//    
//    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
//        
//        // Reuse the "Peek" view controller for presentation.
//        
//        showViewController(viewControllerToCommit, sender: self)
//        
//    }
//    
//}