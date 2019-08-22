//
//  ContactListInteractorTest.swift
//  Go-Jek
//
//  Created by Satendra Singh on 22/08/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//

import XCTest
@testable import Go_Jek

protocol ContactsListDisplayLogic: class {
    func didFetchContacts(viewModel: ContactsList.FetchContacts.ViewModel)
}

enum TestCase {
    case testInteractorFetch
    case testInteractorAssign
}


class ContactListInteractorTest: XCTestCase,ContactListInteractorOutputProtocol {
    var testCase: TestCase = .testInteractorFetch

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    var contactsPresented = false
    var mockInteractor = ContactListInteractor()
    func testFetchContacts() {
        self.testCase = .testInteractorFetch
        // This is an example of a functional test case.
        let mockInteractor = ContactListInteractor()
        mockInteractor.presenter = self
        
        mockInteractor.fetchContacts()
        
        let expectaion = XCTNSPredicateExpectation.init(predicate: NSPredicate.init(format: "contactsPresented == true"), object: self)
        let _ = XCTWaiter().wait(for: [expectaion], timeout: 3.0)
    }
    
    func testAssignId() {
        self.testCase = .testInteractorAssign
        mockInteractor.presenter = self
        
        mockInteractor.fetchContacts()
        
        let expectaion = XCTNSPredicateExpectation.init(predicate: NSPredicate.init(format: "contactsPresented == true"), object: self)
        let _ = XCTWaiter().wait(for: [expectaion], timeout: 3.0)
    }
    
    func presentContacts(response: ContactsList.FetchContacts.Response) {
        switch self.testCase {
        case .testInteractorAssign:
            self.fetchedInteractorAssignTest(response: response)
        case .testInteractorFetch:
            self.fetchedInteractorContactsTest(response: response)
        }
    }
    
    fileprivate func fetchedInteractorContactsTest(response: ContactsList.FetchContacts.Response) {
        if let arrContacts = response.contactsListData {
            XCTAssert(arrContacts.count > 0, "no results found")
        } else {
            if let error = response.error {
                XCTAssert(error == .unknownError, "error type is different")
            }
        }
        self.contactsPresented = true
    }
    
    fileprivate func fetchedInteractorAssignTest(response: ContactsList.FetchContacts.Response) {
        if let arrContacts = response.contactsListData {
            let testId = arrContacts[0].id
            mockInteractor.assignProperContactDetails(id: testId)
            XCTAssertNotNil(mockInteractor.selectedContact, "assign proper contact details not workign properly")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    

}
