//
//  FirebaseRepo.swift
//  MapDemo2020
//
//  Created by Jon Eikholm on 20/03/2020.
//  Copyright © 2020 Jon Eikholm. All rights reserved.
//

import Foundation
import FirebaseFirestore

class FirebaseRepo {

    private static let db = Firestore.firestore() // gets the Firebase instance
    private static let path = "locations"
    
    static func startListener(vc: ViewController){
        db.collection(path).addSnapshotListener { (snap, error) in
            if error != nil {  // check if there is an error. If so, then return
                return
            }

            if let snap = snap { // we check, if the snap has a value.
                // if snap does have a value, it is reassigned to another variable, also called snap
                // This is a way of unwrapping the snap Optional
                vc.updateMarkers(snap: snap)
            }
        }
    }
    
    static func addMarker(title:String, lat:Double, lon:Double){
        let ref = db.collection(path).document()
        var map = [String:Any]()
        map["text"] = title
        map["coordinates"] = GeoPoint(latitude: lat, longitude: lon)
        ref.setData(map)
    }
    
}
