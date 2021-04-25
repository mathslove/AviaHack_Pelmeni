import UIKit
import SwiftyMenu

protocol DetailFillerProtocol {
    func fill(type: ExtraField)
}

final class DetailFiller: DetailFillerProtocol {
    
    // MARK: - Dependencies
    weak var view: DetailView?
    
    // MARK: - Fill
    func fill(type: ExtraField) {
        guard let view = view else { return }
        view.addSubview(view.saveButton)
        view.saveButton.snp.makeConstraints { (make) in
            make.height.equalTo(44)
            make.left.equalTo(view.snp.leftMargin)
            make.right.equalTo(view.snp.rightMargin)
            make.bottom.equalTo(view.snp.bottomMargin).inset(12)
        }
        
        switch type {
        case .textView(let placeholder): configureViewWithTextView(placeholder: placeholder)
        case .multiple(_, let data): configureWithMultipleSelection(data: data)
        case .many(_, let placeholder, _): configureViewWithManyCells(placeholder: placeholder)
        case .expanded(_, _, _, _): configureEduCell()
        default: break
        }
    }
    
    private func configureViewWithTextView(placeholder: String) {
        guard let view = view else { return }
        view.addSubview(view.textView)
        
        view.textView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.topMargin)
            make.left.equalTo(view.snp.leftMargin)
            make.right.equalTo(view.snp.rightMargin)
            make.height.equalTo(UIScreen.main.bounds.height / 3)
        }
        
        if placeholder == .objective {
            view.textView.text = LocalbaseManager.target.value
        } else {
            view.textView.text = LocalbaseManager.extra.value
        }
    }
    
    private func configureWithMultipleSelection(data: [String]) {
        guard let view = view else { return }
        
        view.swiftyMenu.items = data
        view.swiftyMenu.titleLeftInset = 8
        view.swiftyMenu.itemTextColor = .blue
        view.swiftyMenu.placeHolderColor = .blue
        view.swiftyMenu.hideOptionsWhenSelect = true
        view.swiftyMenu.expandingDuration = 0.18
        view.swiftyMenu.collapsingDuration = 0.18
        view.swiftyMenu.placeHolderText = .chooseGraph
        
        view.swiftyMenu.delegate = self
        
        view.addSubviews([view.shadowView, view.swiftyMenu])
        
        view.shadowView.snp.makeConstraints { (make) in
            make.center.height.width.equalTo(view.swiftyMenu)
        }
        
        view.swiftyMenu.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.leftMargin)
            make.right.equalTo(view.snp.rightMargin)
            make.top.equalTo(view.snp.topMargin).inset(20)
        }
        
        view.swiftyMenu.heightConstraint = NSLayoutConstraint(item: view.swiftyMenu, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 44)
        view.swiftyMenu.heightConstraint.isActive = true
    }
    
    private func configureViewWithManyCells(placeholder: String) {
        guard let view = view else { return }
        view.insertSubview(view.tableView, belowSubview: view.saveButton)
        
        view.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureEduCell() {
        guard let view = view else { return }
        view.insertSubview(view.tableView, belowSubview: view.saveButton)
        
        view.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension String: SwiftyMenuDisplayable {
    public var retrievableValue: Any {
        return self
    }
    
    public var displayableValue: String {
        return self
    }
}

extension DetailFiller: SwiftyMenuDelegate {
    func swiftyMenu(_ swiftyMenu: SwiftyMenu, didSelectItem item: SwiftyMenuDisplayable, atIndex index: Int) {
        
        switch index {
        case 0, 1, 2, 3, 4:
            let occupation = Int(String(item.displayableValue.first!))!
            let weekend = Int(String(item.displayableValue.last!))!
            print("ow", occupation, weekend)
            LocalbaseManager.graph.accept((occupation: occupation, weekend: weekend))
        case 5:LocalbaseManager.graph.accept((occupation: -1, weekend: -1))
        default: LocalbaseManager.graph.accept((occupation: -2, weekend: -2))
        }
    }
}
