//
//  AddOrEditContactCell.swift
//  Go-Jek
//
//  Created by Satendra Singh on 22/08/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//

import UIKit

protocol TextChangedDelegate: class {
        func textChanged(type: DataRowMapping, newText: String)
    }
    
    class AddOrEditContactCell: UITableViewCell {
        
        @IBOutlet weak var txtFieldData: UITextField!
        @IBOutlet weak var lblType: UILabel!
        weak var delegate: TextChangedDelegate?
        
        var infoType: DataRowMapping = .firstName
        
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }
        
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
            
            // Configure the view for the selected state
        }
        
        func assignValue(infoType: String, placeholder: String, value: String, infoTypeEnum: DataRowMapping, delegate: TextChangedDelegate) {
            self.delegate = delegate
            self.infoType = infoTypeEnum
            self.txtFieldData.delegate = self
            self.lblType.text = infoType
            self.txtFieldData.text = value
            self.txtFieldData.placeholder = placeholder
        }
    }
    
    extension AddOrEditContactCell: UITextFieldDelegate {
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let text = textField.text, let textRange = Range(range, in: text), let newText = textField.text?.replacingCharacters(in: textRange, with: string) {
                self.delegate?.textChanged(type: self.infoType, newText: newText)
            }
            return true
        }
}

