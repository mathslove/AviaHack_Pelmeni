import UIKit
import RxSwift
import RxCocoa

protocol HomeBinderProtocol {
    func bind()
}

final class HomeBinder: HomeBinderProtocol {
    
    // MARK: - Dependencies
    
    private let bag = DisposeBag()
    
    // MARK: - Bind
    func bind() {
        
    }
}
