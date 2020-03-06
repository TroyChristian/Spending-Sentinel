//
//  CategoryViewController.swift
//  SpendingSentinel
//
//  Created by Lambda_School_Loaner_219 on 3/3/20.
//  Copyright © 2020 Lambda_School_Loaner_219. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    private var categories = ["Gas","Food", "Medicine"]
    var chosenCategories = [String]()
   
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
        if  chosenCategories.count == 1 {
            entryController.createEntry(amountSpent: doublePurchase, category: chosenCategories[0], date: Date(), note: nil)
            print("new entry created")
        }
        else { return }



    }
    
    func addCategory() {
        
    }
    

//    func multipleCategories() {
//        let alert = UIAlertController(title: "Multiple Categories Selected", message: "How much did you spend on your chos", preferredStyle: <#T##UIAlertController.Style#>)
//    }
    
    
    
    func divideTotalOfTwoCategories(total:Double, knownAmountOfOneCategory:Double) -> Double {
        var amountOfSecondCategory = total - knownAmountOfOneCategory
        return amountOfSecondCategory
       
        
        
        
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCollectionViewCell
        cell.categoryLabel.text = categories[indexPath.row]
        return cell 
        
    }
   
        
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //add to  a list of selected cells here to create more than 1 cat if cell is > 1
        
        collectionView.allowsMultipleSelection = true
        if chosenCategories.count < 2 {
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
