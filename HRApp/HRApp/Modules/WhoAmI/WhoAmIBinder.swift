import UIKit
import RxSwift
import RxCocoa

protocol WhoAmIBinderProtocol {
    func bind()
}

final class WhoAmIBinder: WhoAmIBinderProtocol {
    
    // MARK: - Dependencies
    weak var view: WhoAmIView?
    weak var router: WhoAmIRouter?
    
    private let bag = DisposeBag()
    
    // MARK: - Bind
    func bind() {
        view?.employeeButton.rx.tap.bind {
            
        }.disposed(by: bag)
    }
}
