//
//  MainView.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 23.04.2021.
//

import Foundation

import UIKit

class MainView: UIView {
    
    // MARK: - Properties
    weak var viewController: UIViewController?
    
    // MARK: - Views
    let backgroundView: UIImageView = {
        let imageView = UIImageView(image: .background)
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.5
        return imageView
    }()
    
    // MARK: - Initializer
    required init() {
        super.init(frame: UIScreen.main.bounds)
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func fill() {
        addSubview(backgroundView)
        
        backgroundView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
