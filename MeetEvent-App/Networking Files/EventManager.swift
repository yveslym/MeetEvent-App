//
//  EventManager.swift
//  MeetEvent-App
//
//  Created by Matthew Harrilal on 1/26/18.
//  Copyright © 2018 Yveslym. All rights reserved.
//

import Foundation
import Mapper

struct EventManager{
    
    
    
    func fetchMeetupGroup(page: Int, completionHandler: @escaping(Data) -> Void) {
        NetworkAdapter.request(target: .meetupCategories(page: 20, key: "7b62795586e521d7e13471747275e10"), success: { (response) in
            
        }, error: { (error) in
            print(error.localizedDescription)
        }) { (MoyaError) in
            print(MoyaError)
        }
    }
    
    ///function to search for eventbrite event
    private func searchEventbrite(categoryID: Int, subCategoryID: Int, distance: String,location: String, completionHandler: @escaping([Eventbrite]?)-> Void){
        
        NetworkAdapter.request(target: .searchEventbrite(categoryID: categoryID, subCategoryID: subCategoryID, location: location, distance: distance), success: { (response) in
    
            do{
                let eventbrites = try response.map(to: [Eventbrite].self, keyPath: "events")
                
                completionHandler(eventbrites)
                
            }catch{
                print("couldn't decode eventbrite events")
            }
        }, error: { (error) in
            
            print(error.localizedDescription)
            
        }) { (moyaError) in
            print(moyaError.localizedDescription)
        }
    }
    /// function to get eventbrite venue
    private func searchEventbriteVenue(venueID: Int, completionHandle:@escaping(Venue?) -> Void){
        
        NetworkAdapter.request(target: .eventbriteVenue(venueID: venueID), success: { (response) in
            do{
                let venue = try response.map(to: Venue.self)
                completionHandle(venue)
            }catch{
                completionHandle(nil)
            }
            
        }, error: { (error) in
            print(error.localizedDescription)
        }) { (error) in
            print(error.failureReason!)
        }
    }
    
    ///method to get eventbrite logo
    func eventbriteLogo(logoID: Int, completionHandler: @escaping(String?)->Void){
        
        NetworkAdapter.request(target: .eventbriteLogo(logoID: logoID), success: { (response) in
            do{
                let logoURL = try response.mapString(atKeyPath: "url")
                completionHandler(logoURL)
            }catch{
                completionHandler(nil)
            }
            
        }, error: { (error) in
            print(error.localizedDescription)
        }) { (error) in
            print(error.failureReason!)
        }
    }
    
    /// Method to return eventbrite Event
    func eventbriteEvent(categoryID: Int, subCategoryID: Int, distance: String,location: String, completionHandler: @escaping([Eventbrite]?)-> Void){
        
        //let dg = DispatchGroup()
        self.searchEventbrite(categoryID: categoryID, subCategoryID: subCategoryID, distance: distance, location: location) { (events) in
            
            completionHandler(events)
//            var eventbrite = [Eventbrite]()
//            events?.forEach{
//
//                dg.enter()
//                eventbrite.append($0)
//                if $0.venueID != nil{
//                self.searchEventbriteVenue(venueID: Int($0.venueID!)!, completionHandle: { (venue) in
//                    if venue != nil{
//                        eventbrite.last?.venue = venue
//                    }
//                    dg.leave()
//                })
//            }
//                dg.notify(queue: .global(), execute: {
//                    completionHandler(eventbrite)
//                })
//            }
            
        }
        
    }
}
struct EventResults: Mappable{
    init(map: Mapper) throws {
        events = map.optionalFrom("events")!
    }
    
    var events = [Eventbrite]()
}






