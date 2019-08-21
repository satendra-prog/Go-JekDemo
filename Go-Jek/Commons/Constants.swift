//
//  Loader.swift
//  Go-Jek
//
//  Created by Satendra Singh on 20/08/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//


import UIKit

struct Constants {
    static let getAllContactsUrlString = "https://gojek-contacts-app.herokuapp.com/contacts.json"
    static let postContactsUrlString = "https://gojek-contacts-app.herokuapp.com/contacts.json"
    static let putContactsUrlString = "https://gojek-contacts-app.herokuapp.com/contacts"
    
    enum CustomError: String, Error {
        case unknownError = "Unknown Error"
    }
    
    static let lightGreen = UIColor.init(red: 217.0/255.0, green: 243.0/255.0, blue: 237.0/255.0, alpha: 1.0)
    static let appGreen = UIColor.init(red: 60.0/255.0, green: 226.0/255.0, blue: 195.0/255.0, alpha: 1.0)
    
    static let dataChangeNotificationName = "Data Changed"
    
    // MARK: Text Placeholder
    static let firstNamePlaceholder = "Enter First Name"
    static let lastNamePlaceholder = "Enter Last Name"
    static let emailNamePlaceholder = "Enter email"
    static let phoneNamePlaceholder = "Enter Phone Number"
    
    static let firstNameLabelText = "Enter First Name"
    static let lastNameLabelText = "Enter Last Name"
    static let emailNameLabelText = "Enter email"
    static let phoneNameLabelText = "Enter Phone Number"
    
    
    // MARK: Alert Status Messages
    static let kAlertNotSupportedMessage = "This feature is not supported to your device."
    static let kAlertNotaValidNumber = "Not a valid mobile number."
    static let kAlertMessageSentSuccess = "Your message has been sent."
    static let kAlertMessageSentFailed = "Failed to sent sms."
    
    static let kAlertMailSentSuccess = "Your mail has been sent."
    static let kAlertMailSentFailed = "Failed to sent mail."
    
    static let kAlertContactUpdateSuccess = "Your contact has been updated successfully."
    static let kAlertContactUpdateFailed = "Failed to Update contact."
    
    static let kAlertContactCreateSuccess = "Your contact has been created successfully."
    static let kAlertContactCreateFailed = "Failed to create contact."
    
    static let kAlertAddContactEmptyError = "Please provide all details to add contact"
    static let kAlertEmailError = "Please provide Valid Email Id"
    static let kAlertMobileError = "Please provide Mobile Number"
    
    static let kAlertDeleteContactError = "Failed to delete."
    
    // MARK: View constant
    static let kContactlistCellIdentifire = "ContactCell"
    static let kContactDetailCellIdentifire = "profileDetails"
    static let kCommonCellIdentifire = "commonCell"
    static let kDeleteContactCellIdentifire = "deleteContact"
    static let kAddContactCellIdentifire = "addContact"
    
    // MARK: Segue constant
    static let kContactDetailIndentifire = "contactDetails"
    static let kAddContactIdentifire = "addContact"
    
    
    
}
