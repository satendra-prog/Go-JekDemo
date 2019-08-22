//
//  ContactDetailInteractor.swift
//  Go-Jek
//
//  Created by Satendra Singh on 21/08/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//

import Foundation

class ContactDetailInteractor: ContactDetailInteractorInputProtocol,ContactDetailsDataStore {
    
    weak var presenter: ContactDetailInteractorOutputProtocol?
    
    var selectedContact: DataModel?
    var selectedContactDetails: ContactDetailResponseDataModel?
    
    func getContactDetails(request: ContactDetails.FetchContactDetails.Request) {
        if let contact = self.selectedContact {
            getContactGenericDetail(contact.url) { [weak self] (contactDetails: ContactDetailResponseDataModel?,error) in
                let response = ContactDetails.FetchContactDetails.Response.init(contactDetails: contactDetails, error: error)
                    self?.selectedContactDetails = contactDetails
                    self?.presenter?.presentContactDetails(response: response)
            }
        }
    }
    
    func favouriteToggled(request: ContactDetails.FavouriteToggled.Request) {
        if let contact = self.selectedContact {
            
            if let contactDetails = self.selectedContactDetails {
                let favouriteState = request.favoriteState
                var dataDictionary: [String: Any] = [:]
                dataDictionary["first_name"] = contactDetails.firstName
                dataDictionary["last_name"] = contactDetails.lastName
                dataDictionary["email"] = contactDetails.email
                dataDictionary["phone_number"] = contactDetails.phoneNumber
                dataDictionary["favorite"] = favouriteState
                dataDictionary["profile_pic"] = contactDetails.profilePic
                dataDictionary["id"] = contactDetails.id
                
                favouriteToggledPutData(dataDictionary,contact.url, { [weak self] (result, message) in
                    guard let strongSelf = self else {
                        return
                    }
                    let response = ContactDetails.FavouriteToggled.Response.init(resultType: result, message: message)
                    strongSelf.presenter?.gotFavouriteTogglingResult(response: response)
                })
            }
        }
    }
    func deleteContact() {
        if let contact = self.selectedContact {
                deleteContact(contact.url, { [weak self] (result, message) in
                    guard let strongSelf = self else {
                        return
                    }
                    let response = ContactDetails.DeleteToggled.Response.init(resultType: result, message: message)
                    strongSelf.presenter?.gotDeleteTogglingResult(response: response)
                })
            }
        }
    
}

extension ContactDetailInteractor {
    
    func getContactGenericDetail<T: Decodable>(_ urlString: String, completion: @escaping (T?,Constants.CustomError?)-> ()) {
        
        let networkManager = NetworkManager()
        networkManager.getContactDetails(urlString: urlString){ data, response,error in
            guard let data = data else { return }
            do {
                let homeFeed = try JSONDecoder().decode(T.self,from: data)
                completion(homeFeed,nil)
            } catch let jsonError{
                completion(nil, Constants.CustomError.unknownError)
                print("Failed to serialize json:",jsonError)
            }
        }
    }
    
    func deleteContact(_ urlString:String,_ completion: @escaping (ContactDetails.DeleteToggled.ResultType, String)-> ()) {
        do {
            let networkManager = NetworkManager()
            networkManager.deleteContact(urlString: urlString){ data, response,error in
                guard let data = data else { return }
                
                if let httpResponse = response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    if statusCode == 201 || statusCode == 200 {
                        completion(.success, "Success")
                    } else {
                        completion(.failure, "Error Occurred")
                    }
                }
            }
        } catch {
            print("could not convert to data")
        }
    }
    
    
    func favouriteToggledPutData(_ params: [String:Any]?, _ urlString: String,_ completion: @escaping (ContactDetails.FavouriteToggled.ResultType, String)-> ()) {
        
        do {
            let networkManager = NetworkManager()
            networkManager.putNewContact(urlString: urlString,params: params){ data, response,error in
                guard let data = data else { return }
                
                if let httpResponse = response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    if statusCode == 201 || statusCode == 200 {
                        completion(.success, "Success")
                    } else {
                        completion(.failure, "Error Occurred")
                    }
                }
            }
        } catch {
            print("could not convert to data")
        }
    }
    
}
