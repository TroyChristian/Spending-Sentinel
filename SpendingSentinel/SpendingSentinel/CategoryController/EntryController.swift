//
//  CategoryController.swift
//  SpendingSentinel
//
//  Created by Lambda_School_Loaner_219 on 3/3/20.
//  Copyright © 2020 Lambda_School_Loaner_219. All rights reserved.
//

import Foundation
import CoreData

class EntryController {
    
    static var shared = EntryController()
    var entries = [Entry]()
    
    @discardableResult func createEntry(amountSpent:Double, category:String, date:Date, note:String?) -> Entry {
        let context = CoreDataStack.shared.container.newBackgroundContext()
        let entry = Entry(amountSpent:amountSpent, category:category, date:date, id:UUID())
        do {
            try CoreDataStack.shared.save(context:context)
            print("CoreData entry saved!")
        } catch {
            print("CoreDataObject was not saved, EntryController line 19: createEntry, error: \(error)")
        }
        return entry
        
    }
    
    func getAllCategories(completion: @escaping() -> Void = {}) {
        let fetchRequest:NSFetchRequest<Entry> = Entry.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "category", ascending: true)]
        let moc = CoreDataStack.shared.mainContext
        let frc = NSFetchedResultsController(fetchRequest:fetchRequest, managedObjectContext:moc, sectionNameKeyPath: "priority", cacheName:nil)  
        try! frc.performFetch()
        
        
        
        
        
    }
    

}

