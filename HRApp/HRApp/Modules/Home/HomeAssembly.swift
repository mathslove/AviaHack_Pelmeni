//  
//  HomeAssembly.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 24.04.2021.
//

import UIKit

final class HomeAssembly {
    class func module() -> HomeViewController {
        let binder = HomeBinder()
        let filler = HomeFiller()
        let presenter = HomePresenter()
        let router = HomeRouter()
        let viewController = HomeViewController(binder: binder, filler: filler, presenter: presenter, router: router)
        
        filler.view = viewController.mainView
        router.viewController = viewController
        
        return viewController
    }
}
