import UIKit

protocol VerificationFillerProtocol {
    func fill()
}

final class VerificationFiller: VerificationFillerProtocol {
    
    // MARK: - Dependencies
    weak var view: VerificationView?
    
    // MARK: - Fill
    func fill() {
        guard let view = view else { return }
        view.emailSendedLabel.numberOfLines = 0
        
        view.addSubview(view.emailSendedLabel)
        
        view.emailSendedLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(UIScreen.main.bounds.width / 8)
            make.centerY.equalToSuperview().inset(-UIScreen.main.bounds.width / 10)
        }
    }
}
