import UIKit
import RxSwift
import RxCocoa
import RxKeyboard
import RxGesture
import FirebaseAuth

protocol RegistrationBinderProtocol {
    func bind()
}

final class RegistrationBinder: RegistrationBinderProtocol {
    
    // MARK: - Dependencies
    weak var view: RegistrationView?
    weak var router: RegistrationRouter?
    
    let title = BehaviorRelay<String>(value: .registration)
    let texts = BehaviorRelay<[String]>(value: [])
    
    private lazy var data = BehaviorRelay<[(placeholder: String,
                                            keyboardType: UIKeyboardType,
                                            isSecret: Bool)]>(value: [
        (placeholder: .email, keyboardType: .emailAddress, isSecret: false),
        (placeholder: .password, keyboardType: .default, isSecret: true),
    ])
    
    private let bag = DisposeBag()
    
    // MARK: - Bind
    func bind() {
        bindTableViewDataSource()
        bindTableViewItemSelection()
        bindTitle()
        bindKeyboard()
        bindTapAtBackground()
        bindSignInButton()
        bindTexts()
        bindSignUpButton()
    }
    
    private func bindTableViewDataSource() {
        guard let tableView = view?.tableView else { return }
        data.bind(to: tableView.rx.items(cellIdentifier: RegistrationTableViewCellWithtextField.cellID, cellType: RegistrationTableViewCellWithtextField.self)) { [self] (row, content, cell) in
            texts.append("")
            
            cell.fill()
            
            cell.textField.placeholder = content.placeholder
            cell.textField.keyboardType = content.keyboardType
            cell.textField.isSecureTextEntry = content.isSecret
            cell.textField.autocorrectionType = .no
            cell.textField.autocapitalizationType = .none
            cell.selectionStyle = .none
            
            cell.textField.rx.text.orEmpty.bind { text in
                texts.replace(text, at: row)
            }.disposed(by: bag)
        }.disposed(by: bag)
    }
    
    private func bindTableViewItemSelection() {
        guard let tableView = view?.tableView else { return }
        tableView.rx.itemSelected.bind { (indexPath) in
            let cell = tableView.cellForRow(at: indexPath) as! RegistrationTableViewCellWithtextField
            cell.textField.becomeFirstResponder()
        }.disposed(by: bag)
    }
    
    private func bindTitle() {
        guard let view = view else { return }
        title.bind { text in
            view.titleLabel.text = text
            if text == .registration {
                var value = self.data.value
                value.append((placeholder: .repeatPassword, keyboardType: .default, isSecret: true))
                self.data.accept(value)
                
                view.signInButton.setTitle(.signIn, for: .normal)
                view.signUpButton.setTitle(.signUp, for: .normal)
            } else if text == .authorization {
                var value = self.data.value
                value.removeLast()
                self.data.accept(value)
                
                view.signInButton.setTitle(.signUp, for: .normal)
                view.signUpButton.setTitle(.signIn, for: .normal)
            }
        }.disposed(by: bag)
    }
    
    private func bindKeyboard() {
        RxKeyboard.instance.visibleHeight.skip(1).drive { [self] (frame) in
            frame > 0 ? upContent() : downContent()
        }.disposed(by: bag)
    }
    
    private func bindTapAtBackground() {
        guard let view = view else { return }
        view.backgroundView.rx.tapGesture().bind { _ in
            view.endEditing(true)
        }.disposed(by: bag)
    }
    
    private func bindSignInButton() {
        guard let view = view else { return }
        view.signInButton.rx.tap.bind { [self] _ in
            texts.accept([])
            title.value == .registration ? title.accept(.authorization) : title.accept(.registration)
        }.disposed(by: bag)
    }
    
    private func bindTexts() {
        guard let view = view else { return }
        texts.bind { texts in
            let isEmail = texts[safe: 0]?.isEmail ?? true
            let isPassword = texts[safe: 1]?.isPassword ?? true
            let isConfitmedPassword = texts[safe: 2]?.isPassword ?? true
            view.signUpButton.isEnabled = isEmail && isPassword && isConfitmedPassword && (texts[safe: 2] == nil || texts[safe: 1] == texts[safe: 2])
        }.disposed(by: bag)
    }
    
    private func bindSignUpButton() {
        guard let view = view else { return }
        view.signUpButton.rx.tap.bind { [self] _ in
            if title.value == .registration {
                Auth.auth().createUser(withEmail: texts.value[0], password: texts.value[1]) { (result, error) in
                    if let error = error {
                        AlertManager.shared.showNotification(title: error.localizedDescription, actions: [UIAlertAction(title: "OK", style: .default, handler: nil)])
                    } else {
                        DatabaseManager.update(data: [
                            DatabasePaths.password: texts.value[1]
                        ])
                        router?.showVerification()
                    }
                }
            } else {
                Auth.auth().signIn(withEmail: texts.value[0], password: texts.value[1]) { (result, error) in
                    if let error = error {
                        AlertManager.shared.showNotification(title: error.localizedDescription, actions: [UIAlertAction(title: "OK", style: .default, handler: nil)])
                    } else {
                        router?.showHome()
                        print(result?.user.uid as Any)
                    }
                }
            }
        }.disposed(by: bag)
    }
    
    // MARK: - Methods
    private func upContent() {
        guard let view = view else { return }
        
        view.tableView.snp.updateConstraints { (make) in
            make.centerY.equalToSuperview().offset(-UIScreen.main.bounds.height / 5)
        }
        
        UIView.animate(withDuration: 0.2) {
            view.iconView.alpha = 0
            view.layoutSubviews()
        }
    }
    
    private func downContent() {
        guard let view = view else { return }
        
        view.tableView.snp.updateConstraints { (make) in
            make.centerY.equalToSuperview().inset(UIScreen.main.bounds.height / 10)
        }
        
        UIView.animate(withDuration: 0.2) {
            view.iconView.alpha = 1
            view.layoutSubviews()
        }
    }
}
