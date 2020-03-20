//
//  ViewController.swift
//  MapDemo2020
//
//  Created by Jon Eikholm on 20/03/2020.
//  Copyright © 2020 Jon Eikholm. All rights reserved.
//

import UIKit
import MapKit
import FirebaseFirestore
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager() // will handle location (GPS, WiFi) updates
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // ask user to approve location sharing with the app
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer // how precise do you want it?
       // locationManager.startUpdatingLocation() // start getting location data from device in a continuous stream
        createDemoMarker()// is a marker (red), where the user can click for more info
        FirebaseRepo.startListener(vc: self)
        map.showsUserLocation = true
        
        //locationManager.stopUpdatingLocation()// will stop the updates
    }
    
    func updateMarkers(snap: QuerySnapshot ) { // now we get the "raw" data from FirebaseRepo
        let markers = MapDataAdapter.getMKAnnotationsFromData(snap: snap) // call adapter to convert data
        map.removeAnnotations(map.annotations) // clear the map
        map.addAnnotations(markers)
    }

    
    @IBAction func longPressed(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .ended {  // limit amount of calls to just ONE
            // we don't want to put a marker on the map ourselves, because that will come from Firebase !
            let cgPoint = sender.location(in: map)
            // now we need to convert x,y to latitude, longitude
            let coordinate2D = map.convert(cgPoint, toCoordinateFrom: map)
            print("long pressed \(coordinate2D)")
            FirebaseRepo.addMarker(title: "test", lat: coordinate2D.latitude, lon: coordinate2D.longitude)
        }
    }
    
    @IBAction func startUpdate(_ sender: UIButton) {
        locationManager.startUpdatingLocation()
    }
    
    @IBAction func stopUpdate(_ sender: UIButton) {
        locationManager.stopUpdatingLocation()
    }
    
    fileprivate func createDemoMarker() {
           let marker = MKPointAnnotation() // create an empty marker
           marker.title = "Go here" // a message on the marker
           let location = CLLocationCoordinate2D(latitude: 55.7, longitude: 12.5) // Denmark in the world
           marker.coordinate = location // add the location to this marker
           map.addAnnotation(marker)
       }
}
extension ViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coord = locations.last?.coordinate {
            print("new location")
            let region = MKCoordinateRegion(center: coord, latitudinalMeters: 300, longitudinalMeters: 300)
            map.setRegion(region, animated: true) // will move the "camera"
        }
    }
}
