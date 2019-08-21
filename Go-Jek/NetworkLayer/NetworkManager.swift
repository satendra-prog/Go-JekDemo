//
//  NetworkManager.swift
//  Go-Jek
//
//  Created by Satendra Singh on 20/08/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//

import Foundation

class NetworkManager {
    func getAllContacts(completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let urlString = Constants.getAllContactsUrlString
        if let url = URL.init(string: urlString) {
            let request = URLRequest.init(url: url)
            self.commonTask(request: request, completionHandler: completionHandler)
        }
    }
    
    func getContactDetails(urlString: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        if let url = URL.init(string: urlString) {
            let request = URLRequest.init(url: url)
            self.commonTask(request: request, completionHandler: completionHandler)
        }
    }
    
    func postNewContact(data: Data, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let urlString = Constants.postContactsUrlString
        if let url = URL.init(string: urlString) {
            var request = URLRequest.init(url: url)
            request.httpMethod = "POST"
            request.httpBody = data
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            self.commonTask(request: request, completionHandler: completionHandler)
        }
    }
    
    func putNewContact(urlString: String,params: [String: Any]?, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {

        if let url = URL.init(string: urlString) {
            var request = URLRequest.init(url: url)
            if let params = params {
                request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
                request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)
                request.setValue(contentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            }
            request.httpMethod = "PUT"
            self.commonTask(request: request, completionHandler: completionHandler)
        }
    }
    
    
    func deleteContact(urlString: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        if let url = URL.init(string: urlString) {
            var request = URLRequest.init(url: url)
            request.httpMethod = "DELETE"
            self.commonTask(request: request, completionHandler: completionHandler)
        }
    }
    
    //common get task
    func commonTask(request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: request, completionHandler: completionHandler)
        task.resume()
    }
}
