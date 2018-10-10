//
//  PersistenceService.swift
//  CoreDataPod
//
//  Created by Charles Fiedler on 10/10/18.
//  Copyright © 2018 MKD. All rights reserved.
//

import CoreData

let sharedTestingContext: NSManagedObjectContext = setUpInMemoryManagedObjectContext()

func setUpInMemoryManagedObjectContext() -> NSManagedObjectContext {
    let bundle = Bundle.forPodFramework(identifier: "mkdir.CoreDataPod")
    guard let modelURL = bundle.url(forResource: "Database", withExtension: "momd") else {
        debugPrint("*** Unabled to load Database.momd ***")
        fatalError()
    }
    
    let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)!
    let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
    do {
        try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
    } catch {
        print("Adding in-memory persistent store failed")
    }
    
    let managedObjectContext = NSManagedObjectContext.init(concurrencyType: .privateQueueConcurrencyType)
    managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
    
    return managedObjectContext
}


public class PersistenceService {
    
    private init() {}
    
    static public var context: NSManagedObjectContext? = {
        let coordinator = persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext.init(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    static public var managedObjectModel: NSManagedObjectModel = {
        let bundleURL = Bundle(for: CoreDataPod.self).url(forResource: "DataStore", withExtension: "bundle")
        let frameworkBundle = Bundle(url: bundleURL!)
        let momURL = frameworkBundle!.url(forResource: "Database", withExtension: "momd")
        let model = NSManagedObjectModel(contentsOf: momURL!)!
        return model
    }()
    
    static public var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        let url = applicationDocumentsDirectory.appendingPathComponent("CoreDataPod.sqlite")
        var error: NSError?
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator!.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch var error1 as NSError {
            error = error1
            coordinator = nil
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            NSLog("Unresolved error \(String(describing: error)), \(error!.userInfo)")
            abort()
        } catch {
            fatalError()
        }
        
        return coordinator
    }()
    
    static public var applicationDocumentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    static func saveContext () {
        if context != nil && context!.hasChanges {
            do {
                try context!.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
