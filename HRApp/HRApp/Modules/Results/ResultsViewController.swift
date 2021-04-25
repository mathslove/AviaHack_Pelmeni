//  
//  ResultsViewController.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 25.04.2021.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftyJSON
import FirebaseAuth

final class ResultsViewController: ViewController<ResultsView> {

    //MARK: - Properties
    let binder: ResultsBinderProtocol
    let filler: ResultsFillerProtocol
    let presenter: ResultsPresenterProtocol
    let router: ResultsRouterProtocol
    
    var users = [WCV]()
    var usersTotalRank = [Int]()
    
    var uid = ""
    
    //MARK: - Initializer
    init(binder: ResultsBinderProtocol,
         filler: ResultsFillerProtocol,
         presenter: ResultsPresenterProtocol,
         router: ResultsRouterProtocol) {
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
        print("auid", Auth.auth().currentUser!.uid)
        let auid = Auth.auth().currentUser!.uid
        DatabaseManager
            .firestore
            .collection(DatabasePaths.users)
            .document(auid)
            .getDocument(completion: { [self] (snap, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    let uid = JSON(snap!.get("id")!).stringValue
                    self.uid = uid
                    usersTotalRank.append(JSON(snap!.get("total_res")!).intValue)
                    
                    DatabaseManager
                        .firestore
                        .collection(DatabasePaths.users)
                        .document(uid)
                        .getDocument { (snapp, error) in
                            usersTotalRank.append(JSON(snapp!.get("total_res")!).intValue)
                            print(usersTotalRank)
                            self.mainView.tableView.reloadData()
                        }
                }
            })
        
        DatabaseManager.notify()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        filler.fill()
        binder.bind()
        title = "Результаты"
    }
}

extension ResultsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultsCell.cellID) as! ResultsCell
        cell.fill()
        cell.textLabel?.text = "\(indexPath.section + 1). \(users[indexPath.section].name!)"
        cell.percentage.text = "\(usersTotalRank.reversed()[safe: indexPath.section] ?? -1)%"
        cell.detailTextLabel?.text = "\(users[indexPath.section].title!)"
        return cell
    }
}

extension ResultsViewController: DatabaseManagerProtocol {
    func notified() {
        DatabaseManager.firestore.collection(DatabasePaths.users).document(DatabasePaths.user1).getDocument { (snapshot, error) in
            let json = JSON(JSON(snapshot!.data()!).rawValue)
            self.users.append(DatabaseManager.jsonToWCV(json: json))
            print(self.users)
            self.mainView.tableView.reloadData()
        }
        DatabaseManager.firestore.collection(DatabasePaths.users).document(DatabasePaths.user2).getDocument { (snapshot, error) in
            let json = JSON(JSON(snapshot!.data()!).rawValue)
            print(json)
            self.users.append(DatabaseManager.jsonToWCV(json: json))
            
        }
    }
}
