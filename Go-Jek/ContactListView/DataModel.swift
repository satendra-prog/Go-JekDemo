//
//  DataModel.swift
//  Go-Jek
//
//  Created by Satendra Singh on 20/08/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//


import UIKit

struct DataModel: Codable {
    var id: Int
    var firstName: String
    var lastName: String
    var profilePic: String
    var favorite: Bool
    var url: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case profilePic = "profile_pic"
        case favorite = "favorite"
        case url = "url"
    }
}

