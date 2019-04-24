//
//  UpdateService.swift
//  Live Bus Time
//
//  Created by Kabir on 22/04/2019.
//  Copyright © 2019 Kabir. All rights reserved.
//

import UIKit
import MapKit
import Firebase

//UpdateService will be available during the entire lifecycle of the app
class UpdateService {
    static var instance = UpdateService()
    
    func updateUserLocation(withCoordinate coordinate: CLLocationCoordinate2D) {
        DataService.instance.REF_USERS.observeSingleEvent(of: .value, with: { (snapshot) in
            if let userSnapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for user in userSnapshot {
                    if user.key == Auth.auth().currentUser?.uid {
                        DataService.instance.REF_USERS.child(user.key).updateChildValues(["coordinate": [coordinate.latitude, coordinate.longitude]])
                    }
                }
            }
        })
    }
    func updateDriverLocation(withCoordinate coordinate: CLLocationCoordinate2D) {
        DataService.instance.REF_DRIVERS.observeSingleEvent(of: .value, with: { (snapshot) in
            if let driverSnapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for driver in driverSnapshot {
                    if driver.key == Auth.auth().currentUser?.uid {
                        if driver.childSnapshot(forPath: "IsPickupModeEnabled").value as? Bool == true {
                            DataService.instance.REF_DRIVERS.child(driver.key).updateChildValues(["coordinate": [coordinate.latitude, coordinate.longitude]])
                        }
                    }
                }
            }
        })
    }
}
func updateTripsWithCoordinatesUponRequest() {
    
    DataService.instance.REF_USERS.observeSingleEvent(of: .value, with: { (snapshot) in
        
        if let userSnapshot = snapshot.children.allObjects as? [DataSnapshot]
        {
            for user in userSnapshot
            {
                if user.key == Auth.auth().currentUser?.uid
                {
                    if !user.hasChild("userIsDriver")
                    {
                        if let userDict = user.value as? Dictionary<String, AnyObject>
                        {
                            let pickupArray = userDict["coordinate"] as! NSArray
                            let destinationArray = userDict["tripCoordinate"] as! NSArray
                            
                            DataService.instance.REF_TRIPS.child(user.key).updateChildValues(["pickupCoordinate" : [pickupArray[0], pickupArray[1]], "destinationcoordinate" : [destinationArray[0], destinationArray[1]], "passengerKey" : user.key, "tripIsAccepted" : false])
                        }
                    }
                }
            }
        }
    })
}
