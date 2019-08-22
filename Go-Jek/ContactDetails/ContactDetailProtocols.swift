//
//  ContactDetailProtocols.swift
//  Go-Jek
//
//  Created by Satendra Singh on 21/08/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//

import Foundation

// MARK: WireFrameProtocol

protocol ContactDetailWireframeProtocol: class {
    var dataStore: ContactDetailsDataStore? { get }
    func routeToEdit()
    func routeToMessages()
    func routeToMail()
    func routeToPhone()
    func routeToBack()

}

// MARK: PresenterProtocol

protocol ContactDetailPresenterProtocol: class {

    var interactor: ContactDetailInteractorInputProtocol? { get set }
    var router: ContactDetailWireframeProtocol? { get set }
    func getContactDetails(request: ContactDetails.FetchContactDetails.Request)
    func favouriteToggled(request: ContactDetails.FavouriteToggled.Request)
     func deleteContact()
    func routeToBack()
    func routeToEdit()
    func routeToMessages()
    func routeToMail()
    func routeToPhone()

}

// MARK: InteractorProtocol

protocol ContactDetailInteractorOutputProtocol: class {

    /** Interactor -> Presenter */
    func presentContactDetails(response: ContactDetails.FetchContactDetails.Response)
    func gotFavouriteTogglingResult(response: ContactDetails.FavouriteToggled.Response)
    func gotDeleteTogglingResult(response: ContactDetails.DeleteToggled.Response)
}

protocol ContactDetailInteractorInputProtocol: class {

    var presenter: ContactDetailInteractorOutputProtocol? { get set }
    
    /** Presenter -> Interactor */
    func getContactDetails(request: ContactDetails.FetchContactDetails.Request)
    func favouriteToggled(request: ContactDetails.FavouriteToggled.Request)
    func deleteContact()
}

// MARK: ViewProtocol

protocol ContactDetailViewProtocol: class {

    var presenter: ContactDetailPresenterProtocol? { get set }

    /** Presenter -> ViewController */
    
    func didFetchContactDetails(viewModel: ContactDetails.FetchContactDetails.ViewModel)
    func didGetFavoriteToggledResult(viewModel: ContactDetails.FavouriteToggled.ViewModel)
     func didGetDeleteToggledResult(viewModel: ContactDetails.DeleteToggled.ViewModel)

}

protocol ContactDetailsDataStore {
    //var name: String { get set }
    var selectedContact: DataModel? {get set}
    var selectedContactDetails: ContactDetailResponseDataModel? {get set}
}

