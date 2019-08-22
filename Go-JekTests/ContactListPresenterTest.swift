//
//  ContactListPresenterTest.swift
//  Go-Jek
//
//  Created by Satendra Singh on 22/08/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//

import XCTest
@testable import Go_Jek

class ContactListPresenterTest: XCTestCase,ContactListInteractorOutputProtocol {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    var contactsFetched = false
    func testPresentContacts() {
        let mockInteractor = ContactListInteractor()
        mockInteractor.presenter = self
        mockInteractor.fetchContacts()
        
        let expectaion = XCTNSPredicateExpectation.init(predicate: NSPredicate.init(format: "contactsPresented == true"), object: self)
        let _ = XCTWaiter().wait(for: [expectaion], timeout: 3.0)
    }
    
    func presentContacts(response: ContactsList.FetchContacts.Response) {
        
        let viewController = ContactListViewController()
        let interactor = ContactListInteractor()
        let router = ContactListRouter()

        let mockPresenter = ContactListPresenter(interface: viewController, interactor: interactor, router: router)
        let viewModel = mockPresenter.createViewModel(response: response)
        XCTAssertNotNil(viewModel, "no view model received")
        if viewModel!.errorMessage == nil {
            XCTAssertNotNil(viewModel!.dictMapping, "no mapping dictioanry received received")
            XCTAssertNotNil(viewModel!.dictContacts, "no contacts dictioanry received received")
        }
        contactsFetched = true
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
