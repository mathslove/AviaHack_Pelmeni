//  
//  DetailAssembly.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 24.04.2021.
//

import UIKit

final class DetailAssembly {
    class func module(type: ExtraField, title: String) -> DetailViewController {
        let binder = DetailBinder()
        let filler = DetailFiller()
        let presenter = DetailPresenter()
        let router = DetailRouter()
        let viewController = DetailViewController(binder: binder,
                                                  filler: filler,
                                                  presenter: presenter,
                                                  router: router,
                                                  type: type,
                                                  title: title)
        
        filler.view = viewController.mainView
        binder.viewController = viewController
        binder.view = viewController.mainView
        
        return viewController
    }
}
