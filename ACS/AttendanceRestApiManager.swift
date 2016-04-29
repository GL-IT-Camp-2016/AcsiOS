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

    func postArrival(uri: String,  username: String){
        let timestampNow = NSDate().timeIntervalSince1970
        let params = ["person_name":username, "timestamp":"\(Int(timestampNow))"] as Dictionary<String, String>
        self.restApiManager.makeHTTPPostRequest(uri, body: params)
    }

    func postDeparture(uri: String, name: String){

    }
}