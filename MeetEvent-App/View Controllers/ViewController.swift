//
//  ViewController.swift
//  MeetEvent-App
//
//  Created by Yveslym on 1/20/18.
//  Copyright © 2018 Yveslym. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let networking = CategoryNetworkingLayer()
        networking.network(route: .categories) { (data) in
            let json = try? JSONDecoder().decode(Results.self, from: data)
            print(json)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

