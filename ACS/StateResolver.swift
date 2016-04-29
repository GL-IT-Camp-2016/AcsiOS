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
    
    var beaconStateA:BLUDistance!
    var beaconStateB:BLUDistance!

    func getNewState(beacon: BLUSBeacon) -> PositionState{
        changeBeaconState(beacon)
        
        if beaconStateA == BLUDistance.Far && beaconStateB == BLUDistance.Near {
            return PositionState.FarANearB
        } else if beaconStateB == BLUDistance.Far && beaconStateA == BLUDistance.Near{
            return PositionState.NearAFarB
        } else if beaconStateB == BLUDistance.Far && beaconStateA == BLUDistance.Far{
            return PositionState.BothFar
        } else if beaconStateB == BLUDistance.Near && beaconStateA == BLUDistance.Near{
            return PositionState.BothNear
        } else if beaconStateB == BLUDistance.Unknown && beaconStateA != BLUDistance.Unknown{
            return PositionState.OnlyA
        } else if beaconStateB != BLUDistance.Unknown && beaconStateA == BLUDistance.Unknown{
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
            self.beaconStateA = beacon.distance
        } else if stringId == BEACON_B {
            self.beaconStateA = beacon.distance
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
}