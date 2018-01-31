//
//  EventManager.swift
//  MeetEvent-App
//
//  Created by Matthew Harrilal on 1/26/18.
//  Copyright © 2018 Yveslym. All rights reserved.
//

import Foundation

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
            
            let dg = DispatchGroup()
            
            do{
                let eventbrites = try response.map(to: [Eventbrite].self, keyPath: "events")
                
                var event = [Eventbrite]()
                // get the event logo url
                eventbrites.forEach{
                    dg.enter()
                    event.append($0)
                    self.eventbriteLogo(logoID: Int($0.logoID), completionHandler: { (link) in
                        event.last?.logoUrl = link
                        dg.leave()
                    })
                    dg.notify(queue: .global(), execute: {
                        completionHandler(event)
                    })
                }
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
        
        let dg = DispatchGroup()
        self.searchEventbrite(categoryID: categoryID, subCategoryID: subCategoryID, distance: distance, location: location) { (events) in
            
            var eventbrite = [Eventbrite]()
            events?.forEach{
                
                dg.enter()
                eventbrite.append($0)
                self.searchEventbriteVenue(venueID: Int($0.venueID), completionHandle: { (venue) in
                    if venue != nil{
                        eventbrite.last?.venue = venue
                    }
                    dg.leave()
                })
                dg.notify(queue: .global(), execute: {
                    completionHandler(eventbrite)
                })
            }
            
        }
        
    }
}







