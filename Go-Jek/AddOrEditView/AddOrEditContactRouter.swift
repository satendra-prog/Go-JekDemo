//
//  AddOrEditContactRouter.swift
//  Go-Jek
//
//  Created by Satendra Singh on 22/08/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//
import UIKit

class AddOrEditContactRouter: AddOrEditContactWireframeProtocol {

    weak var viewController: AddOrEditContactViewController?
    var dataStore: AddOrEditContactDataStore?


    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = AddOrEditContactViewController(nibName: nil, bundle: nil)
        let interactor = AddOrEditContactInteractor()
        let router = AddOrEditContactRouter()
        let presenter = AddOrEditContactPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
    
    
    func routeToBack() {
        self.viewController?.dismiss(animated: true, completion: nil)
    }
    
    func routeToImagePickerOptions() {
        let alertController = UIAlertController.init(title: "Chose Option", message: "", preferredStyle: .actionSheet)
        let photoLibraryAction = UIAlertAction.init(title: "Photo Library", style: .default) { [weak self] action in
            guard let strongSelf = self else {
                return
            }
            strongSelf.routeToImagePickerLibrary()
        }
        let cameraAction = UIAlertAction.init(title: "Camera", style: .default) { [weak self] action in
            guard let strongSelf = self else {
                return
            }
            strongSelf.routeToImagePickerCamera()
        }
        let cancelAction = UIAlertAction.init(title: "Camera", style: .cancel) { action in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cameraAction)
        alertController.addAction(cancelAction)
        self.viewController?.present(alertController, animated: true, completion: nil)
    }
    
    func routeToImagePickerLibrary() {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.delegate = self.viewController
        imagePickerVC.sourceType = .photoLibrary
        self.viewController?.present(imagePickerVC, animated: true, completion: nil)
    }
    
    func routeToImagePickerCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePickerVC = UIImagePickerController()
            imagePickerVC.delegate = self.viewController
            imagePickerVC.sourceType = .camera
            self.viewController?.present(imagePickerVC, animated: true, completion: nil)
        }
    }

}
