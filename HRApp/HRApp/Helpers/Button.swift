//
//  Button.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 24.04.2021.
//

import UIKit

final class Button: UIButton {
    
    // MARK: - Properties
    let background: UIColor!
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? background.lighter(by: 0.1) : background
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? background : .systemGray
        }
    }
    
    // MARK: - Initializer
    init(title: String, titleColor: UIColor, backgroundColor: UIColor) {
        background = backgroundColor
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        titleLabel?.font = .preferredFont(forTextStyle: .headline)
        setTitleColor(titleColor, for: .normal)
        setTitleColor(titleColor.lighter(by: 0.1), for: .highlighted)
        self.backgroundColor = backgroundColor
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
