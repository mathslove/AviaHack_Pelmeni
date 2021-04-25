//  
//  HomeViewController.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 24.04.2021.
//

import UIKit
import RxSwift
import RxCocoa
import Firebase

final class HomeViewController: ViewController<HomeView> {

    //MARK: - Properties
    let binder: HomeBinderProtocol
    let filler: HomeFillerProtocol
    let presenter: HomePresenterProtocol
    let router: HomeRouterProtocol
    
    
    //MARK: - Initializer
    init(binder: HomeBinderProtocol, filler: HomeFillerProtocol, presenter: HomePresenterProtocol, router: HomeRouterProtocol) {
        self.binder = binder
        self.filler = filler
        self.presenter = presenter
        self.router = router
        super.init()
        mainView.tableView.dataSource = self
        DatabaseManager.subscribers.append(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        filler.fill()
    }
}

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if DatabaseManager.user.type == "HR" {
            print("SECtiONSECtioN", DatabaseManager.user.hrcvs.count)
            return DatabaseManager.user.hrcvs.count
        } else {
            return DatabaseManager.user.wcvs.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeRegisterCell.cellID) as! HomeRegisterCell
        cell.fill()
        cell.bind()
        cell.title.text = DatabaseManager.user.hrcvs[indexPath.section].title
        cell.viewController = self
        return cell
    }
}

extension HomeViewController: DatabaseManagerProtocol {
    func notified() {
        mainView.fio.text = DatabaseManager.user.surname! + " " + DatabaseManager.user.name! + " " + DatabaseManager.user.middlename!
        
        if DatabaseManager.user.type == "HR" {
            mainView.myCV.text = DatabaseManager.user.hrcvs[0].name
            title = "Мои вакансии"
            mainView.tableView.reloadData()
        } else {
            
        }
    }
}
