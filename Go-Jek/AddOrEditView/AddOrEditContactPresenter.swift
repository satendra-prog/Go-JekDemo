//
//  AddOrEditContactPresenter.swift
//  Go-Jek
//
//  Created by Satendra Singh on 22/08/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//

import UIKit

class AddOrEditContactPresenter: AddOrEditContactPresenterProtocol {

    weak private var view: AddOrEditContactViewProtocol?
    var interactor: AddOrEditContactInteractorInputProtocol?
    var router: AddOrEditContactWireframeProtocol?

    init(interface: AddOrEditContactViewProtocol, interactor: AddOrEditContactInteractorInputProtocol?, router: AddOrEditContactWireframeProtocol?) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    func sendChangedDataIfAny(request: AddOrEditContact.SendChangedData.Request){
        self.interactor?.sendChangedDataIfAny(request: request)
    }
    func getContactData(request: AddOrEditContact.GetContactData.Request) {
        self.interactor?.getContactData(request: request)
    }
    func routeToBack(){
        self.router?.routeToBack()
    }
    func routeToImagePickerLibrary(){
        self.router?.routeToImagePickerLibrary()
    }
    func routeToImagePickerCamera(){
        self.router?.routeToImagePickerCamera()
    }
    func routeToImagePickerOptions(){
        self.router?.routeToImagePickerOptions()
    }


}

extension AddOrEditContactPresenter: AddOrEditContactInteractorOutputProtocol {
    // MARK: AddOrEditContactInteractorOutputProtocol functions
    
    // MARK: Do something
    func gotContactData(response: AddOrEditContact.GetContactData.Response) {
        let viewModel = self.createGotContactViewModel(response: response)
        self.view?.gotContactData(viewModel: viewModel)
    }
    
    func dataChangeResult(response: AddOrEditContact.SendChangedData.Response) {
        let viewModel = self.createSendChanedDataViewModel(response: response)
        DispatchQueue.main.async {
            self.view?.gotChangingDataResults(viewModel: viewModel)
        }
    }
    
    fileprivate func createSendChanedDataViewModel(response: AddOrEditContact.SendChangedData.Response) -> AddOrEditContact.SendChangedData.ViewModel {
        let viewModel = AddOrEditContact.SendChangedData.ViewModel.init(resultType: response.resultType, message: response.message)
        return viewModel
    }
    
    func createGotContactViewModel(response: AddOrEditContact.GetContactData.Response) -> AddOrEditContact.GetContactData.ViewModel {
        let firstName = response.selectedContact?.firstName ?? ""
        let lastName = response.selectedContact?.lastName ?? ""
        let phoneNumber = response.selectedContact?.phoneNumber ?? ""
        let email = response.selectedContact?.email ?? ""
        let imageUrl = response.selectedContact?.profilePic ?? ""
        
        let model = AddOrEditContact.GetContactData.ViewModel.ContactData.init(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber, imageUrl: imageUrl)
        let viewModel = AddOrEditContact.GetContactData.ViewModel.init(selectedContact: model)
        return viewModel
    }

}
