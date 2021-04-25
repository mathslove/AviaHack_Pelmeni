//  
//  RegistrationView.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 23.04.2021.
//

import UIKit

final class RegistrationView: MainView {
    
    // MARK: - Views
    let signUpButton = Button(title: .signUp, titleColor: .white, backgroundColor: .blue)
    let signInButton = Button(title: .signIn, titleColor: .blue, backgroundColor: .clear)
    
    let copyright: UILabel = {
        let label = UILabel()
        label.text = "© Pelmeni 2021"
        label.textColor = .blue
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    let iconView: UIImageView = {
        let imageView = UIImageView(image: .icon)
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        return label
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
        tableView.register(RegistrationTableViewCellWithtextField.self, forCellReuseIdentifier: RegistrationTableViewCellWithtextField.cellID)
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    // MARK: - Lefecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.snp.updateConstraints { (make) in
            make.height.equalTo(tableView.contentSize.height)
        }
    }
}
