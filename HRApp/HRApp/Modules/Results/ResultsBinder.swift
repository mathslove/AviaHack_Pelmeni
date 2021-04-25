import UIKit
import RxSwift
import RxCocoa
import FirebaseAuth

protocol ResultsBinderProtocol {
    func bind()
}

final class ResultsBinder: ResultsBinderProtocol {
    
    // MARK: - Dependencies
    weak var view: ResultsView?
    weak var viewController: ResultsViewController?
    weak var router: ResultsRouter?
    
    private let bag = DisposeBag()
    
    // MARK: - Bind
    func bind() {
        bindTapToTableView()
    }
    
    func bindTapToTableView() {
        guard let view = view else { return }
        view.tableView.rx.itemSelected.bind { indexPath in
            view.tableView.deselectRow(at: indexPath, animated: true)
            self.router?.showDetail()
        }.disposed(by: bag)
    }
}
