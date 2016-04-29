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
    
    var beaconManager:BLUBeaconManager!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        beaconManager = BLUBeaconManager(delegate: self)
        beaconManager.startScanningForBeacons()
    }
    
    
    
    
    func beaconManager(manager: BLUBeaconManager, didFindBeacon beacon: BLUBeacon) {
        print ("== didFindBeacon \((beacon as? BLUSBeacon)?.identifier) \((beacon as? BLUSBeacon)?.name)")
        print ("RSSI: \(beacon.RSSI)")
        print ("VisibilityTimeoutInterval: \(beacon.visibilityTimeoutInterval)")
        
        if let sbeacon = beacon as? BLUSBeacon {
            print (sbeacon.temperature.degreesCelsius())
        }
        
    }
    
    func beaconManager(manager: BLUBeaconManager, beacon: BLUBeacon, didChangeDistance distance: BLUDistance) {
        if let sbeacon = beacon as? BLUSBeacon {
            print ("\(sbeacon.identifier) \(sbeacon.name) \(getDistance(sbeacon))")
            if sbeacon.name == "StickNfind" {
                print ("\(sbeacon.RSSI)")
                self.distanceLabel.text = sbeacon.name + " is " + getDistance(sbeacon)
                // let speechUtterance = AVSpeechUtterance(string: sbeacon.name + " is " + getDistance(sbeacon))
                // speechSynthesizer.speakUtterance(speechUtterance)
            }
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

