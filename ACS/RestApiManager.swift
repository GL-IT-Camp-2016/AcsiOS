//
//  RestApiManager.swift
//  ACS
//
//  Created by Karol Sladecek on 29/04/16.
//  Copyright © 2016 GLACS. All rights reserved.
//

import Foundation

typealias JSON = [String:AnyObject]
typealias ServiceResponse = (JSON, NSError?) -> Void

class RestApiManager: NSObject {
    static let sharedInstance = RestApiManager()

    func makeHTTPGetRequest(path: String) {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)

        let session = NSURLSession.sharedSession()

        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            print(data)
            guard let json = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) else {
                return
            }

            if let result:AnyObject = json["result"] {

                let persons = result["persons"]
            }
            let xxx = json["persons"] ?? "asda"
            // json.po
            // let json:JSON = JSON(data: data)
            // onCompletion(json, error)
        })
        task.resume()
    }

    func makeHTTPPostRequest(uri: String, body: Dictionary<String, String>) {
        let session = NSURLSession.sharedSession()

        if let url = NSURL(string: uri) {
            let request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"


            let kvp = body.map { $0.0 + "=" + $0.1 }
            let postString = kvp.joinWithSeparator("&")

            let data = postString.dataUsingEncoding(NSUTF8StringEncoding)

            request.HTTPBody =  data //try? NSJSONSerialization.dataWithJSONObject(body, options: NSJSONWritingOptions())

            let task = session.dataTaskWithRequest(request, completionHandler: {data1, response, error -> Void in
                let stringData = String(data: data1!, encoding: NSUTF8StringEncoding)
                print(stringData)
                print(error)
            })
            task.resume()
        }
    }
}