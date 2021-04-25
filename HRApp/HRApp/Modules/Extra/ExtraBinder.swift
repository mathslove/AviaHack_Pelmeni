import UIKit
import RxSwift
import RxCocoa
import RxGesture
import RxKeyboard

protocol ExtraBinderProtocol {
    func bind()
}

final class ExtraBinder: ExtraBinderProtocol {
    
    // MARK: - Dependencies
    weak var view: ExtraView?
    weak var viewController: ExtraViewController?
    weak var router: ExtraRouter?
    
    private let bag = DisposeBag()
    
    // MARK: - Methods
    func bind() {
        bindTableViewItemSelection()
        bindTapAtbackground()
        bindKeyboardHeight()
        bindDoneButtonEnablement()
        bindTapAtDoneButton()
        bindDoneButton()
    }
    
    func bindDoneButton() {
        viewController?.mainView.doneButton.rx.tap.bind { _ in
            self.viewController?.navigationController?.popToRootViewController {
                (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = UINavigationController(rootViewController: HomeAssembly.module())
            }
        }.disposed(by: bag)
    }
    
    func bindTableViewItemSelection() {
        guard let view = view else { return }
        view.tableView.rx.itemSelected.bind { [self] (indexPath) in
            view.tableView.deselectRow(at: indexPath, animated: true)
            switch indexPath.row {
            case 0, 1, 2, 5: (view.tableView.cellForRow(at: indexPath) as! RegistrationTableViewCellWithtextField).textField.becomeFirstResponder()
                
            case 4:
                let cell = (view.tableView.cellForRow(at: indexPath) as! ExtraCellWithArrayOfStrings)
                let graph = DetailAssembly.module(type: .multiple(title: cell.data[0], data: cell.data1), title: cell.data[0])
                let navigationController = UINavigationController(rootViewController: graph)
                
                viewController?.present(navigationController, animated: true)
                
            case 6, 9:
                let cell = (view.tableView.cellForRow(at: indexPath) as! ExtraCellWithArrayOfStrings)
                let textView = DetailAssembly.module(type: .textView(placeholder: cell.data[0]), title: cell.data[0])
                let navigationController = UINavigationController(rootViewController: textView)
                
                viewController?.present(navigationController, animated: true)
                
            case 7:
                let cell = (view.tableView.cellForRow(at: indexPath) as! ExtraCellWithArrayOfStrings)
                let textView = DetailAssembly.module(type: .expanded(data: cell.data[0], first: cell.data1, second: cell.data2, third: cell.data3), title: cell.data[0])
                let navigationController = UINavigationController(rootViewController: textView)
                
                viewController?.present(navigationController, animated: true)
                
            case 8:
                let cell = (view.tableView.cellForRow(at: indexPath) as! ExtraCellWithArrayOfStrings)
                let textView = DetailAssembly.module(type: .many(title: cell.data[0], placeholder: cell.data1[0], buttonTitle: cell.data2[0]), title: cell.data[0])
                let navigationController = UINavigationController(rootViewController: textView)
                
                viewController?.present(navigationController, animated: true)
                
            case 10:
                let tags = TagsAssembly.module()
                let navigationController = UINavigationController(rootViewController: tags)
                
                viewController?.present(navigationController, animated: true)
                
            default: break
            }
        }.disposed(by: bag)
    }
    
    func bindTapAtbackground() {
        guard let view = view else { return }
        view.tableView.backgroundView?.rx.tapGesture().bind { (tap) in
            view.endEditing(true)
        }.disposed(by: bag)
    }
    
    func bindKeyboardHeight() {
        guard let view = view else { return }
        RxKeyboard.instance.visibleHeight.drive { height in
            view.aloeStackView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
            view.aloeStackView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: height - view.safeAreaInsets.bottom, right: 0)
        }.disposed(by: bag)
    }
    
    private func bindDoneButtonEnablement() {
        let isName = LocalbaseManager.firstname.map { ($0?.count ?? 0) >= 2 }
        let isSurname = LocalbaseManager.secondname.map { ($0?.count ?? 0) >= 4 }
        let isRelocate = LocalbaseManager.relocate.map { $0 != nil }
        let isGraph = LocalbaseManager.graph.map { ($0?.occupation ?? 0) > 0 && ($0?.weekend ?? 0) > 0 }
        let isTarget = LocalbaseManager.target.map { (($0?.count ?? 0) > 6) }
//        let isEducation = LocalbaseManager.education.map { ($0?.count ?? 0) > 0 }
        let isSkills = LocalbaseManager.skills.map { $0.count > 0 }
        let isExtra = LocalbaseManager.extra.map { ($0?.count ?? 0) > 0 }
        
        Observable.combineLatest(isName, isSurname, isRelocate, isGraph, isTarget/*, isEducation*/, isSkills, isExtra).map { $0 && $1 && $2 && $3 && $4 && $5 && $6/* && $7*/ }.bind { [self] isEnabled in
            view?.doneButton.isEnabled = isEnabled
        }.disposed(by: bag)
    }
    
    private func bindTapAtDoneButton() {
        guard let view = view else { return }
        view.doneButton.rx.tap.bind { [weak self] _ in
            self?.router?.showHome()
        }.disposed(by: bag)
    }
}
