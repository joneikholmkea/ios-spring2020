//
//  FirebaseRepo.swift
//  MapDemo2020
//
//  Created by Jon Eikholm on 20/03/2020.
//  Copyright © 2020 Jon Eikholm. All rights reserved.
//

import Foundation
import FirebaseFirestore
import MapKit
class FirebaseRepo {

    private static let db = Firestore.firestore() // gets the Firebase instance
    private static let path = "locations"
    
    static func startListener(vc: ViewController){
        print("listener started")
        // when there is a result, call
        //vc.updateMarkers()
        db.collection(path).addSnapshotListener { (snap, error) in
            if error != nil {  // check if there is an error. If so, then return
                return
            }
            var markers = [MKPointAnnotation]() // create an empty list
            for doc in snap!.documents {
                print("received data: ")
                let map = doc.data() // the data is delivered in a map
                let text = map["text"] as! String
                let geoPoint = map["coordinates"] as! GeoPoint
                let mkAnnotation = MKPointAnnotation()
                mkAnnotation.title = text
                let coordinate = CLLocationCoordinate2D(latitude: geoPoint.latitude, longitude: geoPoint.longitude)
                mkAnnotation.coordinate = coordinate
                markers.append(mkAnnotation)
            }
            vc.updateMarkers(markers: markers) // call viewController, passing the list as a param.
        }
    }
    
}
