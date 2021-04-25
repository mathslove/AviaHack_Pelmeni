//  
//  RegistrationViewController.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 23.04.2021.
//

import UIKit
import RxSwift
import RxCocoa

final class RegistrationViewController: ViewController<RegistrationView> {

    //MARK: - Properties
    let binder: RegistrationBinderProtocol
    let filler: RegistrationFillerProtocol
    let presenter: RegistrationPresenterProtocol
    let router: RegistrationRouterProtocol
    
    //MARK: - Initializer
    init(binder: RegistrationBinderProtocol,
         filler: RegistrationFillerProtocol,
         presenter: RegistrationPresenterProtocol,
         router: RegistrationRouterProtocol) {
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
        binder.bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = .registration
        filler.fill()
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
