//
//  ContactDataModel.swift
//  Go-Jek
//
//  Created by Satendra Singh on 20/08/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//


import UIKit

enum ContactsList {
    
    // MARK: Use cases
    enum FetchContacts {
        struct Request {
        }
        struct Response {
            var contactsListData: [DataModel]?
            var error: Constants.CustomError?
        }
        struct ViewModel {
            struct ContactListViewModel {
                var id: Int
                var name: String
                var imageUrl: String
                var isFavourite: Bool
            }
            var dictMapping:[Int: String]?
            var dictContacts:[String: [ContactListViewModel]]?
            var errorMessage: String?
        }
    }
}

