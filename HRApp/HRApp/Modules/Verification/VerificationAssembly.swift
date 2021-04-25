//  
//  VerificationAssembly.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 24.04.2021.
//

import UIKit

final class VerificationAssembly {
    class func module() -> VerificationViewController {
        let binder = VerificationBinder()
        let filler = VerificationFiller()
        let presenter = VerificationPresenter()
        let router = VerificationRouter()
        let viewController = VerificationViewController(binder: binder,
                                                        filler: filler,
                                                        presenter: presenter,
                                                        router: router)
        
        binder.viewController = viewController
        filler.view = viewController.mainView
        router.viewController = viewController
        
        return viewController
    }
}
