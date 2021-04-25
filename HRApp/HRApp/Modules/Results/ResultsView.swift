//  
//  ResultsView.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 25.04.2021.
//

import UIKit

final class ResultsView: MainView {

    //MARK: - Views
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .clear
        tableView.layer.shadowColor = UIColor.black.cgColor
        tableView.layer.shadowOpacity = 0.2
        tableView.layer.shadowOffset = CGSize.zero
        tableView.layer.shadowRadius = 5
        tableView.rowHeight = 70
        tableView.sectionFooterHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.register(ResultsCell.self, forCellReuseIdentifier: ResultsCell.cellID)
        return tableView
    }()
    let matched: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.text = "Подходящие резюме"
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    let conformity: UILabel = {
        let label = UILabel()
        label.text = "Соответствие"
        label.textColor = .blue
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        tableView.snp.makeConstraints { (make) in
//            make.height.equalTo(tableView.contentSize.height)
//        }
    }
}
