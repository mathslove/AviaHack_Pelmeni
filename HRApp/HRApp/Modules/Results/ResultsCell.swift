//
//  ResultsCell.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 25.04.2021.
//

import UIKit

final class ResultsCell: UITableViewCell {
    
    static let cellID = "RrsultsCellID"
    
    let separator: UIView = {
        let separator = UIView()
        separator.backgroundColor = .blue
        return separator
    }()
    let percentage: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = .boldSystemFont(ofSize: 28)
        return label
    }()
    let name: UILabel = {
        let name = UILabel()
        name.textColor = .blue
        name.font = .preferredFont(forTextStyle: .headline)
        return name
    }()
    let resume: UILabel = {
        let name = UILabel()
        name.textColor = .blue
        return name
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill() {
        addSubviews([name, resume, separator, percentage])
        textLabel?.numberOfLines = 0
        textLabel?.textColor = .blue
        textLabel?.font = .preferredFont(forTextStyle: .headline)
        
        textLabel?.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(12)
            make.right.equalTo(separator).inset(8)
        }
        
        detailTextLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(textLabel!).inset(12)
            make.bottom.equalToSuperview().inset(6)
        })
        
        resume.snp.makeConstraints { (make) in
            make.top.equalTo(name.snp.bottom).inset(-4)
            make.left.equalTo(name).inset(10)
        }
        
        separator.snp.makeConstraints { (make) in
            make.width.equalTo(0.5)
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().inset(UIScreen.main.bounds.width / 4)
        }
        
        percentage.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(UIScreen.main.bounds.width / 22)
        }
    }
}
