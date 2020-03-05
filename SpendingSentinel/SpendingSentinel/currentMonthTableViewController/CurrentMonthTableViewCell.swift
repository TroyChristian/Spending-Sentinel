//
//  CurrentMonthTableViewCell.swift
//  SpendingSentinel
//
//  Created by Lambda_School_Loaner_219 on 3/4/20.
//  Copyright © 2020 Lambda_School_Loaner_219. All rights reserved.
//

import UIKit

class CurrentMonthTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    
    
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
