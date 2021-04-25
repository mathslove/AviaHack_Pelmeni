import UIKit
import RxSwift
import RxCocoa

protocol ResultsRouterProtocol: class {
    func showDetail()
}

final class ResultsRouter: ResultsRouterProtocol {
    
    // MARK: - Dependencies
    weak var viewController: ResultsViewController?
    
    // MARK: - Methods
    func showDetail() {
        let detailUser = DetailUserAssembly.module(uid: viewController!.uid)
        viewController?.navigationController?.pushViewController(detailUser, animated: true)
    }
}
