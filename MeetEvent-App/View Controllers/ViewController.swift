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
//        networking.network(route: .categories) { (data) in
//            let json = try? JSONDecoder().decode(Results.self, from: data)
//            print(json)
//        }
//        NetworkAdapter.request(target: .meetupCategories(sign: "true", page: 20, key: "7b62795586e521d7e13471747275e10"), success: { (response) in
//            print(String(data: response.data, encoding: .utf8))
//        }, error: { (error) in
//            print(error)
//        }) { (MoyaError) in
//            print(MoyaError)
//        }
        let manager = EventManager()
        manager.fetchMeetupGroup(page: 20) { (meetupGroups) in
            print(meetupGroups)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

