//
//  ContactDetailViewController.swift
//  Go-Jek
//
//  Created by Satendra Singh on 21/08/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController,ContactDetailViewProtocol {

    var presenter: ContactDetailPresenterProtocol?
    var viewModel: ContactDetails.FetchContactDetails.ViewModel?
    
    @IBOutlet weak var viewGradient: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgProfilePicture: UIImageView!
    @IBOutlet weak var tblContactDetails: UITableView!
    @IBOutlet weak var btnFavorite: UIButton!

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
         self.fetchContactDetails()
         self.initialSettings()

    }
    
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = ContactDetailInteractor()
        let router = ContactDetailRouter()
        let presenter = ContactDetailPresenter(interface: viewController, interactor: interactor, router: router)
        viewController.presenter = presenter
        router.viewController = viewController
        interactor.presenter = presenter
        router.dataStore = interactor
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.initialUISetting()
    }
    
    func initialSettings() {
        self.tblContactDetails.tableFooterView = UIView()
    }
    
    func initialUISetting() {
        self.imgProfilePicture.layer.cornerRadius = self.imgProfilePicture.frame.width/2
        self.imgProfilePicture.layer.masksToBounds = true
        self.setGradient()
        self.addEditNavButton()
        self.changeFavButtonImage()
    }
    
    fileprivate func setGradient() {
        let gradientLayer = CAGradientLayer.init()
        gradientLayer.colors = [UIColor.white.cgColor, Constants.lightGreen.cgColor]
        gradientLayer.startPoint = CGPoint.init(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 0.5, y: 1)
        gradientLayer.frame = self.viewGradient.bounds
        self.viewGradient.layer.insertSublayer(gradientLayer, below: self.imgProfilePicture.layer)
    }
    fileprivate func addEditNavButton() {
        let barButton = UIBarButtonItem.init(title: "Edit", style: .plain, target: self, action: #selector(moveToEdit))
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    
    func fetchContactDetails() {
        let request = ContactDetails.FetchContactDetails.Request.init()
        self.presenter?.getContactDetails(request: request)
    }
    
    
    // MARK: Do something
    func didFetchContactDetails(viewModel: ContactDetails.FetchContactDetails.ViewModel) {
        self.viewModel = viewModel
        self.assignGradientViewValues()
        if let viewModel = self.viewModel, let contactDetails = viewModel.contactDetails {
            self.imgProfilePicture.sd_setImage(with: URL.init(string: contactDetails.imageUrl), placeholderImage: UIImage.init(named: "placeholder_photo"))
        }
        self.tblContactDetails.reloadData()
    }
    
    func didGetFavoriteToggledResult(viewModel: ContactDetails.FavouriteToggled.ViewModel) {
        switch viewModel.resultType {
        case .success:
            if let viewModel = self.viewModel, var contactDetails = viewModel.contactDetails {
                self.viewModel?.contactDetails?.isFavorite = !contactDetails.isFavorite
                self.changeFavButtonImage()
            }
            NotificationCenter.default.post(name: Notification.Name.init(Constants.dataChangeNotificationName), object: nil)
            self.showSingleActionAlertMessage(message: viewModel.message, handler: nil)
        case .failure:
            self.showSingleActionAlertMessage(message: viewModel.message, handler: nil)
        }
        Utility.removeSpinner(toView: self.view)
    }
    
    func didGetDeleteToggledResult(viewModel: ContactDetails.DeleteToggled.ViewModel){
        switch viewModel.resultType {
        case .success:
            NotificationCenter.default.post(name: Notification.Name.init(Constants.dataChangeNotificationName), object: nil)
            self.showSingleActionAlertMessage(message: viewModel.message) { [weak self] in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.presenter?.routeToBack()
            }
        case .failure:
            self.showSingleActionAlertMessage(message: viewModel.message, handler: nil)
        }
        Utility.removeSpinner(toView: self.view)
    }

    
    
    fileprivate func changeFavButtonImage() {
        if let viewModel = self.viewModel, let contactDetails = viewModel.contactDetails {
            let imageString = contactDetails.isFavorite == true ? "favourite_button_selected" : "favourite_button"
            let image = UIImage.init(named: imageString)
            self.btnFavorite.setImage(image, for: .normal)
        }
    }
    
    fileprivate func assignGradientViewValues() {
        if let viewModel = viewModel, let contactDetails = viewModel.contactDetails {
            self.lblName.text = contactDetails.name
        }
    }
    
    // MARK : - ibactions
    
    @IBAction func messagePressed(_ sender: UIButton) {
        self.presenter?.routeToMessages()
    }
    
    @IBAction func callPressed(_ sender: UIButton) {
        self.presenter?.routeToPhone()
    }
    
    @IBAction func emailPressed(_ sender: UIButton) {
        self.presenter?.routeToMail()
    }
    
    @IBAction func favouritePressed(_ sender: UIButton) {
       Utility.showLoading(toView: self.view)
        if let viewModel = self.viewModel, let contactDetails = viewModel.contactDetails {
            let request = ContactDetails.FavouriteToggled.Request.init(favoriteState: contactDetails.isFavorite)
            self.presenter?.favouriteToggled(request: request)
        }
    }
    @IBAction func deletePressed(_ sender: UIButton) {
            self.presenter?.deleteContact()
    }
    
    // MARK : - move to other screens
    @objc func moveToEdit() {
        self.presenter?.routeToEdit()
    }

}


