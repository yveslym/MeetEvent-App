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
    case meetupCategories( page: Int, key: String)
    case meetupEvents(key: String, page: Int, topic: String)
    case searchEventbrite(categoryID: Int,subCategoryID: Int, location: String, distance: String)
    case eventbriteVenue(venueID: Int)
    case eventbriteLogo(logoID: Int)
    case eventbriteCategories
    case eventbriteSubCategories(categoryID: Int)
    
}
extension Events: TargetType {
    
    var task: Task {
        
        switch self{
            
        case .meetupCategories( let page, let key):
            return .requestParameters(parameters: ["sign": "true", "page": page, "key": key], encoding: URLEncoding.default)
            
        case .meetupEvents(_, let key, let topic):
            return .requestParameters(parameters: ["key": key, "topic": topic], encoding: URLEncoding.default)
            
        case .searchEventbrite(let categoryID, let subCategoryID, let location, let distance):
            return .requestParameters(parameters: ["location.address": location, "token": EventConfig.eventBriteKey!, "categories": categoryID, "subcategories": subCategoryID, "location.within": distance], encoding: URLEncoding.default)
            
        case .eventbriteVenue:
            return .requestParameters(parameters: ["token": EventConfig.eventBriteKey!], encoding: URLEncoding.default)
            
        case .eventbriteLogo:
            return .requestParameters(parameters: ["token": EventConfig.eventBriteKey!], encoding: URLEncoding.default)
            
        case .eventbriteCategories:
            return .requestParameters(parameters: ["token": EventConfig.eventBriteKey!], encoding: URLEncoding.default)
            
        case .eventbriteSubCategories:
            return .requestParameters(parameters: ["token": EventConfig.eventBriteKey!], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self{
            
        case .searchEventbrite: return ["Content-Type" : "application/json"]
            
        case .meetupCategories, .meetupEvents, .eventbriteVenue, .eventbriteLogo, .eventbriteCategories,  .eventbriteSubCategories: return [:]
            
        }
    }
    
    
    var baseURL: URL {
        switch self{
        case .meetupCategories, .meetupEvents: return URL(string: "https://api.meetup.com")!
            
        case .searchEventbrite, .eventbriteVenue, .eventbriteLogo, .eventbriteCategories,  .eventbriteSubCategories :
            return URL(string: "https://www.eventbriteapi.com")!
        }
    }
    
    var path: String {
        switch self {
        case .meetupCategories: return "/2/categories"
            
        case .meetupEvents: return "/2/open_events"
            
        case .searchEventbrite:  return "/v3/events/search/"
            
        case .eventbriteVenue(let venueID):  return "/v3/venues/\(venueID)/"
            
        case .eventbriteLogo(let logoID): return "/v3/media/\(logoID)/"
            
        case .eventbriteCategories:  return "/v3/categories/"
            
        case .eventbriteSubCategories(let categoryID): return "/v3/categories/\(categoryID)/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .meetupCategories, .meetupEvents, .searchEventbrite, .eventbriteVenue, .eventbriteLogo, .eventbriteCategories, .eventbriteSubCategories:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
            
        case .meetupCategories, .searchEventbrite, .eventbriteVenue,
             .eventbriteLogo, .eventbriteCategories, .eventbriteSubCategories, .meetupEvents:
            
            return "{}".data(using: String.Encoding.utf8)!
        }
    }
}
