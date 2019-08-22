//
//  ContactDetailResponseDataModel.swift
//  Go-Jek
//
//  Created by Satendra Singh on 21/08/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//

import UIKit

struct ContactDetailResponseDataModel: Codable {
    var id: Int
    var firstName: String?
    var lastName: String?
    var profilePic: String
    var favorite: Bool
    var phoneNumber: String?
    var email: String?
    var createdAt: String
    var updatedAt: String
    
    init(id: Int, firstName: String, lastName: String, profilePic: String, favorite: Bool, phoneNumber: String, email: String, createdAt: String, updatedAt: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.profilePic = profilePic
        self.favorite = favorite
        self.phoneNumber = phoneNumber
        self.email = email
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case profilePic = "profile_pic"
        case phoneNumber = "phone_number"
        case favorite
        case email
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    func hasUserValueChanged(firstName: String, lastName: String, email: String, phoneNumber: String) -> Bool {
        if self.firstName != firstName || self.lastName != lastName || self.phoneNumber != phoneNumber || self.email != email {
            return true
        }
        return false
    }
}
