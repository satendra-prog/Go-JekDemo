//
//  ContactDetailPresenterTest.swift
//  Go-Jek
//
//  Created by Satendra Singh on 22/08/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//

import XCTest
@testable import Go_Jek

class ContactDetailPresenterTest: XCTestCase,ContactDetailPresenterProtocol {
    var interactor: ContactDetailInteractorInputProtocol?
    
    var router: ContactDetailWireframeProtocol?
    
 
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    var contactDetailsPresented = false
    var contactListFetched = false
    let mockInteractor = ContactDetailInteractor()
    func testContactsPresented() {
        mockInteractor.presenter = self as? ContactDetailInteractorOutputProtocol
        
        let mockListInteractor = ContactListInteractor()
        mockListInteractor.presenter = self as? ContactListInteractorOutputProtocol
        let request = ContactsList.FetchContacts.Request.init()
        mockListInteractor.fetchContacts()
        let expectaion = XCTNSPredicateExpectation.init(predicate: NSPredicate.init(format: "contactListFetched == true"), object: self)
        let _ = XCTWaiter().wait(for: [expectaion], timeout: 3.0)
        
        
        let detailsRequest = ContactDetails.FetchContactDetails.Request.init()
        mockInteractor.getContactDetails(request: detailsRequest)
        
        let detailsExpectation = XCTNSPredicateExpectation.init(predicate: NSPredicate.init(format: "contactDetailsPresented == true"), object: self)
        let _ = XCTWaiter().wait(for: [detailsExpectation], timeout: 3.0)
    }
    
    func presentContacts(response: ContactsList.FetchContacts.Response) {
        if response.error == nil {
            mockInteractor.selectedContact = response.contactsListData![0]
        }
        self.contactListFetched=true
    }
    
    func presentContactDetails(response: ContactDetails.FetchContactDetails.Response) {
        let viewController = ContactDetailViewController()
        let interactor = ContactDetailInteractor()
        let router = ContactDetailRouter()

        let presenter = ContactDetailPresenter.init(interface: viewController, interactor: interactor, router: router)
        let viewModel = presenter.createViewModel(response: response)
        if viewModel?.errorMessage == nil {
            XCTAssertNotNil(viewModel?.contactDetails, "contact details are nil")
        } else {
            XCTFail("could nto fetch contact details")
        }
    }
    
    func gotFavouriteTogglingResult(response: ContactDetails.FavouriteToggled.Response) {
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func getContactDetails(request: ContactDetails.FetchContactDetails.Request) {
        
    }
    
    func favouriteToggled(request: ContactDetails.FavouriteToggled.Request) {
        
    }
    
    func deleteContact() {
        
    }
    
    func routeToBack() {
        
    }
    
    func routeToEdit() {
        
    }
    
    func routeToMessages() {
        
    }
    
    func routeToMail() {
        
    }
    
    func routeToPhone() {
        
    }
    
    
    
}
