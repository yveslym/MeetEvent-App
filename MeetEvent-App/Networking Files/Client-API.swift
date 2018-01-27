//
//  Client-API.swift
//  MeetEvent-App
//
//  Created by Matthew Harrilal on 1/26/18.
//  Copyright © 2018 Yveslym. All rights reserved.
//

import Foundation
import UIKit
import Moya

enum Events {
//    case events
//    case location(id: Int)
//    case likes(id:Int)
    case categories(sign: String, page: Int, key: Int)
}
extension Events: TargetType {
    var baseURL: URL {
        var baseURL = URL(string: "https://api.meetup.com")
        return baseURL!
    }
    
    var path: String {
        switch self {
        case .categories:
             return "/2/categories"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .categories:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        
        case .categories: return "{}".data(using: String.Encoding.utf8)!
        }
    }
    
    var task: Task {
        switch self{
            
        
        case .categories(let sign, let page, let key):
            return .requestParameters(parameters: ["sign": sign, "page": page, "key": key], encoding: URLEncoding.default)

        }
    }
    
    var headers: [String : String]? {
        switch self{
            
        case .categories(let sign, let page, let key):
            return [:]
        }
    }
    
    
}
