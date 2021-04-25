//
//  RegistrationTableViewCellWithtextField.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 24.04.2021.
//

import UIKit
import RxSwift
import RxCocoa

final class RegistrationTableViewCellWithtextField: UITableViewCell {
    
    // MARK: - Properties
    static let cellID = "registrationTextFieldTableCell"
    
    // MARK: - Views
    let textField = TextField()
    
    var bag = DisposeBag()
    
    // MARK: - Methods
    func fill() {
        contentView.addSubview(textField)
        
        textField.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview().inset(12)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textField.text = ""
        bag = DisposeBag()
    }
}
