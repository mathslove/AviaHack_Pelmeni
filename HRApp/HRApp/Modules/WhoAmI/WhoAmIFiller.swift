protocol WhoAmIFillerProtocol {
    func fill()
}

final class WhoAmIFiller: WhoAmIFillerProtocol {
    
    // MARK: - Dependencies
    weak var view: WhoAmIView?
    
    // MARK: - Fill
    func fill() {
        guard let view = view else { return }
        
        view.addSubviews([
            view.iSeachFor,
            view.employeeButton,
            view.jobButton
        ])
        
        view.jobButton.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.leftMargin)
            make.right.equalTo(view.snp.rightMargin)
            make.height.equalTo(44)
            make.center.equalToSuperview()
        }
        
        view.employeeButton.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.leftMargin)
            make.right.equalTo(view.snp.rightMargin)
            make.height.equalTo(44)
            make.bottom.equalTo(view.jobButton.snp.top).inset(-12)
        }
        
        view.iSeachFor.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.employeeButton.snp.top).inset(-20)
            make.centerX.equalToSuperview()
        }
    }
}
