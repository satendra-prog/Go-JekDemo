//
//  Domain.swift
//  Go-Jek
//
//  Created by Satendra Singh on 20/08/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//

import Foundation

// MARK:- Create Base URLs
let commonContactString = "/contacts/"

// base url
struct Domain {
    static let dev = "https://gojek-contacts-app.herokuapp.com"
    static let assetUrl = "/images/"
}
// Header's key
enum HTTPHeaderField: String {
    case contentType  = "Content-Type"
}
// Header's Value
enum contentType: String {
    case json = "application/json"
}

// get all combined urls here
extension Domain {
    static func baseUrl()-> String {
        return dev
    }
    static func baseUrlWithContactsKey()-> String {
        return "\(dev)\(commonContactString)"
    }
    
    static func profileUrl()-> String {
        return assetUrl
    }
}
