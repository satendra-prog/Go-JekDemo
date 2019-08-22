//
//  AddOrEditContactProtocols.swift
//  Go-Jek
//
//  Created by Satendra Singh on 22/08/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//

import Foundation

// MARK: WireFrameProtocol

protocol AddOrEditContactWireframeProtocol: class {
    var dataStore: AddOrEditContactDataStore? { get }
    func routeToBack()
    func routeToImagePickerLibrary()
    func routeToImagePickerCamera()
    func routeToImagePickerOptions()

}

// MARK: PresenterProtocol

protocol AddOrEditContactPresenterProtocol: class {

    var interactor: AddOrEditContactInteractorInputProtocol? { get set }
    var router: AddOrEditContactWireframeProtocol? { get set }
    func sendChangedDataIfAny(request: AddOrEditContact.SendChangedData.Request)
    func getContactData(request: AddOrEditContact.GetContactData.Request)
    func routeToBack()
    func routeToImagePickerLibrary()
    func routeToImagePickerCamera()
    func routeToImagePickerOptions()

}

// MARK: InteractorProtocol

protocol AddOrEditContactInteractorOutputProtocol: class {

    /** Interactor -> Presenter */
    func dataChangeResult(response: AddOrEditContact.SendChangedData.Response)
    func gotContactData(response: AddOrEditContact.GetContactData.Response)

}

protocol AddOrEditContactInteractorInputProtocol: class {

    var presenter: AddOrEditContactInteractorOutputProtocol? { get set }

    /** Presenter -> Interactor */
    func getContactData(request: AddOrEditContact.GetContactData.Request)
    func sendChangedDataIfAny(request: AddOrEditContact.SendChangedData.Request)
}

protocol AddOrEditContactDataStore {
    var selectedContact: ContactDetailResponseDataModel? {get set}
    var addOrEdit: AddOrEdit {get set}
}

// MARK: ViewProtocol

protocol AddOrEditContactViewProtocol: class {

    var presenter: AddOrEditContactPresenterProtocol? { get set }

    /** Presenter -> ViewController */
    func gotContactData(viewModel: AddOrEditContact.GetContactData.ViewModel)
    func gotChangingDataResults(viewModel: AddOrEditContact.SendChangedData.ViewModel)
}
