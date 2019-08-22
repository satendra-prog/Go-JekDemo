//
//  AddOrEditContactModel.swift
//  Go-Jek
//
//  Created by Satendra Singh on 22/08/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//

import UIKit

enum ResultType {
    case validationFailure
    case success
    case noNewData
    case responseFailure
}

enum AddOrEdit {
    case add
    case edit
}

enum DataRowMapping: Int {
    case firstName = 0
    case lastName = 1
    case mobile = 2
    case email = 3
    
    static func giveEnumType(index: Int) -> DataRowMapping? {
        return DataRowMapping.init(rawValue: index)
    }
}

enum AddOrEditContact {
    // MARK: Use cases
    
    enum Something {
        struct Request {
        }
        struct Response {
        }
        struct ViewModel {
        }
    }
    
    enum GetContactData {
        struct Request {
        }
        struct Response {
            var selectedContact: ContactDetailResponseDataModel?
        }
        struct ViewModel {
            struct ContactData {
                var firstName: String
                var lastName: String
                var email: String
                var phoneNumber: String
                var imageUrl: String
                
                func returnProperDataType(index: DataRowMapping) -> String {
                    switch index {
                    case .firstName:
                        return Constants.firstNameLabelText
                    case .lastName:
                        return Constants.lastNameLabelText
                    case .mobile:
                        return Constants.phoneNameLabelText
                    case .email:
                        return Constants.emailNameLabelText
                    }
                }
                
                func returnProperPlaceholderType(index: DataRowMapping) -> String {
                    switch index {
                    case .firstName:
                        return Constants.firstNamePlaceholder
                    case .lastName:
                        return Constants.lastNamePlaceholder
                    case .mobile:
                        return Constants.phoneNamePlaceholder
                    case .email:
                        return Constants.emailNamePlaceholder
                    }
                }
                
                func returnProperValue(index: DataRowMapping) -> String {
                    switch index {
                    case .firstName:
                        return self.firstName
                    case .lastName:
                        return self.lastName
                    case .mobile:
                        return self.phoneNumber
                    case .email:
                        return self.email
                    }
                }
            }
            var selectedContact: ContactData?
        }
    }
    
    enum SendChangedData {
        struct Request {
            var firstName: String
            var lastName: String
            var email: String
            var phoneNumber: String
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
