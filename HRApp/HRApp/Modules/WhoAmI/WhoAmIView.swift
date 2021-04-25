//  
//  WhoAmIView.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 24.04.2021.
//

import UIKit

final class WhoAmIView: MainView {

    //MARK: - Views
    let iSeachFor: UILabel = {
        let label = UILabel()
        label.text = .iSearchFor
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .blue
        label.textAlignment = .center
        return label
    }()
    
    let employeeButton = Button(title: .employee, titleColor: .white, backgroundColor: .blue)
    let jobButton = Button(title: .job, titleColor: .white, backgroundColor: .blue)
}
