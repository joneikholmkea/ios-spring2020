//
//  ViewController.swift
//  MapDemo2020
//
//  Created by Jon Eikholm on 20/03/2020.
//  Copyright © 2020 Jon Eikholm. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let marker = MKPointAnnotation() // create an empty marker
        marker.title = "Go here" // a message on the marker
        let location = CLLocationCoordinate2D(latitude: 55.7, longitude: 12.5) // Denmark in the world
        marker.coordinate = location // add the location to this marker
        map.addAnnotation(marker)// is a marker (red), where the user can click for more info
        
        FirebaseRepo.startListener(vc: self)
    }
    
    func updateMarkers(markers:[MKPointAnnotation]) {
        print("updating markers...")
        // make a loop, iterating through the markers list
        map.removeAnnotations(map.annotations) // clear the map
        map.addAnnotations(markers)
        
    }


}

