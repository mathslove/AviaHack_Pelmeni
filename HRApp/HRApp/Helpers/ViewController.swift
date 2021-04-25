//
//  ViewController.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 23.04.2021.
//

import Foundation

import UIKit

class ViewController<View: MainView>: UIViewController {
    
    // MARK: - Views
    private(set) lazy var mainView = View()
    
    // MARK: - Initializer
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Storyboards are bad :(")
    }
    
    // MARK: - View Lifecycle
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.viewController = self
        mainView.fill()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.viewController = self
        mainView.fill()
    }
}

