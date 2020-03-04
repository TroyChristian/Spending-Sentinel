//
//  Entry+Convenience.swift
//  SpendingSentinel
//
//  Created by Lambda_School_Loaner_219 on 3/4/20.
//  Copyright © 2020 Lambda_School_Loaner_219. All rights reserved.
//

import Foundation
import CoreData
extension Entry {
    @discardableResult convenience init(amountSpent:Double, category:String, date: Date, id:UUID, context: NSManagedObjectContext =  CoreDataStack.shared.mainContext) {
         
         self.init(context:context)
         
        self.amountSpent = amountSpent
        self.category = category
        self.date = date
        self.id = id
     }

    
    }
    
    
 

