//
//  HomeRegisterCell.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 25.04.2021.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeRegisterCell: UITableViewCell {
    
    static let cellID = "HomeResiter"
    
    weak var viewController: HomeViewController?
    
    private let bag = DisposeBag()
    
    let check: UIButton = {
        let button = UIButton()
        button.setTitle("Перейти", for: .normal)
        button.setTitleColor(UIColor.blue.lighter(by: 0.1), for: .normal)
        button.setTitleColor(UIColor.blue.lighter(), for: .highlighted)
        return button
    }()
    
    let search: UIButton = {
        let button = UIButton()
        button.setTitle("Поиск", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.setTitleColor(UIColor.blue.lighter(by: 0.1), for: .highlighted)
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        return button
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    func fill() {
        selectionStyle = .none
        contentView.isHidden = true
        
        addSubviews([check, search, title])
        
        check.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().inset(8)
            make.left.equalToSuperview().inset(30)
        }
        
        search.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().inset(8)
            make.right.equalToSuperview().inset(30)
        }
        
        title.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(14)
            make.centerX.equalToSuperview()
        }
    }
    
    func bind() {
        check.rx.tap.bind { () in
            print("check")
        }.disposed(by: bag)
        
        search.rx.tap.bind { [weak self] _ in
            self?.viewController?.router.showResults()
        }.disposed(by: bag)
    }
}
