import UIKit
import RxSwift
import RxCocoa
import RxKeyboard
import RxGesture

protocol TagsBinderProtocol {
    func bind()
}

final class TagsBinder: TagsBinderProtocol {
    
    // MARK: - Dependencies
    weak var view: TagsView?
    weak var viewController: TagsViewController?
    
    private var isFirstTime = true
    
    private let bag = DisposeBag()
    
    private func move(toX xTranslation: CGFloat,
                      y yTranslation: CGFloat,
                      scaledByX xScale: CGFloat,
                      y yScale: CGFloat) {
        UIView.animate(withDuration: 0.1) { [weak self] in
            let transform = CGAffineTransform(translationX: xTranslation,
                                              y: yTranslation).scaledBy(x: xScale,
                                                                        y: yScale)
            self?.view?.placeholderLabel.transform = transform
        }
    }
    
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
        bindConstraints()
        bindPlaceholder()
        bindKeyboard()
        bindCancelButton()
        bindTapAtBackground()
        bindSaveButton()
    }
    
    func bindSaveButton() {
        guard let view = view else { return }
        view.saveButton.rx.tap.bind { _ in
            LocalbaseManager.tags.accept(view.tagsField.tags.map { $0.text })
            let presenting = self.viewController?.presentingViewController
            self.viewController?.dismiss(animated: true) {
                (presenting?.children.last as! ExtraViewController).mainView.tableView.reloadData()
            }
        }.disposed(by: bag)
    }
    
    func bindTapAtBackground() {
        guard let view = view else { return }
        view.backgroundView.rx.tapGesture().bind { _ in
            view.endEditing(true)
        }.disposed(by: bag)
    }
    
    func bindCancelButton() {
        guard let view = view else { return }
        view.cancel.rx.tap.bind { _ in
            LocalbaseManager.tags.accept(nil)
            let presenting = self.viewController?.presentingViewController
            self.viewController?.dismiss(animated: true) {
                (presenting?.children.last as! ExtraViewController).mainView.tableView.reloadData()
            }
        }.disposed(by: bag)
    }
    
    func bindPlaceholder() {
        view?.tagsField.textField.rx
            .text
            .orEmpty
            .map { $0.count > 0 }
            .distinctUntilChanged()
            .bind(to: movePlaceholder())
            .disposed(by: bag)
    }
    
    func bindConstraints() {
        view?.tagsField.emitter.rx
            .tagsNumber
            .map { $0 > 0 }
//            .distinctUntilChanged()
            .bind(to: observeTags())
            .disposed(by: bag)
    }
    
    private func bindKeyboard() {
        RxKeyboard.instance.visibleHeight.drive { [self] (height) in
            height > 0 ? upSave(height: height) : downSave()
        }.disposed(by: bag)
    }
    
    private func observeTags() -> Binder<Bool> {
        Binder(self) { binder, isMoreThanZero in
            guard let view = binder.view else { return }
            view.tagsField.snp.updateConstraints { (make) in
                make.top.equalTo(view.snp.topMargin).inset(isMoreThanZero ? 65 : 80)
            }
            
            if !binder.isFirstTime {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    view.tagsField.textField.becomeFirstResponder()
                }
            } else {
                binder.isFirstTime = false
            }
            
            if !isMoreThanZero && binder.view?.tagsField.textField.text?.count == 0 {
                binder.move(toX: 0, y: 0, scaledByX: 1, y: 1)
            }
            
            view.saveButton.isEnabled = isMoreThanZero
        }
    }
    
    private func movePlaceholder() -> Binder<Bool> {
        Binder(self) { binder, isNotEmpty in
            if (binder.view?.tagsField.emitter.tagsNumber ?? 0) > 0 {
                binder.move(toX: -6, y: -35, scaledByX: 0.86, y: 0.86)
            } else {
                if isNotEmpty {
                    binder.move(toX: -6, y: -20, scaledByX: 0.86, y: 0.86)
                } else {
                    binder.move(toX: 0, y: 0, scaledByX: 1, y: 1)
                }
            }
        }
    }
}
