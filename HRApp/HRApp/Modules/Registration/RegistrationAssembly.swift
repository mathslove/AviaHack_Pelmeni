//  
//  RegistrationAssembly.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 23.04.2021.
//

import UIKit

final class RegistrationAssembly {
    class func module() -> RegistrationViewController {
        let binder = RegistrationBinder()
        let filler = RegistrationFiller()
        let presenter = RegistrationPresenter()
        let router = RegistrationRouter()
        let viewController = RegistrationViewController(binder: binder,
                                                        filler: filler,
                                                        presenter: presenter,
                                                        router: router)
        
        filler.view = viewController.mainView
        binder.view = viewController.mainView
        binder.router = router
        router.viewController = viewController
        
        return viewController
    }
}
