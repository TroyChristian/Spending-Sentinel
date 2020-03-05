//
//  currentMonthViewController.swift
//  SpendingSentinel
//
//  Created by Lambda_School_Loaner_219 on 3/4/20.
//  Copyright © 2020 Lambda_School_Loaner_219. All rights reserved.
//

import UIKit
import CoreData

class currentMonthViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        EntryController.shared.entries.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard   let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath) as? CurrentMonthTableViewCell else {return UITableViewCell()}

        // Configure the cell...
        
        cell.categoryLabel.text =   EntryController.shared.entries[indexPath.row].category
        //cell.amountLabel.text = EntryController.shared.entries[indexPath.row].amountSpent
        return cell
    }

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        EntryController.shared.getAllCategories()

        // Do any additional setup after loading the view.
    }
    

  

}
