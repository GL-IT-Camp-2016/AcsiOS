//
//  File.swift
//  ACS
//
//  Created by Roman Hauptvogel on 29/04/16.
//  Copyright © 2016 GLACS. All rights reserved.
//

import Foundation

enum PositionState :String{
    case NoBean = "NoBean"
    case OnlyA = "OnlyA"
    case NearAFarB = "NearAFarB"
    case FarANearB = "FarANearB"
    case OnlyB = "OnlyB"
    case BothFar = "BothFar"
    case BothNear = "BothNear"
}

enum BeaconState {
    case Near
    case Far
    case Unknown
}