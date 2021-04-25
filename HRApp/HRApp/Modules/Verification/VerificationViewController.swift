//  
//  VerificationViewController.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 24.04.2021.
//

import UIKit
import RxSwift
import RxCocoa
import FirebaseFirestore
import FirebaseAuth

final class VerificationViewController: ViewController<VerificationView> {

    //MARK: - Properties
    let binder: VerificationBinderProtocol
    let filler: VerificationFillerProtocol
    let presenter: VerificationPresenterProtocol
    let router: VerificationRouterProtocol
    
    //MARK: - Initializer
    init(binder: VerificationBinderProtocol,
         filler: VerificationFillerProtocol,
         presenter: VerificationPresenterProtocol,
         router: VerificationRouterProtocol) {
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
        title = .emailConfirmation
        mainView.emailSendedLabel.text! += Auth.auth().currentUser!.email!
        filler.fill()
        binder.bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Auth.auth().currentUser!.sendEmailVerification { (error) in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        binder.forceDeinit()
        if Auth.auth().currentUser?.isEmailVerified != true {
            DatabaseManager.deleteUser()
        }
    }
}
