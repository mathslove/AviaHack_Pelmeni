//  
//  DetailUserAssembly.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 25.04.2021.
//

import UIKit

final class DetailUserAssembly {
    class func module(uid: String) -> DetailUserViewController {
        let binder = DetailUserBinder()
        let filler = DetailUserFiller()
        let presenter = DetailUserPresenter()
        let router = DetailUserRouter()
        let viewController = DetailUserViewController(binder: binder,
                                                      filler: filler,
                                                      presenter: presenter,
                                                      router: router,
                                                      uid: uid)
        
        presenter.viewController = viewController
        filler.view = viewController.mainView
        
        return viewController
    }
}
