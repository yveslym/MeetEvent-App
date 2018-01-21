//
//  ObtainMeetupCategories.swift
//  MeetEvent-App
//
//  Created by Matthew Harrilal on 1/21/18.
//  Copyright © 2018 Yveslym. All rights reserved.
//

import Foundation
import UIKit

let session = URLSession.shared

enum MeetupRoutes {
    case categories
    
    func path() -> String {
        switch self {
        case .categories:
            return "/2/categories"
        }
    }
    
    func urlParameters() -> [String: String] {
        switch self {
        case .categories:
            let categoryParameters = ["sign": "true",
                                      "photo-host": "public",
                                      "key": "6d68436679717c306328646d777e611d"]
            return categoryParameters
        }
    }
}

class CategoryNetworkingLayer {
    var baseURL = "https://api.meetup.com"
    
    func network(route: MeetupRoutes, completionHandler: @escaping (Data) -> Void) {
        var urlStringPath = URL(string: baseURL.appending(route.path()))
        var fullURLString = urlStringPath?.appendingQueryParameters(route.urlParameters())
        var getRequest = URLRequest(url: fullURLString!)
        session.dataTask(with: getRequest) { (data, response, error) in
            if let data = data {
                completionHandler(data)
            }
        }.resume()
    }
}


extension URL {
    func appendingQueryParameters(_ parametersDictionary : Dictionary<String, String>) -> URL {
        let URLString : String = String(format: "%@?%@", self.absoluteString, parametersDictionary.queryParameters)
        return URL(string: URLString)!
    }
    // This is formatting the query parameters with an ascii table reference therefore we can be returned a json file
}

protocol URLQueryParameterStringConvertible {
    var queryParameters: String {get}
}


extension Dictionary : URLQueryParameterStringConvertible {
    /**
     This computed property returns a query parameters string from the given NSDictionary. For
     example, if the input is @{@"day":@"Tuesday", @"month":@"January"}, the output
     string will be @"day=Tuesday&month=January".
     @return The computed parameters string.
     */
    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            let part = String(format: "%@=%@",
                              String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                              String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
    
}



