//
//  AZSTableVC.swift
//  azure-search-basics
//
//  Created by Mark Hamilton on 3/11/16.
//  Copyright © 2016 dryverless. All rights reserved.
//

import UIKit
import Alamofire
//import PeekPop

class AZSTableVC: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    //var peekPop: PeekPop?
    
    var searchResults: AZSResults?
    var suggestedSearchResults = [AnyObject]() // AZSSuggestions()
    
    var alertController: UIAlertController?
    var searchController = UISearchController()
    
    var searchActive: Bool = false
    var searchQuery: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.tableView.delegate = self
        //self.tableView.dataSource = self
        
        performSearch(searchQuery)
        
        
        //peekPop = PeekPop(viewController: self)
        //peekPop?.registerForPreviewingWithDelegate(self, sourceView: view)
        
        // Check for force touch feature, and add force touch/previewing capability.
        
//        if traitCollection.forceTouchCapability == .Available {
//            
//            /*
//            
//            Register for `UIViewControllerPreviewingDelegate` to enable
//            
//            "Peek" and "Pop".
//            
//            (see: AZSResultsVCPreviewing.swift)
//            
//
//            
//            The view controller will be automatically unregistered when it is
//            
//            deallocated.
//            
//            */
//            
//            registerForPreviewingWithDelegate(self, sourceView: view)
//            
//        }
//            
//        else {
//            
//            // Create an alert to display to the user.
//            
//            alertController = UIAlertController(title: "3D Touch Not Available", message: "Unsupported device.", preferredStyle: .Alert)
//            
//        }
        
        self.loadSearchController()
        
        // Register Suggestion Cell
        let nib = UINib(nibName: "AZSSuggestionCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "AZSSuggestionCell")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        // Clear the selection if the split view is only showing one view controller.
        
        //clearsSelectionOnViewWillAppear = splitViewController!.collapsed
        
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        // Present the alert if necessary.
        
        if let alertController = alertController {
            
            alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            
            presentViewController(alertController, animated: true, completion: nil)
            
            
            // Clear the `alertController` to ensure it's not presented multiple times.
            
            self.alertController = nil
            
        }
        
        animateTableViewCells()
        
    }
    
    
    func animateTableViewCells() {
        
        tableView.animateData()
        
        if searchQuery == "" {
          
            searchController.searchBar.placeholder = "Search"
            
        } else {
            
            searchController.searchBar.placeholder = searchQuery
            //searchController.searchBar.text = searchQuery
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Search Controller Configuration
    
    func loadSearchController() {
        
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchBar.delegate = self
        self.searchController.searchResultsUpdater = self
        
        self.searchController.dimsBackgroundDuringPresentation = false
        
        self.searchController.searchBar.sizeToFit()
        self.searchController.searchBar.returnKeyType = UIReturnKeyType.Done
        
        self.tableView.tableHeaderView = self.searchController.searchBar
        
        self.tableView.reloadData()
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchController.searchBar.text == nil || searchController.searchBar.text == "" {
            
            searchActive = false
            view.endEditing(true)
            
            searchQuery = ""
            
            performSearch(searchQuery)
            
            
        } else {
            
            searchActive = true
            
            searchQuery = searchText
            
            performSearch(searchText)
            
        }
        
    }
    
    func updateSearchResultsForSearchController(searchCtrl: UISearchController) {
        
        self.suggestedSearchResults.removeAll(keepCapacity: false)
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        
        view.endEditing(true)
        
        if let query = searchBar.text {
            if query == "" {
                
                searchController.searchBar.placeholder = "Search"
                searchQuery = ""
                
            }
            performSearch(query)
            
        } else {
            
            performSearch(searchQuery)
            
        }
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        view.endEditing(true)
        
        //performSearch(searchBar.text!)
        
        searchController.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        
        view.endEditing(true)
        
        if let query = searchBar.text {
            if query == "" {
                
                searchController.searchBar.placeholder = "Search"
                searchQuery = ""
                
            }
            performSearch(query)
            
        } else {
            
            performSearch(searchQuery)
            
        }
    
    }
    
    // , facets: AZSFacet?
    func performSearch(searchText: String) {
        
        let _searchEncoded: String = searchText.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet()) ?? ""
        
        let _searchUrl: String = "\(BASE_URL)\(_searchEncoded)&fuzzy=true"
        
        let url = NSURL(string: _searchUrl)!
        
        Alamofire.request(.GET, url, headers: SEARCH_HEADERS).responseJSON { response in
            
            let result = response.result
            
            if let results = result.value as? [String : AnyObject] {
                
                print(results.debugDescription)
                
                self.searchResults = AZSResults(results: results)
                self.animateTableViewCells()
                
            }
            
        }
        
    }
    
    func performSearchForTopResult(searchText: String) {
        
        // perform search
        
        // set results to temporary var upon completion
        
        // grab ["value"][0] and return
        
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if searchController.active {
            
            // switch to suggested results
            if let suggestedResultsCount: Int = searchResults?.results["value"]?.count ?? 0 {
                
                return suggestedResultsCount
                
            }
            
        } else {
            
            if let resultsCount: Int = searchResults?.results["value"]?.count ?? 0 {
                
                return resultsCount
                
            }
        }
        

    
    }

    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 100.0
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AZSResultCell", forIndexPath: indexPath) // as? AZSResultCell ?? UITableViewCell()

        // Configure the cell...
        
        if let resultName: AnyObject =  searchResults?.results["value"]?[indexPath.row]?["name"] as? String ?? String() {
            
            cell.textLabel?.text = "\(resultName)"
            
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //var cellResult = AZSResult()
        
        if self.searchController.active {
            
            // change to suggestions var
            if let suggestion = self.searchResults!.value[indexPath.row] as? AZSResult {
                
                print(suggestion)
                
            }
            
        } else {
            
            // Don't need cast here if using AZSResult as object type in array
            if let result = self.searchResults!.value[indexPath.row] as? AZSResult {
                
                print(result)
                
            }
            
        }
        
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "AZSDetailVC" {
            
            if let detailVC = segue.destinationViewController as? AZSDetailVC {
                
                if let azsresult = sender as? AZSResult {
                    
                    detailVC.result = azsresult as? AnyObject
                    
                }
                
            }
            
        }
        
    }

}
