import UIKit
import RxSwift
import RxCocoa
import FirebaseAuth

protocol VerificationBinderProtocol {
    func bind()
    func forceDeinit()
}

final class VerificationBinder: VerificationBinderProtocol {
    
    // MARK: - Dependencies
    weak var viewController: VerificationViewController?
    
    private var bag = DisposeBag()
    
    deinit {
        print("deinit")
    }
    
    // MARK: - Bind
    func bind() {
        bindCheckVerificationEmail()
    }
    
    func bindCheckVerificationEmail() {
        Observable<Int>
            .interval(.seconds(1),
                      scheduler: MainScheduler.instance).bind { [weak self] _ in
                        self?.reloadAndCheck()
                      }.disposed(by: bag)
    }
    
    // MARK: - Methods
    func reloadAndCheck() {
        Auth.auth().currentUser?.reload { [weak self] (error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print(Auth.auth().currentUser!.isEmailVerified)
                if Auth.auth().currentUser!.isEmailVerified {
                    self?.viewController?.router.popToRoot()
                }
            }
        }
    }
    
    func forceDeinit() {
        bag = DisposeBag()
    }
}
