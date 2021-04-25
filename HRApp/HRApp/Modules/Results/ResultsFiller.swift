protocol ResultsFillerProtocol {
    func fill()
}

final class ResultsFiller: ResultsFillerProtocol {
    
    // MARK: - Dependencies
    weak var view: ResultsView?
    
    // MARK: - Fill
    func fill() {
        guard let view = view else { return }
        
        view.addSubviews([view.matched, view.conformity, view.tableView])
        
        view.matched.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.leftMargin)
            make.centerY.equalTo(view.conformity)
        }
        
        view.conformity.snp.makeConstraints { (make) in
            make.right.equalTo(view.snp.rightMargin)
            make.top.equalTo(view.snp.topMargin)
        }
        
        view.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.conformity.snp.bottom).inset(-4)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
//            make.height.equalTo(view.tableView.contentSize.height)
        }
    }
}
