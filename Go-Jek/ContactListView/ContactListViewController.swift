//
//  ContactListViewController.swift
//  Go-Jek
//
//  Created by Satendra Singh on 20/08/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//


import UIKit

class ContactListViewController: UIViewController,ContactListViewProtocol {

    var presenter: ContactListPresenterProtocol?
    var viewModel: ContactsList.FetchContacts.ViewModel?
    @IBOutlet weak var contactListTable: UITableView!
    var hasDataChanged = false



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
        
        self.fetchContacts()
        self.initialUISetting()
    }
    
override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if self.hasDataChanged == true {
        self.fetchContacts()
        self.hasDataChanged = false
    }
    self.initSettings()
}
    
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = ContactListInteractor()
        let router = ContactListRouter()
        let presenter = ContactListPresenter(interface: viewController, interactor: interactor, router: router)
        viewController.presenter = presenter
        router.viewController = viewController
        interactor.presenter = presenter
         router.dataStore = interactor
    }
    
    func initSettings() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(dataChanged(notification:)), name: NSNotification.Name(rawValue: Constants.dataChangeNotificationName), object: nil)
    }
    
    func initialUISetting() {
        self.contactListTable.estimatedRowHeight = 60.0
        self.contactListTable.rowHeight = UITableView.automaticDimension
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    
    func fetchContacts() {
        Utility.showLoading(toView: self.view)
        self.presenter?.fetchContacts()
    }
    
    // MARK: ContactListViewProtocol functions
    func didFetchContacts(viewModel: ContactsList.FetchContacts.ViewModel) {
        
        print(viewModel)
                self.viewModel = viewModel
        Utility.removeSpinner(toView: self.view)

                self.contactListTable.reloadData()
    }
    
    // MARK: - Action
    @IBAction func addContactPressed(_ sender: UIBarButtonItem) {
        self.presenter?.routeToAddContact()
    }
    
    @IBAction func groupsPressed(_ sender: UIBarButtonItem) {
    }
    
    // MARK: observer
    @objc func dataChanged(notification: Notification) {
        self.hasDataChanged = true
}
}

