//
//  ContactListProtocols.swift
//  Go-Jek
//
//  Created by Satendra Singh on 20/08/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//


import Foundation

// MARK: WireFrameProtocol

protocol ContactListWireframeProtocol: class {
     func routeToContactDetails()
     func routeToAddContact()
    var dataStore: ContactsListDataStore? { get }

}

// MARK: PresenterProtocol

protocol ContactListPresenterProtocol: class {

    var interactor: ContactListInteractorInputProtocol? { get set }
    func assignProperContactDetails(id: Int)
    func fetchContacts()
    func routeToContactDetails()
    func routeToAddContact()

}

// MARK: InteractorProtocol

protocol ContactListInteractorOutputProtocol: class {

    /** Interactor -> Presenter */
    
    func presentContacts(response: ContactsList.FetchContacts.Response)

}

protocol ContactListInteractorInputProtocol: class {

    var presenter: ContactListInteractorOutputProtocol? { get set }

    /** Presenter -> Interactor */
    
    func fetchContacts()
    func assignProperContactDetails(id: Int)
}

protocol ContactsListDataStore {
    //var name: String { get set }
    var selectedContact: DataModel? {get set}
}

// MARK: ViewProtocol

protocol ContactListViewProtocol: class {

    var presenter: ContactListPresenterProtocol? { get set }

    /** Presenter -> ViewController */
    
    func didFetchContacts(viewModel: ContactsList.FetchContacts.ViewModel)

}
