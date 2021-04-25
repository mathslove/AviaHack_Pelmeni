import UIKit

protocol ExtraFillerProtocol {
    func fill()
}

final class ExtraFiller: ExtraFillerProtocol {
    
    // MARK: - Dependencies
    weak var view: ExtraView?
    weak var viewController: ExtraViewController?
    
    // MARK: - Fill
    func fill() {
        guard let view = view else { return }
        
        view.addSubview(view.aloeStackView)
        view.aloeStackView.addRows([view.avatar, view.tableView])
        
        view.aloeStackView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(view.snp.topMargin)
        }
        
        view.avatar.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.width / 3)
            make.left.right.equalToSuperview().inset(UIScreen.main.bounds.width / 3)
        }
        
        view.tableView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(view.tableView.contentSize.height + view.safeAreaInsets.top)
        }
    }
}
