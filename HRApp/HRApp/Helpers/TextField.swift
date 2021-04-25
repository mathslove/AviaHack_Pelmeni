//
//  TextField.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 24.04.2021.
//

import UIKit
import RxSwift
import RxCocoa

final class TextField: UITextField {
    
    // MARK: - Properties
    override var isSecureTextEntry: Bool {
        didSet {
            if isSecureTextEntry {
                if !eyeButton.isDescendant(of: self) {
                    addSubview(eyeButton)
                    
                    eyeButton.snp.makeConstraints { (make) in
                        make.height.width.equalTo(28)
                        make.right.equalToSuperview()
                        make.centerY.equalToSuperview()
                    }
                    
                    let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
                    rightView.isUserInteractionEnabled = false
                    self.rightView = rightView
                    rightViewMode = .always
                    bind()
                }
            }
        }
    }
    
    let isOn = BehaviorRelay<Bool>(value: false)
    
    private let bag = DisposeBag()
    
    // MARK: - Views
    private let eyeButton: UIButton = {
        let button = UIButton()
        button.tintColor = .blue
        return button
    }()
    
    // MARK: - Methods
    func bind() {
        bindTapAtEyeButton()
        bindIsOn()
        bindText()
    }
    
    private func bindTapAtEyeButton() {
        eyeButton.rx.tap.bind { [self] _ in
            isOn.accept(!isOn.value)
        }.disposed(by: bag)
    }
    
    private func bindIsOn() {
        isOn.bind { [self] isOn in
            eyeButton.setImage(isOn ? .eyeFill : .eye, for: .normal)
            isSecureTextEntry = !isOn
        }.disposed(by: bag)
    }
    
    private func bindText() {
        rx.text.orEmpty.bind { [self] text in
            eyeButton.isHidden = text.count == 0
        }.disposed(by: bag)
    }
}
