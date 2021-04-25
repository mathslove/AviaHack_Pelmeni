import UIKit
import RxSwift
import RxCocoa

protocol DetailUserBinderProtocol {
    func bind()
}

final class DetailUserBinder: DetailUserBinderProtocol {
    
    // MARK: - Dependencies
    
    private let bag = DisposeBag()
    
    // MARK: - Bind
    func bind() {
        
    }
}
