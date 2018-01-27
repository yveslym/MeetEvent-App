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
      case meetupCategories(sign: String, page: Int, key: Int)
      case meetupEvents(key:Int, sign: String, page: Int, topic: String)
}
extension Events: TargetType {
    var baseURL: URL {
        var baseURL = URL(string: "https://api.meetup.com")
        return baseURL!
    }
    
    var path: String {
        switch self {
        case .meetupCategories:
             return "/2/categories"
        case .meetupEvents:
            return "/2/open_events"
        }
    
    }
    
    var method: Moya.Method {
        switch self {
        case .meetupCategories:
            return .get
        case .meetupEvents:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .meetupCategories: fallthrough
        case .meetupEvents: return "{}".data(using: String.Encoding.utf8)!
            
        }
    }
    
    var task: Task {
        switch self{
            
        case .meetupCategories(let sign, let page, let key):
            return .requestParameters(parameters: ["sign": sign, "page": page, "key": key], encoding: URLEncoding.default)
        case .meetupEvents(let key, let group_urlname, let sign, let topic):
            return .requestParameters(parameters: ["key": key, "group_urlname": group_urlname, "sign": sign, "topic": topic], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self{
        case .meetupCategories: fallthrough
        case .meetupEvents: return [:]
        }
    }
    
    
}
