//
//  AttendanceRestApiManager.swift
//  ACS
//
//  Created by Karol Sladecek on 29/04/16.
//  Copyright © 2016 GLACS. All rights reserved.
//

import Foundation

class AttendanceRestApiManager {
    let restApiManager = RestApiManager()
    let BASE_URL:String = "http://itc16.herokuapp.com"
    let ARRIVAL_URI:String = "/attendance/store/arrival/"
    let DEPARTURE_URI:String = "/attendance/store/departure/"

    func postArrival(username: String){
        let timestampNow = NSDate().timeIntervalSince1970
        let params = ["person_name":username, "timestamp":"\(Int(timestampNow))"] as Dictionary<String, String>
        self.restApiManager.makeHTTPPostRequest(BASE_URL+ARRIVAL_URI, body: params)
    }

    func postDeparture(username: String){
        let timestampNow = NSDate().timeIntervalSince1970
        let params = ["person_name":username, "timestamp":"\(Int(timestampNow))"] as Dictionary<String, String>
        self.restApiManager.makeHTTPPostRequest(BASE_URL+DEPARTURE_URI, body: params)
    }
}