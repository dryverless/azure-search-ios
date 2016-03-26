//
//  TrailDetailVC.swift
//  azure-search-basics
//
//  Created by Mark Hamilton on 3/14/16.
//  Copyright © 2016 dryverless. All rights reserved.
//

import Foundation
import MapKit

class TrailDetailVC: AZSDetailVC, GeoSearch, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate {
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    var regionRadius: CLLocationDistance = 1000
    var trail: Trail! = Trail()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        map.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        setupTrailMap()
    
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //setupTrailMap()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        setupTrailMap()
    }
    
    func setupTrailMap() {
        
        do {
            
            let loc = try trail!.location.asCoordinate2D()
            centerMapOnCoordinate2D(loc)
            
            delay(2) {
                self.createAnnotationFromTrail()
            }
            
        } catch let err as NSError {
            
            print(err)
            
        }
        
        self.title = trail.name
        
        tableView.reloadData()
        
    }

    
    // MARK: - GeoSearch Protocol Methods
    
    func locateWithCoordinates(Longitude lon: Double, Latitude lat: Double, locationTitle title: String?) {
        
        dispatch_async(GlobalMainQueue) { () -> Void in
            
            let position = CLLocationCoordinate2DMake(lat, lon)
            self.centerMapOnCoordinate2D(position)
            
        }
        
    }
    
    // MARK: - Map and Annotation
    
    func centerMapOnCoordinate2D(location: CLLocationCoordinate2D) {
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location, regionRadius * 2, regionRadius * 2)
        //map.mapType = MKMapType.HybridFlyover
        map.setRegion(coordinateRegion, animated: true)
        
    }
    
    func createAnnotationFromTrail() {
        
        let annotation = AZSMapAnnotation(title: trail.name, subtitle: "\(trail.elevation) m", coordinate: try! trail.location.asCoordinate2D())
        
        map.addAnnotation(annotation)
        
    }
    

    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation.isKindOfClass(AZSMapAnnotation) {
            
            let annoView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Default")
            
            // Default is redColor()
            annoView.pinTintColor = UIColor.blueColor()
            
            // Default is false
            annoView.animatesDrop = true
            
            // No Delay
            return annoView
            
        } else if annotation.isKindOfClass(MKUserLocation) {
            
            let annoView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Default")
            
            // Default is redColor()
            
            // Default is false
            annoView.animatesDrop = true
            
            // No Delay
            return annoView
        }
        
        return nil
        
    }
    
    // MARK: - Table View (One Cell)
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    
        return 1
    
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return 2
    
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        if (indexPath.row == 0) {
            cell.textLabel?.text = "\(self.trail!.name)"
            cell.detailTextLabel?.text = ""
            
        } else {
            cell.textLabel?.text = "County: \(self.trail!.county)"
            cell.detailTextLabel?.text = "Elevation: \(self.trail!.elevation) m"
        }
    
        return cell
    
    }

}
