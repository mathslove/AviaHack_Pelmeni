import UIKit

protocol HomeFillerProtocol {
    func fill()
}

final class HomeFiller: HomeFillerProtocol {
    
    // MARK: - Dependencies
    weak var view: HomeView?
    
    // MARK: - Fill
    func fill() {
        guard let view = view else { return }
        view.addSubviews([
            view.avatar,
            view.fio,
            view.myCV,
            view.tableView
        ])
        
        view.avatar.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.topMargin).inset(60)
            make.height.width.equalTo(UIScreen.main.bounds.width / 3)
            make.centerX.equalToSuperview()
        }
        
        view.fio.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.avatar.snp.bottom).inset(-12)
        }
        
        view.myCV.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.fio.snp.bottom).inset(-8)
        }
        
        view.tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.myCV.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
