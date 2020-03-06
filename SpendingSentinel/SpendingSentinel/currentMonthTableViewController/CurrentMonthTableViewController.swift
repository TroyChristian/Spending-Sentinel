//
//  CurrentMonthTableViewController.swift
//  SpendingSentinel
//
//  Created by Lambda_School_Loaner_219 on 3/5/20.
//  Copyright © 2020 Lambda_School_Loaner_219. All rights reserved.
//

import UIKit
import CoreData

class CurrentMonthTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {



     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         
         tableView.reloadData()
     }
     
     // MARK: - Table view data source
     
     override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         return fetchedResultsController.sections?[section].name
     }
     
     override func numberOfSections(in tableView: UITableView) -> Int {
         return fetchedResultsController.sections?.count ?? 1
     }
     
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return fetchedResultsController.sections?[section].numberOfObjects ?? 0
     }
     
     
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath) as? CurrentMonthTableViewCell else { return UITableViewCell() }
         
         let entry = fetchedResultsController.object(at: indexPath)
         
        cell.categoryLabel.text = entry.category
        cell.amountLabel.text = "\(entry.amountSpent)"
         
         return cell
     }
     
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
             
             let entry = fetchedResultsController.object(at: indexPath)

             entryController.delete(entry: entry)
         }
     }
     
     // MARK: - NSFetchedResultsControllerDelegate
     
     func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
         tableView.beginUpdates()
     }
     
     func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
         tableView.endUpdates()
     }
     
     func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                     didChange sectionInfo: NSFetchedResultsSectionInfo,
                     atSectionIndex sectionIndex: Int,
                     for type: NSFetchedResultsChangeType) {
         switch type {
         case .insert:
             tableView.insertSections(IndexSet(integer: sectionIndex), with: .automatic)
         case .delete:
             tableView.deleteSections(IndexSet(integer: sectionIndex), with: .automatic)
         default:
             break
         }
     }
     
     func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                     didChange anObject: Any,
                     at indexPath: IndexPath?,
                     for type: NSFetchedResultsChangeType,
                     newIndexPath: IndexPath?) {
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
         }
     }
     
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         

     }
     
     // MARK: - Properties
     
     let entryController = EntryController()
     
     lazy var fetchedResultsController: NSFetchedResultsController<Entry> = {
         let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
         fetchRequest.sortDescriptors = [NSSortDescriptor(key: "category", ascending: false)]
         
         let moc = CoreDataStack.shared.mainContext
         let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
         
         frc.delegate = self
         
         try! frc.performFetch()
         
         return frc
     }()
 }
