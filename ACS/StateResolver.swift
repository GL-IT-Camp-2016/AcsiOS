//
//  StateResolver.swift
//  ACS
//
//  Created by Roman Hauptvogel on 29/04/16.
//  Copyright © 2016 GLACS. All rights reserved.
//

import Foundation

class StateResolver {
    
    let BEACON_A:String = "13348293197466712900"
    let BEACON_B:String = "2063200344559079996"
    
    var beaconStateA:BeaconState! = BeaconState.Unknown
    var beaconStateB:BeaconState! = BeaconState.Unknown

    func getNewState(beacon: BLUSBeacon) -> PositionState{
        changeBeaconState(beacon)
        
        if beaconStateA == BeaconState.Far && beaconStateB == BeaconState.Near {
            return PositionState.FarANearB
        } else if beaconStateB == BeaconState.Far && beaconStateA == BeaconState.Near{
            return PositionState.NearAFarB
        } else if beaconStateB == BeaconState.Far && beaconStateA == BeaconState.Far{
            return PositionState.BothFar
        } else if beaconStateB == BeaconState.Near && beaconStateA == BeaconState.Near{
            return PositionState.BothNear
        } else if beaconStateB == BeaconState.Unknown && beaconStateA != BeaconState.Unknown{
            return PositionState.OnlyA
        } else if beaconStateB != BeaconState.Unknown && beaconStateA == BeaconState.Unknown{
            return PositionState.OnlyB
        }
        return PositionState.NoBean
    }
    
    func isBeaconA(beacon: BLUSBeacon) -> Bool{
        let stringId = String(beacon.identifier)
        return stringId == BEACON_A
    }
    
    func isBeaconB(beacon: BLUSBeacon) -> Bool{
        let stringId = String(beacon.identifier)
        return stringId == BEACON_B
    }
    
    func changeBeaconState(beacon: BLUSBeacon){
        let stringId = String(beacon.identifier)
        if stringId == BEACON_A {
            self.beaconStateA = getBeaconState(beacon)
        } else if stringId == BEACON_B {
            self.beaconStateB = getBeaconState(beacon)
        }
    }
    
    func isArrival(oldState:PositionState, newState:PositionState) -> Bool{
        return (oldState == PositionState.NearAFarB && newState == PositionState.FarANearB) ||
        (oldState == PositionState.BothNear && newState == PositionState.FarANearB)
    }
    
    func isDeparture(oldState:PositionState, newState:PositionState) -> Bool{
        return (oldState == PositionState.FarANearB && newState == PositionState.NearAFarB) ||
        (oldState == PositionState.BothNear && newState == PositionState.NearAFarB)
    }
    
    let intConst:Int = -70
    func getBeaconState(beacon: BLUSBeacon) -> BeaconState{
        if Int(beacon.RSSI) > intConst && Int(beacon.RSSI) < 0{
        return BeaconState.Near
        }else if Int(beacon.RSSI) <= intConst{
            return BeaconState.Far
        }
        return BeaconState.Unknown
    }
}