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
    init() {
        loadFromPersistentStore()
    }
    
    static var shared = EntryController()
    var entries = [Entry]()
    var categories = [String]()
    
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
    
    func delete(entry: Entry) {
        
        CoreDataStack.shared.mainContext.delete(entry)
         let context = CoreDataStack.shared.container.newBackgroundContext()
       do {
                 try CoreDataStack.shared.save(context:context)
                 print("CoreData entry saved!")
             } catch {
                 print("CoreDataObject was not saved, EntryController line 19: createEntry, error: \(error)")
             }
    }
    
    func getAllCategories(completion: @escaping() -> Void = {}) {
        let fetchRequest:NSFetchRequest<Entry> = Entry.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "category", ascending: true)]
        let moc = CoreDataStack.shared.mainContext
        let frc = NSFetchedResultsController(fetchRequest:fetchRequest, managedObjectContext:moc, sectionNameKeyPath: "priority", cacheName:nil)  
        try! frc.performFetch()
        // is there a way to grab and manipulate the results of this fetch to populate a tableView ^^
        
        
        
        
    }
    
    private var categoryListURL: URL? {
          let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
          
          let fileName = "categoriesList.plist"
          
          return documentDirectory?.appendingPathComponent(fileName)
      }
      
      private func saveToPersistentStore() {
          
          let plistEncoder = PropertyListEncoder()
          
          do {
              let categoryData = try plistEncoder.encode(categories)
              
              guard let fileURL = categoryListURL else { return }
              
              try categoryData.write(to: fileURL)
          } catch {
              NSLog("Error encoding memories to property list: \(error)")
          }
      }
      
      private func loadFromPersistentStore() {
          
          do {
              guard let fileURL = categoryListURL else { return }
              
              let categoryData = try Data(contentsOf: fileURL)
              
              let plistDecoder = PropertyListDecoder()
              
              self.categories = try plistDecoder.decode([String].self, from: categoryData)
          } catch {
              NSLog("Error decoding memories from property list: \(error)")
          }
      }
    

}

