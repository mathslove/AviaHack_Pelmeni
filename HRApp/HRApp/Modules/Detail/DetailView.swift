//  
//  DetailView.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 24.04.2021.
//

import UIKit
import SwiftyMenu

final class DetailView: MainView {

    //MARK: - Views
    let textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.font = .preferredFont(forTextStyle: .headline)
        textView.textColor = .blue
        textView.layer.cornerRadius = 12
        textView.layer.shadowColor = UIColor.black.cgColor
        textView.layer.shadowOpacity = 0.2
        textView.layer.shadowOffset = CGSize.zero
        textView.layer.shadowRadius = 5
        textView.clipsToBounds = false
        textView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return textView
    }()
    let swiftyMenu: SwiftyMenu = {
        let menu = SwiftyMenu()
        menu.layer.cornerRadius = 12
        return menu
    }()
    let shadowView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(1)
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.2
        return view
    }()
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundView = UIView()
        tableView.layer.shadowColor = UIColor.black.cgColor
        tableView.layer.shadowOffset = .zero
        tableView.layer.shadowRadius = 5
        tableView.layer.shadowOpacity = 0.2
        tableView.backgroundColor = .clear
        tableView.register(RegistrationTableViewCellWithtextField.self, forCellReuseIdentifier: RegistrationTableViewCellWithtextField.cellID)
        return tableView
    }()
    let editButton = UIBarButtonItem(barButtonSystemItem: .compose, target: nil, action: nil)
    let saveButton = Button(title: .save, titleColor: .white, backgroundColor: .blue)
    let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
}
