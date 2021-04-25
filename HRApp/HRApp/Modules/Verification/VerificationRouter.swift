import UIKit
import RxSwift
import RxCocoa

protocol VerificationRouterProtocol {
    func popToRoot()
}

final class VerificationRouter: VerificationRouterProtocol {
    
    // MARK: - Dependencies
    weak var viewController: VerificationViewController?
    
    // MARK: - Methods
    func popToRoot() {
        let whoami = WhoAmIAssembly.module()
        viewController?.navigationController?.popToRootViewController {
            (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = UINavigationController(rootViewController: whoami)
        }
    }
}
