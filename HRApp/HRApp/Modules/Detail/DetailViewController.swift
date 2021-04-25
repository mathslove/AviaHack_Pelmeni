//  
//  DetailViewController.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 24.04.2021.
//

import UIKit
import RxSwift
import RxCocoa

final class DetailViewController: ViewController<DetailView> {

    //MARK: - Properties
    let binder: DetailBinderProtocol
    let filler: DetailFillerProtocol
    let presenter: DetailPresenterProtocol
    let router: DetailRouterProtocol
    
    let type: ExtraField
    let topTitle: String
    
    //MARK: - Initializer
    init(binder: DetailBinderProtocol,
         filler: DetailFillerProtocol,
         presenter: DetailPresenterProtocol,
         router: DetailRouterProtocol,
         type: ExtraField,
         title: String) {
        self.type = type
        topTitle = title
        self.binder = binder
        self.filler = filler
        self.presenter = presenter
        self.router = router
        super.init()
        
        mainView.textView.delegate = self
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
        title = topTitle
        navigationItem.leftBarButtonItem = mainView.cancel
        
        switch type {
        case .many(_, _, _):
            navigationItem.rightBarButtonItem = mainView.editButton
        default: break
        }
        
        filler.fill(type: type)
        binder.bind()
    }
}

extension DetailViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        return numberOfChars < 300
    }
}
