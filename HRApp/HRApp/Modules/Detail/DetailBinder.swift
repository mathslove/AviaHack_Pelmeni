import UIKit
import RxSwift
import RxCocoa
import RxKeyboard
import RxGesture

protocol DetailBinderProtocol {
    func bind()
}

final class DetailBinder: DetailBinderProtocol {
    
    // MARK: - Dependencies
    weak var viewController: DetailViewController?
    weak var view: DetailView?
    
    private let bag = DisposeBag()
    
    
    private func upSave(height: CGFloat) {
        guard let view = view else { return }
        view.saveButton.snp.updateConstraints{ (make) in
            make.bottom.equalTo(view.snp.bottomMargin).inset(height)
        }
        
        UIView.animate(withDuration: 0.1) {
            view.layoutIfNeeded()
        }
    }
    
    private func downSave() {
        guard let view = view else { return }
        view.saveButton.snp.updateConstraints{ (make) in
            make.bottom.equalTo(view.snp.bottomMargin).inset(12)
        }
        
        UIView.animate(withDuration: 0.1) {
            view.layoutIfNeeded()
        }
    }
    
    // MARK: - Bind
    func bind() {
        bindCancelButton()
        bindTapAtBackground()
        bindKeyboard()
        bindSaveButtonEnablement()
        bindSaveButtonTap()
        bindTableViewDataSource()
        bindEditButtonEnablement()
        bindEditButtonTap()
    }
    
    private func bindEditButtonEnablement() {
        guard let view = view else { return }
        LocalbaseManager.skills.map { $0.count <= 3 }.bind { isEnable in
            view.editButton.isEnabled = isEnable
        }.disposed(by: bag)
    }
    
    private func bindEditButtonTap() {
        guard let view = view else { return }
        view.editButton.rx.tap.bind { _ in
            var value = LocalbaseManager.skills.value
            value.append("")
            LocalbaseManager.skills.accept(value)
        }.disposed(by: bag)
    }
    
    private func bindSaveButtonEnablement() {
        guard let view = view, let viewController = viewController else { return }
        switch viewController.type {
        case .textView(_):
            view.textView.rx.text.orEmpty.map { $0.count > 6 }.bind { isEnabled in
                view.saveButton.isEnabled = isEnabled
            }.disposed(by: bag)
        
        case .multiple(_, _):
            LocalbaseManager.graph.map { $0 != nil }.bind { isEnabled in
                view.saveButton.isEnabled = isEnabled
            }.disposed(by: bag)
            
        default: break
        }
    }
    
    private func bindSaveButtonTap() {
        guard let view = view else { return }
        view.saveButton.rx.tap.bind { _ in
            if self.viewController?.title == .addInfo {
                LocalbaseManager.extra.accept(view.textView.text)
            } else if self.viewController?.title == .objective {
                LocalbaseManager.target.accept(view.textView.text)
//            } else if self.viewController?.title ==  {
//
            } else if self.viewController?.title == .education {
                let z = (view.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! RegistrationTableViewCellWithtextField).textField.text!
                let f = (view.tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! RegistrationTableViewCellWithtextField).textField.text!
                let s = (view.tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! RegistrationTableViewCellWithtextField).textField.text!
                let t = (view.tableView.cellForRow(at: IndexPath(row: 3, section: 0)) as! RegistrationTableViewCellWithtextField).textField.text!
                let fo = (view.tableView.cellForRow(at: IndexPath(row: 4, section: 0)) as! RegistrationTableViewCellWithtextField).textField.text!
                LocalbaseManager.education.accept([z, f, s, t, fo])
            }
            
            let presenting = self.viewController?.presentingViewController
            self.viewController?.dismiss(animated: true) {
                (presenting?.children.last as! ExtraViewController).mainView.tableView.reloadData()
            }
        }.disposed(by: bag)
    }
    
    private func bindKeyboard() {
        RxKeyboard.instance.visibleHeight.drive { [self] (height) in
            height > 0 ? upSave(height: height) : downSave()
        }.disposed(by: bag)
    }
    
    func bindTapAtBackground() {
        guard let view = view else { return }
        view.backgroundView.rx.tapGesture().bind { _ in
            view.endEditing(true)
        }.disposed(by: bag)
        
        view.tableView.backgroundView?.rx.tapGesture().bind { _ in
            view.endEditing(true)
        }.disposed(by: bag)
    }
    
    func bindCancelButton() {
        guard let view = view else { return }
        view.cancel.rx.tap.bind { _ in
            switch self.viewController?.type {
            case .multiple(_, _): LocalbaseManager.graph.accept(nil)
            default: break
            }
            
            let presenting = self.viewController?.presentingViewController
            self.viewController?.dismiss(animated: true) {
                (presenting?.children.last as! ExtraViewController).mainView.tableView.reloadData()
            }
        }.disposed(by: bag)
    }
    
    func bindTableViewDataSource() {
        guard let view = view else { return }
        switch viewController?.type {
        case .expanded(_, _, _, _):
            Observable.just([
                "Название учебного заведения",
                "Начало обучения (год)",
                "Конец обучения (год)",
                "Степень (бакалавр/магистр...)",
                "Специализация",
                "Сертификация (да/нет)"
            ]).bind(to: view.tableView.rx.items(cellIdentifier: RegistrationTableViewCellWithtextField.cellID, cellType: RegistrationTableViewCellWithtextField.self)) { row, content, cell in
                cell.fill()
                if row == 1 || row == 2 {
                    cell.textField.keyboardType = .decimalPad
                }
                cell.textField.placeholder = content
                cell.selectionStyle = .none
            }.disposed(by: bag)
        default:
            LocalbaseManager.skills.map { $0 == nil ? [] : $0! }.bind(to: view.tableView.rx.items(cellIdentifier: RegistrationTableViewCellWithtextField.cellID, cellType: RegistrationTableViewCellWithtextField.self)) { row, content, cell in
                cell.fill()
            }.disposed(by: bag)
            
            view.tableView.rx.itemSelected.bind { indexPath in
                view.tableView.deselectRow(at: indexPath, animated: true)
                (view.tableView.cellForRow(at: indexPath) as! RegistrationTableViewCellWithtextField).textField.becomeFirstResponder()
            }.disposed(by: bag)
            
            view.tableView.rx.itemDeleted.bind { indexPath in
                var value = LocalbaseManager.skills.value
                value.remove(at: indexPath.row)
                LocalbaseManager.skills.accept(value)
            }.disposed(by: bag)
        }
        
    }
}
