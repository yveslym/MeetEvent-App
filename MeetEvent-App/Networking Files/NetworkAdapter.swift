//
//  NetworkAdapter.swift
//  MeetEvent-App
//
//  Created by Matthew Harrilal on 1/26/18.
//  Copyright © 2018 Yveslym. All rights reserved.
//

import Foundation
import UIKit
import Moya

struct NetworkAdapter{
    static let provider = MoyaProvider<Events>()
    
    static func request (target: Events, success successCallBack: @escaping(Response) -> Void, error errorCallBack: @escaping(Swift.Error)-> Void, failure falilureCallBack: @escaping(MoyaError)-> Void){
        provider.request(target){(result) in
            switch result{
                
            case .success(let response):
                if response.statusCode >= 200 && response.statusCode <= 300{
                    return successCallBack(response)
                }
                else{
                    //fatalError("code error not api")
                    let resp = String(data: response.data, encoding: .utf8)
                    print(resp)
                }
            case .failure(let error):
                errorCallBack(error)
            }
        }
    }
}

