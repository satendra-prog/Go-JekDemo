//
//  ContactAddOrEditPresenterTest.swift
//  Go-Jek
//
//  Created by Satendra Singh on 22/08/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//

import XCTest
@testable import Go_Jek

class ContactAddOrEditPresenterTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreateGetContactModel() {
        let mockContact = ContactDetailResponseDataModel.init(id: 1, firstName: "demo", lastName: "demo", profilePic: "demo", favorite: true, phoneNumber: "demoNumber", email: "demoEmail", createdAt: "", updatedAt: "")
        
        let viewController = AddOrEditContactViewController()
        let interactor = AddOrEditContactInteractor()
        let router = AddOrEditContactRouter()
        let presenter = AddOrEditContactPresenter.init(interface: viewController, interactor: interactor, router: router)
        let mockResponse = AddOrEditContact.GetContactData.Response.init(selectedContact: mockContact)
        let viewModel = presenter.createGotContactViewModel(response: mockResponse)
        XCTAssertNotNil(viewModel.selectedContact, "viewmodel creationg logic is failing")
        XCTAssertEqual(viewModel.selectedContact?.email, "demoEmail", "viewmodel creationg logic is failing")
        XCTAssertEqual(viewModel.selectedContact?.phoneNumber, "demoNumber", "viewmodel creationg logic is failing")
        XCTAssertEqual(viewModel.selectedContact?.firstName, "demo", "viewmodel creationg logic is failing")
        XCTAssertEqual(viewModel.selectedContact?.lastName, "demo", "viewmodel creationg logic is failing")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
