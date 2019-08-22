//
//  AddOrEditContactViewController.swift
//  Go-Jek
//
//  Created by Satendra Singh on 22/08/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//
import UIKit

class AddOrEditContactViewController: UIViewController,AddOrEditContactViewProtocol {

    var presenter: AddOrEditContactPresenterProtocol?

    @IBOutlet weak var tblContactDetails: UITableView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var viewGradient: UIView!
    
    var viewModel: AddOrEditContact.GetContactData.ViewModel?
    var userEditableData: UserEditableData = UserEditableData()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = AddOrEditContactInteractor()
        let router = AddOrEditContactRouter()
        let presenter = AddOrEditContactPresenter(interface: viewController, interactor: interactor, router: router)
        viewController.presenter = presenter
        router.viewController = viewController
        interactor.presenter = presenter
        router.dataStore = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSettings()
        self.fetchSelectedContact()
    }

    func fetchSelectedContact() {
        let request = AddOrEditContact.GetContactData.Request()
        self.presenter?.getContactData(request: request)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setGradient()
    }
    
    fileprivate func initialSettings() {
        self.imgProfile.layer.cornerRadius = self.imgProfile.frame.width/2
        self.imgProfile.layer.masksToBounds = true
        self.tblContactDetails.tableFooterView = UIView()
        self.tblContactDetails.estimatedRowHeight = 50.0
        self.tblContactDetails.rowHeight = UITableView.automaticDimension
    }

    fileprivate func setGradient() {
        let gradientLayer = CAGradientLayer.init()
        gradientLayer.colors = [UIColor.white.cgColor, Constants.lightGreen.cgColor]
        gradientLayer.startPoint = CGPoint.init(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 0.5, y: 1)
        gradientLayer.frame = self.viewGradient.bounds
        self.viewGradient.layer.insertSublayer(gradientLayer, below: self.imgProfile.layer)
    }
    
    
    func gotContactData(viewModel: AddOrEditContact.GetContactData.ViewModel) {
        self.viewModel = viewModel
        if let viewModel = self.viewModel, let contactDetails = viewModel.selectedContact {
            self.imgProfile.sd_setImage(with: URL.init(string: contactDetails.imageUrl), placeholderImage: UIImage.init(named: "placeholder_photo"))
        }
        Utility.removeSpinner(toView: self.view)
        
        self.userEditableData.firstName = viewModel.selectedContact?.firstName ?? ""
               self.userEditableData.lastName = viewModel.selectedContact?.lastName ?? ""
                self.userEditableData.email = viewModel.selectedContact?.email ?? ""
                self.userEditableData.phoneNumber = viewModel.selectedContact?.phoneNumber ?? ""
        
        
        self.tblContactDetails.reloadData()
    }
    
    func gotChangingDataResults(viewModel: AddOrEditContact.SendChangedData.ViewModel) {
        if viewModel.resultType == .success {
            NotificationCenter.default.post(name: Notification.Name.init(Constants.dataChangeNotificationName), object: nil)
            self.showSingleActionAlertMessage(message: viewModel.message) { [weak self] in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.presenter?.routeToBack()
            }
        } else {
            self.showSingleActionAlertMessage(message: viewModel.message, handler: nil)
        }
      Utility.removeSpinner(toView: self.view)
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        self.presenter?.routeToBack()
    }
    
    @IBAction func cameraButtonPressed(_ sender: UIButton) {
        self.showImagePickerAlert()
    }
    
    @IBAction func donePressed(_ sender: UIButton) {
      Utility.showLoading(toView: self.view)
        let request = AddOrEditContact.SendChangedData.Request.init(firstName: self.userEditableData.firstName, lastName: self.userEditableData.lastName, email: self.userEditableData.email, phoneNumber: self.userEditableData.phoneNumber)
        self.presenter?.sendChangedDataIfAny(request: request)
    }
}



