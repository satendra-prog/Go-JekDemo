//
//  ContactDetailsModel.swift
//  Go-Jek
//
//  Created by Satendra Singh on 21/08/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//

import UIKit

enum ContactDetails {
    
    // MARK: Use cases
    
    enum FetchContactDetails {
        struct Request {
        }
        struct Response {
            var contactDetails: ContactDetailResponseDataModel?
            var error: Constants.CustomError?
        }
        struct ViewModel {
            struct ContactDetailsViewModel {
                var name: String
                var imageUrl: String
                var isFavorite: Bool
                var phoneNo: String
                var email: String
            }
            var contactDetails: ContactDetailsViewModel?
            var errorMessage: String?
        }
    }
    
    enum FavouriteToggled {
        enum ResultType {
            case success
            case failure
        }
        
        struct Request {
            var favoriteState: Bool
        }
        struct Response {
            var resultType: ResultType
            var message: String
        }
        struct ViewModel {
            var resultType: ResultType
            var message: String
        }
    }
    
    enum DeleteToggled {
        enum ResultType {
            case success
            case failure
        }
        
        struct Request {
        }
        struct Response {
            var resultType: ResultType
            var message: String
        }
        struct ViewModel {
            var resultType: ResultType
            var message: String
        }
    }
}
