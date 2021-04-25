import UIKit
import RxSwift
import RxCocoa

protocol WhoAmIRouterProtocol: class {
    func showExtraView(type: ExtraScreenType)
}

final class WhoAmIRouter: WhoAmIRouterProtocol {
    
    // MARK: - Dependencies
    
    // MARK: - Methods
    func showExtraView(type: ExtraScreenType) {
        switch type {
        case .hr: break
        case .worker:
            let extraVC = ExtraAssembly.module(type: .worker)
            (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = UINavigationController(rootViewController: extraVC)
        }
    }
}

enum ExtraScreenType {
    case hr
    case worker
}
