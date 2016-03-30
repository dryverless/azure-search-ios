//
//  TrailTableVC.swift
//  azure-search-basics
//
//  Created by Mark Hamilton on 3/14/16.
//  Copyright © 2016 dryverless. All rights reserved.
//

import Foundation
import UIKit
import PeekPop

class TrailTableVC: AZSTableVC, PeekPopPreviewingDelegate {
    
    var peekPop: PeekPop?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register Custom Cell
        let nib = UINib(nibName: "TrailCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "TrailCell")
        
        peekPop = PeekPop(viewController: self)
        peekPop?.registerForPreviewingWithDelegate(self, sourceView: tableView)
        
        self.refreshControl?.addTarget(self, action: #selector(handleRefresh), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        
        // Do reloading of data and update tableView appearance.
        
        // Use this for fetching more objects.
        
        tableView.reloadData()
        refreshControl.endRefreshing()
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TrailCell", forIndexPath: indexPath) as! TrailCell
        
        var cellTrail: Trail!

        let selectedTrail = self.searchResults!.value[indexPath.row]
        
        do {
            
            cellTrail = try Trail(trail: selectedTrail)
        
        } catch {
            
            print(error)
            
        }
        
        cell.configureCell(cellTrail)
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cellTrail = self.searchResults!.value[indexPath.row]

        
        self.performSegueWithIdentifier("TrailDetailVC", sender: cellTrail)
        
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        if segue.identifier == "TrailDetailVC" {
    
            if let detailVC = segue.destinationViewController as? TrailDetailVC {
    
                if let trail = sender as? [String : AnyObject] {
    
                    do {
                        
                        detailVC.trail = try Trail(trail: trail)
                        
                    } catch {
                        
                        print(error)
                        return
                        
                    }
    
                }
    
            }
                
        }
            
    }
    
    // MARK: Override 3D Touch DetailVC
    
    func previewingContext(previewingContext: PreviewingContext, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        // Obtain the index path and the cell that was pressed.
        
        guard let indexPath = tableView.indexPathForRowAtPoint(location),
            
            cell = tableView.cellForRowAtIndexPath(indexPath) else { return nil }
        
        // Create a TrailDetailVC and set its properties.
        
        guard let TrailDetailVC = storyboard?.instantiateViewControllerWithIdentifier("TrailDetailVC") as? TrailDetailVC else { return nil }
        
        let cellTrail = self.searchResults!.value[indexPath.row]
        
        
        // Pass previewDetail to TrailDetailVC here
        
        do {
            
            TrailDetailVC.trail = try Trail(trail: cellTrail)
            
        } catch let err as NSError {
            
            print(err)
            
        }
        
        TrailDetailVC.preferredContentSize = CGSize(width: 0.0, height: 0.0) // Default height and width
        
        // Set the source rect to the cell frame, so surrounding elements are blurred.
        
        previewingContext.sourceRect = cell.frame
        
        return TrailDetailVC
        
    }
    
    /// Present the view controller for the "Pop" action.
    
    func previewingContext(previewingContext: PreviewingContext, commitViewController viewControllerToCommit: UIViewController) {
        
        // Reuse the "Peek" view controller for presentation.
        
        showViewController(viewControllerToCommit, sender: self)
        
    }
    
}

