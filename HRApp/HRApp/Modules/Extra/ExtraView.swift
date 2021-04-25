//  
//  ExtraView.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 24.04.2021.
//

import UIKit
import AloeStackView

final class ExtraView: MainView {

    //MARK: - Views
    let aloeStackView: AloeStackView = {
        let aloeStackView = AloeStackView()
        aloeStackView.hidesSeparatorsByDefault = true
        aloeStackView.backgroundColor = .clear
        return aloeStackView
    }()
    
    let avatar: UIImageView = {
        let imageView = UIImageView(image: .avatar)
        imageView.tintColor = .blue
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = UIScreen.main.bounds.width / 6
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.2
        imageView.layer.shadowOffset = CGSize.zero
        imageView.layer.shadowRadius = 5
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .clear
        tableView.layer.shadowColor = UIColor.black.cgColor
        tableView.layer.shadowOpacity = 0.2
        tableView.layer.shadowOffset = CGSize.zero
        tableView.layer.shadowRadius = 5
        tableView.clipsToBounds = false
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.isScrollEnabled = false
        tableView.backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        tableView.register(RegistrationTableViewCellWithtextField.self, forCellReuseIdentifier: RegistrationTableViewCellWithtextField.cellID)
        tableView.register(ExtraCellWithArrayOfStrings.self, forCellReuseIdentifier: ExtraCellWithArrayOfStrings.cellID)
        return tableView
    }()
    
//    let loadFromPDFButton = Button(title: .loadpdf, titleColor: .white, backgroundColor: .blue)
    
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
    
    // MARK: - View Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.snp.updateConstraints { (make) in
            make.height.equalTo(tableView.contentSize.height)
        }
    }
}
