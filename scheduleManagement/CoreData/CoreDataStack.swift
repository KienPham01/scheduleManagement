//
//  CoreDataStack.swift
//  scheduleManagement
//
//  Created by Kien on 2/2/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import Foundation
import CoreData
class CoreDataStack {
    
    var container:NSPersistentContainer{
        let container = NSPersistentContainer(name: "Todo")
        container.loadPersistentStores{(description,error) in
            guard error == nil else{
                print("Error:\(error)")
                return
            }
        }
        return container
    }
    
    var managedContext:NSManagedObjectContext{
        return container.viewContext
    }
    
        
    
}
