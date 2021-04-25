//  
//  TagsAssembly.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 24.04.2021.
//

import UIKit

final class TagsAssembly {
    class func module() -> TagsViewController {
        let binder = TagsBinder()
        let filler = TagsFiller()
        let presenter = TagsPresenter()
        let router = TagsRouter()
        let viewController = TagsViewController(binder: binder, filler: filler, presenter: presenter, router: router)
        
        filler.view = viewController.mainView
        binder.view = viewController.mainView
        binder.viewController = viewController
        
        return viewController
    }
}
