//  
//  HomeView.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 24.04.2021.
//

import UIKit

final class HomeView: MainView {

    //MARK: - Views
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
    
    let fio: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    let myCV: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(HomeRegisterCell.self, forCellReuseIdentifier: HomeRegisterCell.cellID)
        tableView.backgroundColor = .clear
        tableView.canCancelContentTouches = false
        tableView.rowHeight = 100
        tableView.layer.shadowColor = UIColor.black.cgColor
        tableView.layer.shadowOpacity = 0.2
        tableView.layer.shadowOffset = CGSize.zero
        tableView.layer.shadowRadius = 5
        tableView.isScrollEnabled = false
        return tableView
    }()
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        tableView.snp.updateConstraints { (make) in
//            make.height.equalTo(tableView.contentSize.height)
//        }
//    }
}
