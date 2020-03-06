//
//  CategoryController.swift
//  SpendingSentinel
//
//  Created by Lambda_School_Loaner_219 on 3/3/20.
//  Copyright © 2020 Lambda_School_Loaner_219. All rights reserved.
//

import Foundation
import CoreData
// Set Userdefault to check if this is the first time the user is running the app.
// Implement logic to handle if load file does not exist.


class EntryController {
    init() {
        loadFromPersistentStore()
        
    }
    //categories
    
    static var shared = EntryController()
    var entries = [Entry]()
    
    var categories = ["Gas","Food"]
    
    @discardableResult func createEntry(amountSpent:Double, category:String, date:Date, note:String?) -> Entry {
        let context = CoreDataStack.shared.mainContext
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
    private var initialCategoryList:URL? {
        
        Bundle.main.url(forResource: "categoriesList", withExtension: "plist")
        
    }
    
    private var categoryListURL: URL? {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        
        
        
        
        let fileName = "categoriesList.plist"
        
        return documentDirectory?.appendingPathComponent(fileName)
    }
    
     func saveToPersistentStore() {
        
        let plistEncoder = PropertyListEncoder()
        
        do {
            let categoryData = try plistEncoder.encode(categories)
            
            guard let fileURL = categoryListURL else { return }
            print("For saving URL: \(fileURL)")
            
            
            try categoryData.write(to: fileURL)
        } catch {
            NSLog("Error encoding memories to property list: \(error)")
        }
    }
    
    private func loadFromPersistentStore() {
        
        
        guard let fileURL = categoryListURL else { return }
        print("For loading URL: \(fileURL)")
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                let categoryData = try Data(contentsOf: fileURL)
                
                let plistDecoder = PropertyListDecoder()
                
                self.categories = try plistDecoder.decode([String].self, from: categoryData)
                print("loaded stored categories:\(categories)")
            } catch {
                NSLog("Error decoding memories from property list: \(error)")
            }
            
            
        } else {
            // this is the first time the user is using the app,  loading default categories
            guard let initialCategoryList =  initialCategoryList else {return}
                do {
                    let categoryData = try Data(contentsOf: initialCategoryList)
                    
                    let plistDecoder = PropertyListDecoder()
                    
                    self.categories = try plistDecoder.decode([String].self, from: categoryData)
                    print("initial categories:\(categories)")
                } catch {
                    NSLog("Error decoding memories from property list: \(error)")
                }
                
                
            }
        }
        
        
    }
    
    


