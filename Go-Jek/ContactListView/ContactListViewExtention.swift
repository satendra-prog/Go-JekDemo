//
//  ContactListViewExtention.swift
//  Go-Jek
//
//  Created by Satendra Singh on 20/08/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//

import UIKit

extension ContactListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if let model = self.viewModel, let arrContacts = model.dictContacts {
            return arrContacts.count
        }
        return 0
}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let model = self.viewModel, let dictContacts = model.dictContacts, let dictMapping = model.dictMapping {
            if let properStringIndex = dictMapping[section] {
                return dictContacts[properStringIndex]?.count ?? 0
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactListCell", for: indexPath) as! ContactListCell
        
        if let model = self.viewModel, let dictContacts = model.dictContacts, let dictMapping = model.dictMapping {
            if let properStringIndex = dictMapping[indexPath.section], let arrModels = dictContacts[properStringIndex] {
                let properModel = arrModels[indexPath.row]
                cell.assignValues(model: properModel)
            }
        }
        
        return cell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if let model = self.viewModel, let dictMapping = model.dictMapping {
            return Array.init(dictMapping.values).sorted()
        }
        return nil
    }
}


extension ContactListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let model = self.viewModel, let dictContacts = model.dictContacts, let dictMapping = model.dictMapping {
            if let properStringIndex = dictMapping[indexPath.section], let arrModels = dictContacts[properStringIndex] {
                let properModel = arrModels[indexPath.row]
                self.presenter?.assignProperContactDetails(id: properModel.id)
                self.presenter?.routeToContactDetails()
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let model = self.viewModel, let dictMapping = model.dictMapping {
            return dictMapping[section]?.uppercased()
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        if let model = self.viewModel, let dictMapping = model.dictMapping {
            for (key, value) in dictMapping {
                if value.lowercased() == title {
                    return key
                }
            }
        }
        return 0
    }
}
