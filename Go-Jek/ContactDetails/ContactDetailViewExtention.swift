//
//  ContactDetailViewExtention.swift
//  Go-Jek
//
//  Created by Satendra Singh on 21/08/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//

import UIKit
import MessageUI

    extension ContactDetailViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if let model = self.viewModel, let _ = model.contactDetails {
                return 3
            }
            return 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ContactDetailInfoCell", for: indexPath) as! ContactDetailInfoCell
                if let model = self.viewModel, let contactDetailsModel = model.contactDetails {
                    cell.assignValue(infoType: "mobile", infoDetails: contactDetailsModel.phoneNo)
                }
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ContactDetailInfoCell", for: indexPath) as! ContactDetailInfoCell
                if let model = self.viewModel, let contactDetailsModel = model.contactDetails {
                    cell.assignValue(infoType: "email", infoDetails: contactDetailsModel.email)
                }
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ContactDetailDeleteCell", for: indexPath) as! ContactDetailDeleteCell
                return cell
            default:
                return UITableViewCell()
            }
        }
    }
    
    extension ContactDetailViewController: MFMessageComposeViewControllerDelegate {
        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            switch result {
            case .sent:
                self.showSingleActionAlertMessage(message: "Success", handler: nil)
            case .cancelled:
                self.showSingleActionAlertMessage(message: "You seem to have cancelled the message", handler: nil)
            case .failed:
                self.showSingleActionAlertMessage(message: "Some error occured", handler: nil)
            }
        }
    }
    
    extension ContactDetailViewController: MFMailComposeViewControllerDelegate, UINavigationControllerDelegate {
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            switch result {
            case .sent:
                self.showSingleActionAlertMessage(message: "Success", handler: nil)
            case .cancelled:
                self.showSingleActionAlertMessage(message: "You seem to have cancelled the message", handler: nil)
            case .failed:
                self.showSingleActionAlertMessage(message: "Some error occured", handler: nil)
            case .saved:
                self.showSingleActionAlertMessage(message: "Your message has been saved", handler: nil)
            }
        }
}

