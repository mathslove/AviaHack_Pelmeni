//  
//  TagsViewController.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 24.04.2021.
//

import UIKit
import RxSwift
import RxCocoa

final class TagsViewController: ViewController<TagsView> {

    //MARK: - Properties
    let binder: TagsBinderProtocol
    let filler: TagsFillerProtocol
    let presenter: TagsPresenterProtocol
    let router: TagsRouterProtocol
    
    
    //MARK: - Initializer
    init(binder: TagsBinderProtocol, filler: TagsFillerProtocol, presenter: TagsPresenterProtocol, router: TagsRouterProtocol) {
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        filler.fill()
        binder.bind()
        title = .tags
        
        if let tags = LocalbaseManager.tags.value {
            tags.forEach {
                mainView.tagsField.addTag($0)
            }
        }
        
        navigationItem.leftBarButtonItem = mainView.cancel
    }
}
