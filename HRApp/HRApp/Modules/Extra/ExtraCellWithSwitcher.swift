//
//  ExtraCellWithSwitcher.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 24.04.2021.
//

import UIKit
import RxSwift
import RxCocoa

final class ExtraCellWithSwitcher: UITableViewCell {
    
    // MARK: - Views
    private let switcher = UISwitch()
    private let bag = DisposeBag()
    
    let behaviorRelay = BehaviorRelay<Bool>(value: false)
    
    func fill() {
        switcher.onTintColor = .blue
        
        accessoryView = switcher
        
        switcher.rx.isOn.bind { isOn in
            self.behaviorRelay.accept(isOn)
        }.disposed(by: bag)
    }
}
