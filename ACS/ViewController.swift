//
//  ViewController.swift
//  ACS
//
//  Created by Roman Hauptvogel on 29/04/16.
//  Copyright © 2016 GLACS. All rights reserved.
//

import UIKit

class ViewController: UIViewController, BLUBeaconManagerDelegate {

    @IBOutlet weak var distanceLabel: UILabel!
    
    let STICK_UUID:String="BEC26202-A8D8-4A94-80FC-9AC1DE37DAA6"
    let BASE_URL:String = "http://itc16.herokuapp.com"
    let ARRIVAL_URI:String = "/attendance/store/arrival/"
    let DEPARTURE_URI:String = "/attendance/store/departure/"

    var service:RestApiManager!
    var aram:AttendanceRestApiManager!

    // /attendance/store/arrival/	POST	person_name, timestamp
    // /attendance/store/departure/	POST	person_name, timestamp
    // /attendance/list/            GET     person_name
    // /person/list/                GET     -
    
    var beaconManager:BLUBeaconManager!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.service = RestApiManager()
        // let serverResponse = self.service.makeHTTPGetRequest(BASE_URL+"/person/list/")
        self.aram = AttendanceRestApiManager()
        let serverResponse = self.aram.postArrival(BASE_URL+ARRIVAL_URI, username: "Peter")


        beaconManager = BLUBeaconManager(delegate: self)
        beaconManager.startScanningForBeacons()
    }
    
    
    
    
    func beaconManager(manager: BLUBeaconManager, didFindBeacon beacon: BLUBeacon) {
//        print ("== didFindBeacon \((beacon as? BLUSBeacon)?.identifier) \((beacon as? BLUSBeacon)?.name)")
//        print ("RSSI: \(beacon.RSSI)")
//        print ("VisibilityTimeoutInterval: \(beacon.visibilityTimeoutInterval)")
//        
//        if let sbeacon = beacon as? BLUSBeacon {
//            print (sbeacon.temperature.degreesCelsius())
//        }

    }
    
    func beaconManager(manager: BLUBeaconManager, beacon: BLUBeacon, didChangeDistance distance: BLUDistance) {
        if let sbeacon = beacon as? BLUSBeacon {
            print ("\(sbeacon.identifier) \(sbeacon.name) \(getDistance(sbeacon))")
//            if sbeacon.name == "StickNfind" {
//                print ("\(sbeacon.RSSI)")
//                let distance = sbeacon.name + " is " + getDistance(sbeacon)
//                self.distanceLabel.text = distance
//                // let speechUtterance = AVSpeechUtterance(string: sbeacon.name + " is " + getDistance(sbeacon))
//                // speechSynthesizer.speakUtterance(speechUtterance)
//            }
        }
    }
    
    func beaconManager(manager: BLUBeaconManager, didStartMonitoringForRegion region: CLBeaconRegion) {
        //print (region.major)
        //print (region.minor)
    }
    
    func getDistance(beacon:BLUBeacon) -> String {
        switch beacon.distance {
        case .Far:
            return "Far"
        case .Imminent:
            return "Imminent"
        case .Near:
            return "Near"
        case .Unknown:
            return "Unknown"
        }
    }

}

