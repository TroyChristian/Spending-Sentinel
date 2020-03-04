//
//  CategoryViewController.swift
//  SpendingSentinel
//
//  Created by Lambda_School_Loaner_219 on 3/3/20.
//  Copyright © 2020 Lambda_School_Loaner_219. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    private var categories = ["Gas","Food"]
   

   
    
    //temp entry controller for testing
    var testEntry = EntryController()

    
    
    
    
    
    
    
    
    
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
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 2.0
        cell?.layer.borderColor = UIColor.gray.cgColor
        cell?.isSelected = true
       
        
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.white.cgColor
        cell?.isSelected = false
         


    }

    override func viewDidLoad() {
        super.viewDidLoad()
      
    

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
