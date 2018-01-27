//
//  CoreDataStack.swift
//  MeetEvent-App
//
//  Created by Matthew Harrilal on 1/26/18.
//  Copyright © 2018 Yveslym. All rights reserved.
//

import Foundation
import UIKit
import CoreData

public class CoreDataStack {
    static let singletonInstance = CoreDataStack()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MeetEvent")
        container.loadPersistentStores(completionHandler: { (completionHandler, error) in
            if let error = error as NSError? {
                fatalError("Unresolved Error \(error), \(error.localizedDescription)")
            }
        })
        return container
    }()
    
    lazy var viewContext: NSManagedObjectContext = {
        let viewContext = persistentContainer.viewContext
        // Linking the view contexts persistent store to the official persistent store coordinator
        viewContext.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        return viewContext
    }()
    
    lazy var privateContext: NSManagedObjectContext = {
        let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        
        // Linking the private contexts persistent store coordinator to the official persistent store coordinators
        privateContext.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        return privateContext
    }()
    
    func saveTo(context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                print("The changes were made to the saved to the context")
                try context.save()
            }
            catch {
                let error = error as NSError?
                fatalError("Could not save changes \(error?.localizedDescription), \(error)")
            }
        }
    }
}
