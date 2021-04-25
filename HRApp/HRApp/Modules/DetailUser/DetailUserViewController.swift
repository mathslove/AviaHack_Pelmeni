//  
//  DetailUserViewController.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 25.04.2021.
//

import UIKit
import RxSwift
import RxCocoa
import Charts

final class DetailUserViewController: ViewController<DetailUserView> {

    //MARK: - Properties
    let binder: DetailUserBinderProtocol
    let filler: DetailUserFillerProtocol
    let presenter: DetailUserPresenterProtocol
    let router: DetailUserRouterProtocol
    var uid = ""
    var dataset = RadarChartDataSet()
    var user = VacansUser()
    
    //MARK: - Initializer
    init(binder: DetailUserBinderProtocol,
         filler: DetailUserFillerProtocol,
         presenter: DetailUserPresenterProtocol,
         router: DetailUserRouterProtocol,
         uid: String) {
        print("uid", uid)
        self.uid = uid
        self.binder = binder
        self.filler = filler
        self.presenter = presenter
        self.router = router
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getMetric(forUser: uid)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Подробная информация"
        filler.fill()
    }
    
    func notify() {
        mainView.nameLabel.text = user.lastname! + " " + user.firstname! + " " + user.middle!
        dataset = RadarChartDataSet(entries: [
            RadarChartDataEntry(value: Double(user.education_res!)),
            RadarChartDataEntry(value: Double(user.experience_res!)),
            RadarChartDataEntry(value: Double(user.hardskill_res!)),
            RadarChartDataEntry(value: Double(user.softskill_res!)),
            RadarChartDataEntry(value: Double(user.tags_res!)),
        ])
        
        let data = RadarChartData(dataSet: dataset)
        
        mainView.web.data = data
    }
}
