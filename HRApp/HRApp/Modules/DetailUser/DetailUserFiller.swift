import UIKit

protocol DetailUserFillerProtocol {
    func fill()
}

final class DetailUserFiller: DetailUserFillerProtocol {
    
    // MARK: - Dependencies
    weak var view: DetailUserView?
    
    // MARK: - Fill
    func fill() {
        guard let view = view else { return }
        view.addSubviews([view.nameLabel, view.web])
        
        view.nameLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(12)
            make.top.equalTo(view.snp.topMargin)
        }
        
        view.web.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(10)
            make.top.equalTo(view.nameLabel.snp.bottom).inset(-30)
            make.height.width.equalTo(UIScreen.main.bounds.width / 1.25)
        }
    }
}
