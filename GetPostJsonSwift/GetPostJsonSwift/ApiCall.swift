//
//  ApiCall.swift
//  GetPostJsonSwift
//
//  Created by datt on 3/22/17.
//  Copyright © 2017 datt. All rights reserved.
//

import UIKit

class ApiCall: NSObject {
    
    static let sharedInstance : ApiCall = {
        let instance = ApiCall()
        return instance
    }()
    open func requestGetMethod(apiUrl : String , completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        var request = URLRequest(url: URL(string: apiUrl)!)
        // Set request HTTP method to GET. It could be POST as well
        request.httpMethod = "GET"//method as String
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task: URLSessionDataTask = session.dataTask(with : request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            // Check for error
            if error != nil
            {
                print("error=\(error)")
                return
            }
            // Print out response string
            //            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            //            print("responseString = \(responseString)")
            
            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] {
                    // Print out dictionary
                    print(convertedJsonIntoDict)
                    completion(true, convertedJsonIntoDict as AnyObject?)
                }
                else{
                    completion(false, nil)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        })
        
        task.resume()
    }
    open func requestPostMethod(apiUrl : String, params: Data , completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        var request = URLRequest(url: URL(string: apiUrl)!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = params
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task: URLSessionDataTask = session.dataTask(with : request as URLRequest, completionHandler: { (data, response, error) -> Void in
            guard let data = data, error == nil else {
                // check for fundamental networking error
                print("error=\(error)")
                return
            }
            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String : AnyObject] {
                    completion(true, convertedJsonIntoDict as AnyObject?)
                }
                else{
                    completion(false, nil)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
                completion(false, nil)
            }
        })
        task.resume()
    }
    
}
