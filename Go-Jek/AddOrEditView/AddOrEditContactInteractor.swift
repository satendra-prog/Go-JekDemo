//
//  AddOrEditContactInteractor.swift
//  Go-Jek
//
//  Created by Satendra Singh on 22/08/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//

import Foundation

struct UserEditableData {
    var firstName: String = ""
    var lastName: String = ""
    var phoneNumber: String = ""
    var email: String = ""
    var profilePic: String = ""
}

class AddOrEditContactInteractor: AddOrEditContactInteractorInputProtocol,AddOrEditContactDataStore {

    weak var presenter: AddOrEditContactInteractorOutputProtocol?

    var addOrEdit: AddOrEdit = .add
    var selectedContact: ContactDetailResponseDataModel?
    
    func getContactData(request: AddOrEditContact.GetContactData.Request) {
        if let selectedContact = self.selectedContact {
            let response = AddOrEditContact.GetContactData.Response.init(selectedContact: selectedContact)
            self.presenter?.gotContactData(response: response)
        } else {
            let response = AddOrEditContact.GetContactData.Response.init(selectedContact: nil)
            self.presenter?.gotContactData(response: response)
        }
    }
    
    func sendChangedDataIfAny(request: AddOrEditContact.SendChangedData.Request) {
        var hasValuesChanged = false
        
        if !Utility.validateEmailId(email: request.email) || request.phoneNumber.count < 9 || request.firstName == "" || request.lastName == "" {
            let response = AddOrEditContact.SendChangedData.Response.init(resultType: .validationFailure, message: "Please fill valid data")
            self.presenter?.dataChangeResult(response: response)
            return
        }
        
        if let selectedContact = self.selectedContact {
            hasValuesChanged = selectedContact.hasUserValueChanged(firstName: request.firstName, lastName: request.lastName, email: request.email, phoneNumber: request.phoneNumber)
        } else {
            hasValuesChanged = true
        }
        if hasValuesChanged == true {
            self.editOrAddData(editOrAdd: self.addOrEdit, contactDetails: selectedContact, firstName: request.firstName, lastName: request.lastName, email: request.email, phoneNo: request.phoneNumber) { [weak self] (resultType, message) in
                guard let strongSelf = self else {
                    return
                }
                let response = AddOrEditContact.SendChangedData.Response.init(resultType: resultType, message: message)
                strongSelf.presenter?.dataChangeResult(response: response)
            }
        } else {
            let response = AddOrEditContact.SendChangedData.Response.init(resultType: .noNewData, message: "No new data has been entered")
            self.presenter?.dataChangeResult(response: response)
        }
    }

    
}

extension AddOrEditContactInteractor {
    func editOrAddData(editOrAdd: AddOrEdit, contactDetails: ContactDetailResponseDataModel?, firstName: String, lastName: String, email : String, phoneNo: String, completionHandler: @escaping (ResultType, String) -> Void) {
        if editOrAdd == .add {
            self.postData(firstName: firstName, lastName: lastName, email: email, phoneNo: phoneNo, completionHandler: completionHandler)
        } else {
            self.putData(contactDetails: contactDetails, firstName: firstName, lastName: lastName, email: email, phoneNo: phoneNo, completionHandler: completionHandler)
        }
    }
    
    fileprivate func postData(firstName: String, lastName: String, email : String, phoneNo: String, completionHandler: @escaping (ResultType, String) -> Void) {
        var dataDictionary: [AnyHashable: Any] = [:]
        dataDictionary["first_name"] = firstName
        dataDictionary["last_name"] = lastName
        dataDictionary["email"] = email
        dataDictionary["phone_number"] = phoneNo
        dataDictionary["favorite"] = false
        do {
            let data = try JSONSerialization.data(withJSONObject: dataDictionary, options: .prettyPrinted)
            NetworkManager().postNewContact(data: data) { (receivedData, response, error) in
                if let httpResponse = response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    if statusCode == 201 {
                        completionHandler(ResultType.success, "Successfully added data")
                    } else {
                        completionHandler(ResultType.responseFailure, "Some error occured in server")
                    }
                }
            }
        } catch {
            print("could not convert to data")
        }
    }
    
    fileprivate func putData(contactDetails: ContactDetailResponseDataModel?, firstName: String, lastName: String, email : String, phoneNo: String, completionHandler: @escaping (ResultType, String) -> Void) {
        if let contactId = contactDetails?.id {
            var dataDictionary: [String: Any] = [:]
            dataDictionary["first_name"] = firstName
            dataDictionary["last_name"] = lastName
            dataDictionary["email"] = email
            dataDictionary["phone_number"] = phoneNo
            dataDictionary["favorite"] = contactDetails?.favorite
            dataDictionary["profile_pic"] = contactDetails?.profilePic
            dataDictionary["id"] = contactId
            do {
                let urlString = Constants.putContactsUrlString + "/\(contactId).json"
                NetworkManager().putNewContact(urlString: urlString, params: dataDictionary) { (receivedData, response, error) in
                    if let httpResponse = response as? HTTPURLResponse {
                        let statusCode = httpResponse.statusCode
                        if statusCode == 201 ||  statusCode == 200 {
                               completionHandler(ResultType.success, "Successfully changed data")
                        } else {
                               completionHandler(ResultType.responseFailure, "Some error occured in server")
                        }
                    }
                }
            } catch {
                print("could not convert to data")
            }
        }
    }

}
