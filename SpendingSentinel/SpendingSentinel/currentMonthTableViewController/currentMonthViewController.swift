//
//  currentMonthViewController.swift
//  SpendingSentinel
//
//  Created by Lambda_School_Loaner_219 on 3/4/20.
//  Copyright © 2020 Lambda_School_Loaner_219. All rights reserved.
//

import UIKit
import CoreData

class currentMonthViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,  NSFetchedResultsControllerDelegate {
  
    var frc:NSFetchedResultsController<Entry>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

        loadData()
    }
    
    func loadData() {
        // set up fr
        let fetchRequest:NSFetchRequest<Entry> = Entry.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "category", ascending: true)]
        let moc = CoreDataStack.shared.mainContext
        frc = NSFetchedResultsController(fetchRequest:fetchRequest, managedObjectContext:moc, sectionNameKeyPath: nil, cacheName:nil)
        frc.delegate = self  // conform to delegate protocol
        try! frc.performFetch()
        
    }
    

    
    
    
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = self.frc?.sections else {
            fatalError("No sections in fetchedResultsController")
        }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          guard   let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath) as? CurrentMonthTableViewCell else {return UITableViewCell()}
        guard let entry = self.frc?.object(at: indexPath) else {
            fatalError("Attempt to configure cell without a managed object")
        }
        // Configure the cell with data from the managed object.
        cell.categoryLabel.text = entry.category
        cell.amountLabel.text = "\(entry.amountSpent)"
              return cell
        
            func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
                tableView.beginUpdates()
            }
            
            func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
               tableView.reloadData()
                tableView.endUpdates()
            }
            
            func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
                switch type {
                case .insert:
                    tableView.insertSections(IndexSet(integer: sectionIndex), with: .automatic)
                case .delete:
                    tableView.deleteSections(IndexSet(integer:sectionIndex), with: .automatic)
                default:
                    break
                }
            }
            func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
                switch type {
                case .insert:
                    guard let newIndexPath = newIndexPath else { return }
                    tableView.insertRows(at: [newIndexPath], with: .automatic)
                case .update:
                    guard let indexPath = indexPath else { return }
                              tableView.reloadRows(at: [indexPath], with: .automatic)
                case .move:
                    guard let oldIndexPath = indexPath,
                    let newIndexPath = newIndexPath else { return }
                    tableView.deleteRows(at: [oldIndexPath], with: .automatic)
                              tableView.insertRows(at: [newIndexPath], with: .automatic)
                case .delete:
                    guard let indexPath = indexPath else { return }
                                       tableView.deleteRows(at: [indexPath], with: .automatic)
                @unknown default:
                    fatalError()
                }
            }
        }
    }







        
    

    
    



  


