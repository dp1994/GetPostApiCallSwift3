//
//  ViewController.swift
//  GetPostJsonSwift
//
//  Created by datt on 3/22/17.
//  Copyright © 2017 datt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // get
        ApiCall.sharedInstance.requestGetMethod(apiUrl: "http://xyz/../api/xyz") { (success, responseData) in
            print(responseData ?? AnyObject.self)
        }
        
        
        // Post
        let postString = "offset=0&page=0&user_id=1"
        let paramData = postString.data(using: .utf8)
        ApiCall.sharedInstance.requestPostMethod(apiUrl: "http://xyz/../api/xyz", params: paramData!) { (success, responseData) in
            print(responseData ?? AnyObject.self)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

