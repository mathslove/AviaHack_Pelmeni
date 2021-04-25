//  
//  ResultsAssembly.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 25.04.2021.
//

import UIKit

final class ResultsAssembly {
    class func module() -> ResultsViewController {
        let binder = ResultsBinder()
        let filler = ResultsFiller()
        let presenter = ResultsPresenter()
        let router = ResultsRouter()
        let viewController = ResultsViewController(binder: binder, filler: filler, presenter: presenter, router: router)
        
        filler.view = viewController.mainView
        binder.view = viewController.mainView
        router.viewController = viewController
        binder.router = router
        binder.viewController = viewController
        
        return viewController
    }
}
