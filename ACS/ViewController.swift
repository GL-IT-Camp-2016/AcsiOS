//
//  ViewController.swift
//  ACS
//
//  Created by Roman Hauptvogel on 29/04/16.
//  Copyright © 2016 GLACS. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, BLUBeaconManagerDelegate {

    @IBOutlet weak var distanceLabel: UILabel! // result
    @IBOutlet weak var beanA: UILabel!
    @IBOutlet weak var beanB: UILabel!
    @IBOutlet weak var stateBeanA: UILabel!
    @IBOutlet weak var stateBeanB: UILabel!
    @IBOutlet weak var distanceBeanA: UILabel!
    @IBOutlet weak var distanceBeanB: UILabel!
    @IBOutlet weak var oldState: UILabel!
    @IBOutlet weak var newState: UILabel!
    @IBOutlet weak var actualTime: UILabel!
    
    let STICK_UUID:String="BEC26202-A8D8-4A94-80FC-9AC1DE37DAA6"

    var service:RestApiManager!
    var aram:AttendanceRestApiManager!
    var stateResolver:StateResolver!
    var state:PositionState!
    var timer:NSTimer!

    // /attendance/store/arrival/	POST	person_name, timestamp
    // /attendance/store/departure/	POST	person_name, timestamp
    // /attendance/list/            GET     person_name
    // /person/list/                GET     -
    
    var beaconManager:BLUBeaconManager!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.service = RestApiManager()
        self.aram = AttendanceRestApiManager()
        self.stateResolver = StateResolver()
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "onTick", userInfo: nil, repeats: true)
        self.distanceLabel.text = "Status"
        self.beanA.text = "Bean A:"
        self.beanB.text = "Bean B:"
        self.state = PositionState.BothFar

        beaconManager = BLUBeaconManager(delegate: self)
        beaconManager.startScanningForBeacons()
    }
    
    func onTick()
    {
        self.actualTime.text = String(NSDate().timeIntervalSince1970)
    }
    func beaconManager(manager: BLUBeaconManager, didFindBeacon beacon: BLUBeacon) {
//        
        if let sbeacon = beacon as? BLUSBeacon {
            sbeacon.configuration.sBeaconV1AdvancedSettings.advertisementInterval = NSTimeInterval(0.5)
            sbeacon.configuration.sBeaconV2AdvancedSettings.advertisementInterval = NSTimeInterval(1)
        }

    }
    
    func beaconManager(manager: BLUBeaconManager, beacon: BLUBeacon, didChangeDistance distance: BLUDistance) {
        if let sbeacon = beacon as? BLUSBeacon {
            if self.stateResolver.isBeaconA(sbeacon) || self.stateResolver.isBeaconB(sbeacon){
                resolveState(sbeacon)
                
                if self.stateResolver.isBeaconA(sbeacon){
                    self.stateBeanA.text = getDistance(sbeacon)
                    self.distanceBeanA.text = String(sbeacon.RSSI)
                }else if self.stateResolver.isBeaconB(sbeacon){
                    self.stateBeanB.text = getDistance(sbeacon)
                    self.distanceBeanB.text = String(sbeacon.RSSI)
                }
            }
            
            //print ("\(sbeacon.identifier) \(sbeacon.name) \(getDistance(sbeacon))")
        }
    }
    
    func resolveState(beacon: BLUSBeacon){
        let newState = self.stateResolver.getNewState(beacon)
        if newState == self.state {
            return
        }
        self.oldState.text = self.state.rawValue
        self.newState.text = newState.rawValue
        if self.stateResolver.isArrival(self.state, newState: newState){
            self.aram.postArrival("Peter")
            self.distanceLabel.text = "Arrival"
            speak("Dobré ráno Vaša excelencia, ďakujeme, že ste dnes prišli do práce.", language: "sk-SK")
            self.view.backgroundColor = UIColor.greenColor()
        } else if self.stateResolver.isDeparture(self.state, newState: newState){
            self.aram.postDeparture("Peter")
            self.distanceLabel.text = "Departure"
            speak("Jejich výsosti, přeji vám hezký večer. Naschledanou někdy příště.", language: "cs-CZ")
            self.view.backgroundColor = UIColor.redColor()
        }
        self.state = newState
    }
    
    func beaconManager(manager: BLUBeaconManager, didStartMonitoringForRegion region: CLBeaconRegion){
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
    
    func speak(sentence:String, language:String) -> () {
        let speechSynthesizer = AVSpeechSynthesizer()
        let speechUtterance = AVSpeechUtterance(string: sentence)
        speechUtterance.voice = AVSpeechSynthesisVoice(language: language)
        speechUtterance.rate = AVSpeechUtteranceDefaultSpeechRate * 1.07
        speechSynthesizer.speakUtterance(speechUtterance)
    }
}

