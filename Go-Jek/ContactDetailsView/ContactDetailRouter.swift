//
//  ContactDetailRouter.swift
//  Go-Jek
//
//  Created by Satendra Singh on 21/08/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//

import UIKit
import MessageUI

class ContactDetailRouter: ContactDetailWireframeProtocol {

    weak var viewController: ContactDetailViewController?
    var dataStore: ContactDetailsDataStore?

    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = ContactDetailViewController(nibName: nil, bundle: nil)
        let interactor = ContactDetailInteractor()
        let router = ContactDetailRouter()
        let presenter = ContactDetailPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
    
    // MARK: Routing
    
    func routeToEdit() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "AddOrEditContactViewController") as! AddOrEditContactViewController
        var destinationDS = destinationVC.presenter?.router?.dataStore
        self.passDataToAddOrEditContacts(source: self.dataStore!, destination: &destinationDS!)
        self.presentScene(source: self.viewController!, destination: destinationVC)
    }
    
    func routeToBack() {
        self.viewController?.navigationController?.popViewController(animated: true)
       // self.viewController?.dismiss(animated: true, completion: nil)
    }
   
    
    func routeToMessages() {
        if let dataStore = self.dataStore, let contactDetails = dataStore.selectedContactDetails, let phoneNumber = contactDetails.phoneNumber {
            if phoneNumber != "" {
                let cleanedString = phoneNumber.components(separatedBy: CharacterSet.init(charactersIn: "0123456789-+()").inverted).joined(separator: "")
                let messageComposeViewController = MFMessageComposeViewController()
                messageComposeViewController.delegate = self.viewController
                messageComposeViewController.recipients = [cleanedString]
                if MFMessageComposeViewController.canSendText() {
                    self.presentScene(source: self.viewController!, destination: messageComposeViewController)
                }
            }
        }
    }
    
    func routeToMail() {
        if let dataStore = self.dataStore, let contactDetails = dataStore.selectedContactDetails, let emailId = contactDetails.email {
            if emailId != "" {
                let mailComposeViewController = MFMailComposeViewController()
                mailComposeViewController.delegate = self.viewController
                mailComposeViewController.setToRecipients([emailId])
                if MFMailComposeViewController.canSendMail() {
                    self.presentScene(source: self.viewController!, destination: mailComposeViewController)
                }
            }
        }
    }
    
    func routeToPhone() {
        if let dataStore = self.dataStore, let contactDetails = dataStore.selectedContactDetails, let phoneNumber = contactDetails.phoneNumber {
            if phoneNumber != "" {
                let cleanedString = phoneNumber.components(separatedBy: CharacterSet.init(charactersIn: "0123456789-+()").inverted).joined(separator: "")
                if let url = URL.init(string: "tel:\(cleanedString)") {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            }
        }
    }

    func passDataToAddOrEditContacts(source: ContactDetailsDataStore, destination: inout AddOrEditContactDataStore) {
        destination.selectedContact = source.selectedContactDetails
        destination.addOrEdit = .edit
    }
    
    func presentScene(source: ContactDetailViewController, destination: UIViewController) {
        source.present(destination, animated: true, completion: nil)
    }
    


}
