//
//  CategoryViewController.swift
//  SpendingSentinel
//
//  Created by Lambda_School_Loaner_219 on 3/3/20.
//  Copyright © 2020 Lambda_School_Loaner_219. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
  
    
    var chosenCategories = [String]()
    var knownAmountofFirstPurchase:Double?
    
    @IBOutlet weak var newCategoryTextField: UITextField!
    
  
    @IBOutlet weak var collectionView: CategoryCollectionView!
    
    @IBOutlet weak var purchaseTextField: UITextField!
    
    @IBAction func enterPurchaseButton(_ sender: Any) {
        enterPurchase()
    }
    
    
    @IBAction func addCategory(_ sender: Any) {
        addCategory()
    }
    
    
    //temp entry controller for testing
    var entryController = EntryController.shared

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
     
    

    }
    func enterPurchase() {
        guard let purchase = (purchaseTextField.text) else { return }
        guard let doublePurchase = Double(purchase) else {return}
       
            entryController.createEntry(amountSpent: doublePurchase, category: chosenCategories[0], date: Date(), note: nil)
            print("new entry created")
        
  
    }
    
    func addCategory(){
        guard let newCategory = newCategoryTextField.text else {return}
        EntryController.shared.categories.append(newCategory)
        // save categories
       EntryController.shared.saveToPersistentStore()
        collectionView.reloadData()
        
    }
    
//    func addCategory() {
//                let alert = UIAlertController(title: "Enter New Category", message: "What is your Categorys Name?", preferredStyle: .alert)
//         alert.addAction(UIAlertAction(title:"Cancel", style: .cancel, handler: nil))
//                alert.addTextField { (textField) in
//                    textField.placeholder = "Add new category"
//
//                    let newCategory = (alert.textFields?.first?.text) ?? "BlankEntry"
//                                    self.categories.append(newCategory)
//                                    print("Added new category: \(newCategory)")
//
//                }
//
//
//
//
//
//
//
//                self.present(alert, animated: true, completion:nil)
//
//
//
//
//            }
//
        
        
  
    

//    func multipleCategories ()   {
//        let alert = UIAlertController(title: "Multiple Categories Selected: How much did you spend on \(chosenCategories[0])", message: "How much did you spend on your first selected category", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title:"Cancel", style: .cancel, handler: nil))
//
//        alert.addTextField { (textField) in
//            textField.placeholder = "\(self.chosenCategories[0])"
//
//        }
//
//        alert.addAction(UIAlertAction(title: "Enter Amount", style: .default, handler: { (action) in
//
//            if let amount = (alert.textFields?.first?.text) {
//                guard let doubleAmount = Double(amount) else {return}
//                self.knownAmountofFirstPurchase = doubleAmount
//            } else { print("Returning on line 75"); return}
//        }))
//        self.present(alert, animated: true, completion:nil)
//        print("Inside MultipleCategories knownAmounofFirstPurchase: \(knownAmountofFirstPurchase)")
//
//    }
//
//
//    func multipleCategoriesPartTwo(){
//        print("Inside MultipleCategoriesPartTwo knownAmounofFirstPurchase: \(knownAmountofFirstPurchase)")
//        entryController.createEntry(amountSpent: knownAmountofFirstPurchase ?? 2.22, category: chosenCategories[0], date: Date(), note: nil)
//
//        guard let purchase = (purchaseTextField.text) else { return }
//        guard let doublePurchase = Double(purchase) else {return}
//
//        let totalForSecondCategory =   divideTotalOfTwoCategories(total: doublePurchase, knownAmountOfOneCategory: knownAmountofFirstPurchase ?? 2.22)
//
//        entryController.createEntry(amountSpent: totalForSecondCategory, category: chosenCategories[1], date: Date(), note: nil)
//    }
//
//
//
//
//
//
//    func divideTotalOfTwoCategories(total:Double, knownAmountOfOneCategory:Double) -> Double {
//        let amountOfSecondCategory = total - knownAmountOfOneCategory
//        return amountOfSecondCategory
//
//
//
//
//
//
//    }
//
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return EntryController.shared.categories.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCollectionViewCell
        cell.categoryLabel.text = EntryController.shared.categories[indexPath.row]
        return cell 
        
    }
   
        
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //add to  a list of selected cells here to create more than 1 cat if cell is > 1
        
        collectionView.allowsMultipleSelection = true
        if chosenCategories.count < 1 {
            let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell
            cell?.layer.borderWidth = 2.0
            cell?.layer.borderColor = UIColor.gray.cgColor
            cell?.isSelected = true
            chosenCategories.append((cell?.categoryLabel.text)!)
            print("I'm chosenCategories: \(chosenCategories)")
            
            
        }
        
        return
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell
        cell?.layer.borderColor = UIColor.white.cgColor
        cell?.isSelected = false
        chosenCategories = chosenCategories.filter{$0 != ((cell?.categoryLabel.text)!)}
        print("I'm chosenCategories: \(chosenCategories)")
         


    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
