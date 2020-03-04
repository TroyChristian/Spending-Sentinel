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
    

}
/*
 do {
     try igniteRockets(fuel: 5000, astronauts: 1)
 } catch {
     print(error)
 }
 */
