//
//  EndPoints.swift
//  Go-Jek
//
//  Created by Satendra Singh on 20/08/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//

import Foundation

let kAllContacts = "contacts"
let kDefaultApiExtention = ".json"

enum EndPoint {
    case getAllContacts
    case getContactById(Id: Int)
    case getContactDetailWithContactId(contactId: Int)
    case deleteContactWithContactId(contactId: Int)
    case updateContactDetailWithContactId(contactId: Int)
    
    var path: String {
        switch self {
            
        case .getAllContacts:
            return "\(Domain.baseUrl())/\(kAllContacts)\(kDefaultApiExtention)"
            
        case .getContactById(let contactId),.getContactDetailWithContactId(let contactId),.updateContactDetailWithContactId(let contactId),.deleteContactWithContactId(let contactId):
            
            return "\(Domain.baseUrlWithContactsKey())\(contactId)\(kDefaultApiExtention)"
        }
    }
}
