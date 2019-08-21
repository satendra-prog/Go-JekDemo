//
//  ContactListRouter.swift
//  Go-Jek
//
//  Created by Satendra Singh on 20/08/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//


import UIKit

class ContactListRouter: ContactListWireframeProtocol {
    var dataStore: ContactsListDataStore?
    weak var viewController: ContactListViewController?

    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = ContactListViewController(nibName: nil, bundle: nil)
        let interactor = ContactListInteractor()
        let router = ContactListRouter()
        let presenter = ContactListPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
    
    func routeToContactDetails() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "ContactDetailViewController") as! ContactDetailViewController
        var destinationDS = destinationVC.presenter?.router?.dataStore
        self.passDataToContactDetails(source: self.dataStore!, destination: &destinationDS!)
        self.navigateToView(source: self.viewController as! ContactListViewController, destination: destinationVC)
    }
    
    func routeToAddContact() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "AddOrEditContactViewController") as! AddOrEditContactViewController
        var destinationDS = destinationVC.presenter?.router?.dataStore
        self.passDataToAddOrEdit(source: self.dataStore!, destination: &destinationDS!)
        self.presentScene(source: self.viewController!, destination: destinationVC)
    }
    
    func passDataToAddOrEdit(source: ContactsListDataStore, destination: inout AddOrEditContactDataStore)
    {
        destination.addOrEdit = AddOrEdit.add
    }
    func presentScene(source: ContactListViewController, destination: UIViewController) {
        source.present(destination, animated: true, completion: nil)
    }

    func passDataToContactDetails(source: ContactsListDataStore, destination: inout ContactDetailsDataStore)
    {
        destination.selectedContact = source.selectedContact
    }
    
    func navigateToView(source: ContactListViewController, destination: UIViewController)
    {
        source.navigationController?.pushViewController(destination, animated: true)
    }

}
