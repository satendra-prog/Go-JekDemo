//
//  ContactDetailsInteractorTest.swift
//  Go-Jek
//
//  Created by Satendra Singh on 22/08/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//

import XCTest
@testable import Go_Jek

class ContactDetailsInteractorTest: XCTestCase,ContactDetailInteractorOutputProtocol {
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
    func testFetchContactDetails() {
        // This is an example of a functional test case.
        mockInteractor.presenter = self
        
        let mockListInteractor = ContactListInteractor()
        mockListInteractor.presenter = self as? ContactListInteractorOutputProtocol
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
        if response.error == nil {
            XCTAssertNotNil(response.contactDetails, "Contact details not fetched")
        }
        self.contactDetailsPresented=true
    }
    
    var favoriteToggleResponseReceived = false
     var deleteToggleResponseReceived = false
    func testFavouriteToggledTest() {
        mockInteractor.presenter = self
        
        let mockListInteractor = ContactListInteractor()
        mockListInteractor.presenter = self as? ContactListInteractorOutputProtocol
        mockListInteractor.fetchContacts()
        let expectaion = XCTNSPredicateExpectation.init(predicate: NSPredicate.init(format: "contactListFetched == true"), object: self)
        let _ = XCTWaiter().wait(for: [expectaion], timeout: 3.0)
        
        if let contactDetails = mockInteractor.selectedContact {
            let favouriteRequest = ContactDetails.FavouriteToggled.Request.init(favoriteState: !contactDetails.favorite)
            mockInteractor.favouriteToggled(request: favouriteRequest)
        } else {
            XCTFail("no contact details")
        }
        
        let detailsExpectation = XCTNSPredicateExpectation.init(predicate: NSPredicate.init(format: "favoriteToggleResponseReceived == true"), object: self)
        let _ = XCTWaiter().wait(for: [detailsExpectation], timeout: 3.0)
    }
    
    func gotFavouriteTogglingResult(response: ContactDetails.FavouriteToggled.Response) {
        if response.resultType == .success || response.resultType == .failure {
            
        } else {
            XCTFail("no result type")
        }
        self.favoriteToggleResponseReceived = true
    }
    
    func gotDeleteTogglingResult(response: ContactDetails.DeleteToggled.Response) {
        if response.resultType == .success || response.resultType == .failure {
            
        } else {
            XCTFail("no result type")
        }
        self.deleteToggleResponseReceived = true
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
