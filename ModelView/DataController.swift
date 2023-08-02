//
//  DataController.swift
//  FriendFace
//
//  Created by Олексій Якимчук on 02.08.2023.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    static let instance = DataController()
    let container = NSPersistentContainer(name: "FriendFace")
    let context: NSManagedObjectContext
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("CoreData failed to load: \(error.localizedDescription)")
            }  
        }
        
        context = container.viewContext
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving. \(error.localizedDescription)")
        }
    }
}
