import SnapKit

protocol RegistrationFillerProtocol {
    func fill()
}

final class RegistrationFiller: RegistrationFillerProtocol {
    
    // MARK: - Dependencies
    weak var view: RegistrationView?
    
    // MARK: - Fill
    func fill() {
        guard let view = view else { return }
        
        view.addSubviews([
            view.iconView,
            view.titleLabel,
            view.tableView,
            view.signUpButton,
            view.signInButton,
            view.copyright
        ])
        
        view.tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().inset(UIScreen.main.bounds.height / 10)
            make.height.equalTo(view.tableView.contentSize.height)
        }
        
        view.titleLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.tableView.snp.top).offset(12)
            make.centerX.equalToSuperview()
        }
        
        view.iconView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width / 2.5)
            make.top.equalToSuperview().inset(UIScreen.main.bounds.height / 4.5)
        }
        
        view.signUpButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.tableView.snp.bottom).inset(10)
            make.left.equalTo(view.snp.leftMargin)
            make.right.equalTo(view.snp.rightMargin)
            make.height.equalTo(44)
        }
        
        view.signInButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.signUpButton.snp.bottom).offset(12)
            make.left.equalTo(view.snp.leftMargin)
            make.right.equalTo(view.snp.rightMargin)
            make.height.equalTo(44)
        }
        
        view.copyright.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.snp.bottomMargin).inset(12)
            make.centerX.equalToSuperview()
        }
    }
}
