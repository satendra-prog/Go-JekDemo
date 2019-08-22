//
//  AddOrEditContactViewExtention.swift
//  Go-Jek
//
//  Created by Satendra Singh on 22/08/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//

import UIKit

    extension AddOrEditContactViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if let _ = self.viewModel {
                return 4
            }
            return 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddOrEditContactCell") as! AddOrEditContactCell
            self.assignCell(cell: cell, indexPath: indexPath)
            return cell
        }
        
        fileprivate func assignCell (cell: AddOrEditContactCell, indexPath: IndexPath) {
            if let viewModel = self.viewModel, let contactData = viewModel.selectedContact {
                let index = indexPath.row
                if let valueType = DataRowMapping.giveEnumType(index: index) {
                    let infoType = contactData.returnProperDataType(index: valueType)
                    let infoData = contactData.returnProperValue(index: valueType)
                    let placeholer = contactData.returnProperPlaceholderType(index: valueType)
                    cell.assignValue(infoType: infoType, placeholder: placeholer, value: infoData, infoTypeEnum: valueType, delegate: self)
                }
            }
        }
    }
    
    extension AddOrEditContactViewController: TextChangedDelegate {
        func textChanged(type: DataRowMapping, newText: String) {
            switch type {
            case .firstName:
                self.userEditableData.firstName = newText
            case .lastName:
                self.userEditableData.lastName = newText
            case .email:
                self.userEditableData.email = newText
            case .mobile:
                self.userEditableData.phoneNumber = newText
            }
        }
    }
    
    extension AddOrEditContactViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        func showImagePickerAlert() {
            self.presenter?.routeToImagePickerOptions()
        }
        
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let selectedImage = info[.originalImage] as? UIImage else {
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
            }
            self.imgProfile.image = selectedImage
            picker.dismiss(animated: true, completion: nil)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            print("cancelled")
            picker.dismiss(animated: true, completion: nil)
        }
    }
