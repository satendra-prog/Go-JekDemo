//
//  ContactListPresenter.swift
//  Go-Jek
//
//  Created by Satendra Singh on 20/08/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//


import UIKit

class ContactListPresenter: ContactListPresenterProtocol {
    
    weak var view: ContactListViewProtocol?
    var interactor: ContactListInteractorInputProtocol?
    private let router: ContactListWireframeProtocol

    init(interface: ContactListViewProtocol, interactor: ContactListInteractorInputProtocol?, router: ContactListWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func fetchContacts() {
        self.interactor?.fetchContacts()
    }

}

extension ContactListPresenter: ContactListInteractorOutputProtocol {
    // MARK: ContactListInteractorOutputProtocol functions
    
    func presentContacts(response: ContactsList.FetchContacts.Response) {
        if response.error != nil {
            let errorString = response.error?.rawValue
            let viewModel = ContactsList.FetchContacts.ViewModel.init(dictMapping: nil, dictContacts: nil, errorMessage: errorString)
            self.view?.didFetchContacts(viewModel: viewModel)
        } else {
            if let viewModel = self.createViewModel(response: response) {
                self.view?.didFetchContacts(viewModel: viewModel)
            }
        }
    }
    
    func createViewModel(response: ContactsList.FetchContacts.Response) -> ContactsList.FetchContacts.ViewModel? {
        if let arrContact = response.contactsListData {
         //  var arrContactViewModel: [ContactsList.FetchContacts.ViewModel.ContactListViewModel] = []
            var dictMapping: [Int: String] = [:]
            var dictContactViewModel: [String: [ContactsList.FetchContacts.ViewModel.ContactListViewModel]] = [:]
            var firstLetter = ""
            var initialIndex = 0
            for contact in arrContact {
                let firstLetterOfFirstName = String.init(contact.firstName.first!).lowercased()
                let name = contact.firstName + " " + contact.lastName
                let imageUrl = contact.profilePic
                let isFavourite = contact.favorite
                let id = contact.id
                let model = ContactsList.FetchContacts.ViewModel.ContactListViewModel.init(id: id, name: name, imageUrl: imageUrl, isFavourite: isFavourite)
                print("firs----",firstLetterOfFirstName)
                if firstLetterOfFirstName == firstLetter {
                    dictContactViewModel[firstLetterOfFirstName]?.append(model)
                } else {
                    if (dictContactViewModel[firstLetterOfFirstName] == nil){
                        dictContactViewModel[firstLetterOfFirstName] = []
                        dictMapping[initialIndex] = firstLetterOfFirstName
                        initialIndex += 1
                    }
                   
                    firstLetter = firstLetterOfFirstName
                     dictContactViewModel[firstLetterOfFirstName]?.append(model)
                }
                
           //   arrContactViewModel.append(model)
            }
            
            let viewModel = ContactsList.FetchContacts.ViewModel.init(dictMapping: dictMapping, dictContacts: dictContactViewModel, errorMessage: nil)
            return viewModel
        }
        return nil
    }
    
    func routeToContactDetails(){
      self.router.routeToContactDetails()
    }
    
    func routeToAddContact() {
        self.router.routeToAddContact()
    }
    
    func assignProperContactDetails(id: Int) {
       self.interactor?.assignProperContactDetails(id: id)
    }

    
}
