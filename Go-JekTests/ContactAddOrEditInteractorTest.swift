//
//  ContactAddOrEditInteractorTest.swift
//  Go-Jek
//
//  Created by Satendra Singh on 22/08/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//

import XCTest
@testable import Go_Jek

class ContactAddOrEditInteractorTest: XCTestCase,AddOrEditContactPresenterProtocol {
    var interactor: AddOrEditContactInteractorInputProtocol?
    var router: AddOrEditContactWireframeProtocol?
    
    enum TestCase {
        case noData
        case noNewData
        case update
    }
    
    var testCase: TestCase = .noData
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    var dataChangeResponseReceived=false
    func testSendChangedDataNoNewData() {
        self.testCase = .noData
        let request = AddOrEditContact.SendChangedData.Request.init(firstName: "", lastName: "", email: "", phoneNumber: "")
        let mockInteractor = AddOrEditContactInteractor()
        mockInteractor.presenter = self as? AddOrEditContactInteractorOutputProtocol
        mockInteractor.sendChangedDataIfAny(request: request)
        
        let expectaion = XCTNSPredicateExpectation.init(predicate: NSPredicate.init(format: "dataChangeResponseReceived == true"), object: self)
        let _ = XCTWaiter().wait(for: [expectaion], timeout: 3.0)
    }
    
    func testNoNewData() {
        self.testCase = .noNewData
        let mockContact = ContactDetailResponseDataModel.init(id: 1, firstName: "demo", lastName: "demo", profilePic: "demoUrl", favorite: false, phoneNumber: "demoNumber", email: "demoUrl", createdAt: "", updatedAt: "")
        let request = AddOrEditContact.SendChangedData.Request.init(firstName: "demo", lastName: "demo", email: "demoUrl", phoneNumber: "demoNumber")
        let mockInteractor = AddOrEditContactInteractor()
        mockInteractor.selectedContact = mockContact
        mockInteractor.presenter = self as? AddOrEditContactInteractorOutputProtocol
        mockInteractor.sendChangedDataIfAny(request: request)
        
        let expectaion = XCTNSPredicateExpectation.init(predicate: NSPredicate.init(format: "dataChangeResponseReceived == true"), object: self)
        let _ = XCTWaiter().wait(for: [expectaion], timeout: 3.0)
    }
    
    func testUploadData() {
        self.testCase = .update
        let request = AddOrEditContact.SendChangedData.Request.init(firstName: "demoAutomation", lastName: "demoAutomation", email: "demoAutomation@demoAutomation", phoneNumber: "9999999999")
        let mockInteractor = AddOrEditContactInteractor()
        mockInteractor.presenter = self as? AddOrEditContactInteractorOutputProtocol
        mockInteractor.sendChangedDataIfAny(request: request)
        
        let expectaion = XCTNSPredicateExpectation.init(predicate: NSPredicate.init(format: "dataChangeResponseReceived == true"), object: self)
        let _ = XCTWaiter().wait(for: [expectaion], timeout: 3.0)
    }
    
    func gotContactData(response: AddOrEditContact.GetContactData.Response) {
        
    }
    
    func dataChangeResult(response: AddOrEditContact.SendChangedData.Response) {
        if testCase == .noData {
            let result = response.resultType
            XCTAssertEqual(result, .validationFailure, "validation failure case is not working properly")
        } else if testCase == .noNewData {
            let result = response.resultType
            XCTAssertEqual(result, .noNewData, "no new data case is not working properly")
        } else {
            let result = response.resultType
            if result == .responseFailure || result == .success {
                
            } else {
                XCTFail("server success or error is not handld properly")
            }
        }
        
        dataChangeResponseReceived = true
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func sendChangedDataIfAny(request: AddOrEditContact.SendChangedData.Request) {
        
    }
    
    func getContactData(request: AddOrEditContact.GetContactData.Request) {
        
    }
    
    func routeToBack() {
        
    }
    
    func routeToImagePickerLibrary() {
        
    }
    
    func routeToImagePickerCamera() {
        
    }
    
    func routeToImagePickerOptions() {
        
    }
}
