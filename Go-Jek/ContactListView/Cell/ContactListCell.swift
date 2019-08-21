//
//  ContactListCell.swift
//  Go-Jek
//
//  Created by Satendra Singh on 20/08/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//

import UIKit
import SDWebImage


class ContactListCell: UITableViewCell {

    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var imgFavouriteStar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imgProfilePic.layer.masksToBounds = false
        self.imgProfilePic.layer.cornerRadius = self.imgProfilePic.frame.size.width / 2
        self.imgProfilePic.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func assignValues(model: ContactsList.FetchContacts.ViewModel.ContactListViewModel) {
        self.lblName.text = model.name
        let image = model.isFavourite == true ? UIImage.init(named: "home_favourite") : nil
        self.imgFavouriteStar.image = image
        let url = URL.init(string: model.imageUrl)
        self.imgProfilePic.sd_setImage(with: url, placeholderImage: UIImage.init(named: "placeholder_photo"))
    }
}
