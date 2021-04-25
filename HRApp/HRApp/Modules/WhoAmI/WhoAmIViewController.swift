//  
//  WhoAmIViewController.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 24.04.2021.
//

import UIKit
import RxSwift
import RxCocoa

final class WhoAmIViewController: ViewController<WhoAmIView> {

    //MARK: - Properties
    let binder: WhoAmIBinderProtocol
    let filler: WhoAmIFillerProtocol
    let presenter: WhoAmIPresenterProtocol
    let router: WhoAmIRouterProtocol
    
    
    //MARK: - Initializer
    init(binder: WhoAmIBinderProtocol, filler: WhoAmIFillerProtocol, presenter: WhoAmIPresenterProtocol, router: WhoAmIRouterProtocol) {
        self.binder = binder
        self.filler = filler
        self.presenter = presenter
        self.router = router
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = .extraInformation
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        filler.fill()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        if DatabaseManager.user.screen == DatabasePaths.whoami {
//            DatabaseManager.deleteUser()
//        }
    }
}
