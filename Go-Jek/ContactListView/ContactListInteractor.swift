//
//  ContactListInteractor.swift
//  Go-Jek
//
//  Created by Satendra Singh on 20/08/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//


import UIKit

class ContactListInteractor: ContactListInteractorInputProtocol,ContactsListDataStore {
    var selectedContact: DataModel?
    weak var presenter: ContactListInteractorOutputProtocol?
    var contactsListData: [DataModel] = []

    func fetchContacts() {
        fetchData { [weak self] (data,error) in
            let response = ContactsList.FetchContacts.Response.init(contactsListData: data, error: error)
            if data != nil {
                    self?.contactsListData = data!
                }
            
            print(self!.contactsListData)
              DispatchQueue.main.async {
                   self?.presenter?.presentContacts(response: response)
                 }
        }
    }
    
    func assignProperContactDetails(id: Int) {
        for contact in contactsListData {
            if contact.id == id {
                selectedContact = contact
            }
        }
    }
}


extension ContactListInteractor {
    func fetchData(completion: @escaping ([DataModel]?,Constants.CustomError?)-> ()) {
        
        let networkManager = NetworkManager()
        networkManager.getAllContacts{ data, response,error in
            guard let data = data else { return }
            do {
//                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else{return}
//
//                print("----json----",json)

                let homeFeed = try JSONDecoder().decode([DataModel].self,from: data)
                print(homeFeed)
                completion(homeFeed,nil)
            } catch let jsonError{
                completion(nil, Constants.CustomError.unknownError)
                print("Failed to serialize json:",jsonError)
            }
        }
    }
    
}
