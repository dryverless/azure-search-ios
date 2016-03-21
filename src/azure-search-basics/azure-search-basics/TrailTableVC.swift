//
//  TrailTableVC.swift
//  azure-search-basics
//
//  Created by Mark Hamilton on 3/14/16.
//  Copyright © 2016 dryverless. All rights reserved.
//

import Foundation
import UIKit

class TrailTableVC: AZSTableVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register Custom Cell
        let nib = UINib(nibName: "TrailCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "TrailCell")
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> TrailCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TrailCell", forIndexPath: indexPath) as! TrailCell
        
        var cellTrail: Trail!
        
        do {
            
            cellTrail = try Trail(trail: searchResults!.results["value"]![indexPath.row] as! [String: AnyObject])
        
        } catch {
            
            print(error)
            
        }
        
        cell.configureCell(cellTrail)
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var cellTrail: Trail!
        
        do {
            
            cellTrail = try Trail(trail: searchResults!.results["value"]![indexPath.row] as! [String: AnyObject])
            
        } catch {
            
            print(error)
            
        }
        
        self.performSegueWithIdentifier("TrailDetailVC", sender: cellTrail as? AnyObject)
        
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        if segue.identifier == "TrailDetailVC" {
    
            if let detailVC = segue.destinationViewController as? TrailDetailVC {
    
                if let trail = sender as? Trail {
    
                    detailVC.trail = trail
    
                }
    
            }
                
        }
            
    }
    
    // MARK: Override 3D Touch DetailVC
    
    override func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        // Obtain the index path and the cell that was pressed.
        
        guard let indexPath = tableView.indexPathForRowAtPoint(location),
            
            cell = tableView.cellForRowAtIndexPath(indexPath) else { return nil }
        
        // Create a TrailDetailVC and set its properties.
        
        guard let TrailDetailVC = storyboard?.instantiateViewControllerWithIdentifier("TrailDetailVC") as? TrailDetailVC else { return nil }
        
        var cellTrail: Trail!
        
        do {
            
            cellTrail = try Trail(trail: searchResults!.results["value"]![indexPath.row] as! [String: AnyObject])
            
        } catch {
            
            print(error)
            
        }
        
        // Pass previewDetail to TrailDetailVC here
        
        TrailDetailVC.trail = cellTrail
        
        TrailDetailVC.preferredContentSize = CGSize(width: 0.0, height: 0.0) // Default height and width
        
        // Set the source rect to the cell frame, so surrounding elements are blurred.
        
        previewingContext.sourceRect = cell.frame
        
        return TrailDetailVC
        
    }
    
}

