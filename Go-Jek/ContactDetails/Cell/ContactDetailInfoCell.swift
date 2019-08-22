//
//  ContactDetailInfoCell.swift
//  Go-Jek
//
//  Created by Satendra Singh on 21/08/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//

import UIKit

class ContactDetailInfoCell: UITableViewCell {
    
    @IBOutlet weak var lblInfoDetails: UILabel!
    @IBOutlet weak var lblInfoType: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func assignValue(infoType: String, infoDetails: String) {
        self.lblInfoType.text = infoType
        self.lblInfoDetails.text = infoDetails
    }
}
