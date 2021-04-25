//  
//  WhoAmIAssembly.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 24.04.2021.
//

import UIKit

final class WhoAmIAssembly {
    class func module() -> WhoAmIViewController {
        let binder = WhoAmIBinder()
        let filler = WhoAmIFiller()
        let presenter = WhoAmIPresenter()
        let router = WhoAmIRouter()
        let viewController = WhoAmIViewController(binder: binder, filler: filler, presenter: presenter, router: router)
        
        filler.view = viewController.mainView
        binder.view = viewController.mainView
        
        return viewController
    }
}
