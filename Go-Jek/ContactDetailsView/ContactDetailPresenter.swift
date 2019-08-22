//
//  ContactDetailPresenter.swift
//  Go-Jek
//
//  Created by Satendra Singh on 21/08/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//

import UIKit

class ContactDetailPresenter: ContactDetailPresenterProtocol {

    weak private var view: ContactDetailViewProtocol?
    var interactor: ContactDetailInteractorInputProtocol?
    var router: ContactDetailWireframeProtocol?


    init(interface: ContactDetailViewProtocol, interactor: ContactDetailInteractorInputProtocol?, router: ContactDetailWireframeProtocol?) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func getContactDetails(request: ContactDetails.FetchContactDetails.Request){
        self.interactor?.getContactDetails(request: request)
    }
    func favouriteToggled(request: ContactDetails.FavouriteToggled.Request){
        self.interactor?.favouriteToggled(request: request)
    }
    func deleteContact(){
        self.interactor?.deleteContact()
    }

    func routeToEdit(){
      self.router?.routeToEdit()
    }
    func routeToMessages(){
        self.router?.routeToMessages()
    }
    func routeToMail(){
        self.router?.routeToMail()
    }
    func routeToPhone(){
        self.router?.routeToPhone()
    }
    func routeToBack(){
        self.router?.routeToBack()
    }
    
}

extension ContactDetailPresenter: ContactDetailInteractorOutputProtocol {
    func gotDeleteTogglingResult(response: ContactDetails.DeleteToggled.Response) {
        let viewModel = ContactDetails.DeleteToggled.ViewModel.init(resultType: response.resultType, message: response.message)
        DispatchQueue.main.async {
            self.view?.didGetDeleteToggledResult(viewModel: viewModel)
        }
    }
    
    // MARK: ContactDetailInteractorOutputProtocol functions
    
    // MARK: Do something
    func presentContactDetails(response: ContactDetails.FetchContactDetails.Response) {
        if response.error != nil {
            let errorString = response.error?.rawValue
            let viewModel = ContactDetails.FetchContactDetails.ViewModel.init(contactDetails: nil, errorMessage: errorString!)
            DispatchQueue.main.async {
                self.view?.didFetchContactDetails(viewModel: viewModel)
            }
        } else {
            if let viewModel = self.createViewModel(response: response) {
                DispatchQueue.main.async {
                    self.view?.didFetchContactDetails(viewModel: viewModel)
                }
            }
        }
    }
    
    func gotFavouriteTogglingResult(response: ContactDetails.FavouriteToggled.Response) {
        let viewModel = ContactDetails.FavouriteToggled.ViewModel.init(resultType: response.resultType, message: response.message)
        DispatchQueue.main.async {
            self.view?.didGetFavoriteToggledResult(viewModel: viewModel)
        }
    }
    
    func createViewModel(response: ContactDetails.FetchContactDetails.Response) -> ContactDetails.FetchContactDetails.ViewModel? {
        if let contactDetails = response.contactDetails {
            let name = (contactDetails.firstName ?? "") + " " + (contactDetails.lastName ?? "")
            let imageUrl = contactDetails.profilePic
            let isFavourite = contactDetails.favorite
            let phoneNumber = contactDetails.phoneNumber ?? ""
            let email = contactDetails.email ?? ""
            let model = ContactDetails.FetchContactDetails.ViewModel.ContactDetailsViewModel.init(name: name, imageUrl: imageUrl, isFavorite: isFavourite, phoneNo: phoneNumber, email: email)
            let viewModel = ContactDetails.FetchContactDetails.ViewModel.init(contactDetails: model, errorMessage: nil)
            return viewModel
        }
        return nil
    }
}
