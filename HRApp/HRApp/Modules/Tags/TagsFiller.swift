protocol TagsFillerProtocol {
    func fill()
}

final class TagsFiller: TagsFillerProtocol {
    
    // MARK: - Dependencies
    weak var view: TagsView?
    
    // MARK: - Fill
    func fill() {
        guard let view = view else { return }
        
        view.addSubviews([
            view.placeholderLabel,
            view.tagsField,
            view.separator,
            view.saveButton
        ])
        
        view.placeholderLabel.snp.makeConstraints { (make) in
            make.left.equalTo(view.tagsField).inset(2)
            make.top.equalTo(view.tagsField).inset(14)
        }
        
        view.tagsField.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.topMargin).inset(80)
            make.left.equalTo(view.snp.leftMargin)
            make.right.equalTo(view.snp.rightMargin)
        }
        
        view.separator.snp.makeConstraints { (make) in
            make.top.equalTo(view.tagsField.snp.bottom).inset(-5)
            make.left.equalTo(view.snp.leftMargin)
            make.right.equalTo(view.snp.rightMargin)
            make.height.equalTo(0.5)
        }
        
        view.saveButton.snp.makeConstraints { (make) in
            make.height.equalTo(44)
            make.left.equalTo(view.snp.leftMargin)
            make.right.equalTo(view.snp.rightMargin)
            make.bottom.equalTo(view.snp.bottomMargin).inset(12)
        }
    }
}
