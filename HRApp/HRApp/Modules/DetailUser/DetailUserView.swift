//  
//  DetailUserView.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 25.04.2021.
//

import UIKit
import Charts

final class DetailUserView: MainView {
    //MARK: - Views
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    let web: RadarChartView = {
        let chart = RadarChartView()
        return chart
    }()
}
