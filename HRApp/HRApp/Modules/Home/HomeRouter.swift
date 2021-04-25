import UIKit
import RxSwift
import RxCocoa

protocol HomeRouterProtocol {
    func showResults()
}

final class HomeRouter: HomeRouterProtocol {
    
    // MARK: - Dependencies
    weak var viewController: HomeViewController?
    
    // MARK: - Methods
    func showResults() {
        print("show")
        let results = ResultsAssembly.module()
        viewController?.navigationController?.pushViewController(results, animated: true)
    }
}
