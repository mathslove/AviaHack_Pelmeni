import UIKit
import RxSwift
import RxCocoa

protocol ExtraRouterProtocol: class {
    func showHome()
}

final class ExtraRouter: ExtraRouterProtocol {
    
    // MARK: - Dependencies
    weak var viewController: ExtraViewController?
    
    // MARK: - Methods
    func showHome() {
        
    }
}
