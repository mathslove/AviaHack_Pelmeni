import UIKit
import RxSwift
import RxCocoa

protocol RegistrationRouterProtocol: class {
    func showVerification()
    func showHome()
}

final class RegistrationRouter: RegistrationRouterProtocol {
    
    // MARK: - Dependencies
    weak var viewController: RegistrationViewController?
    
    // MARK: - Methods
    func showVerification() {
        DatabaseManager.update(data: [
            DatabasePaths.screen: DatabasePaths.verification
        ])
    }
    
    func showHome() {
        (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = UINavigationController(rootViewController: HomeAssembly.module())
    }
}
