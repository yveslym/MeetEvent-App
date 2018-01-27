//
//  EventManager.swift
//  MeetEvent-App
//
//  Created by Matthew Harrilal on 1/26/18.
//  Copyright © 2018 Yveslym. All rights reserved.
//

import Foundation

struct EventManager{
    
//    func meetGroup(pasge: Int, completionHandle:@escaping(String)-> Void){
//
//        NetworkAdapter.request(target: .meetupCategories(sign: "true", page: 20, key: "7b62795586e521d7e13471747275e10"), success: { (response) in
//            print(String(data: response.data, encoding: .utf8))
//
//            /// do the decoding
//        }, error: { (error) in
//            print(error)
//        }) { (MoyaError) in
//            print(MoyaError)
//        }
//    }
    
    func fetchMeetupGroup(page: Int, completionHandler: @escaping(Data) -> Void) {
        NetworkAdapter.request(target: .meetupCategories(page: 20, key: "7b62795586e521d7e13471747275e10"), success: { (response) in
            print(String(data: response.data, encoding: .utf8))
        }, error: { (error) in
            print(error.localizedDescription)
        }) { (MoyaError) in
            print(MoyaError)
        }
    }
}
