//  
//  ExtraAssembly.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 24.04.2021.
//

import UIKit

final class ExtraAssembly {
    class func module(type: ExtraScreenType) -> ExtraViewController {
        let binder = ExtraBinder()
        let filler = ExtraFiller()
        let presenter = ExtraPresenter()
        let router = ExtraRouter()
        let viewController = ExtraViewController(binder: binder, filler: filler, presenter: presenter, router: router, type: type)
        
        filler.view = viewController.mainView
        binder.view = viewController.mainView
        binder.viewController = viewController
        binder.router = router
        router.viewController = viewController
        filler.viewController = viewController
        
        return viewController
    }
}
