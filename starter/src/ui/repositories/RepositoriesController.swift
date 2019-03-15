import UIKit

import RxSwift
import RxCocoa
import RxSwiftExt

/// Repositories controller
class RepositoriesController: UIViewController, StoryboardProtocol, BindableProtocol, ControllerAlertProtocol {

    // MARK: View model

    typealias ViewModel = RepositoriesViewModel

    var viewModel: RepositoriesViewModel! {
        willSet { unbind() }
        didSet { bind() }
    }
    var disposeBag: DisposeBag = DisposeBag()

    // MARK: Properties

    weak var delegate: RepositoriesControllerDelegate?
    private var refreshControl: UIRefreshControl = UIRefreshControl()

    // MARK: Outlets

    @IBOutlet private var dismissButton: UIBarButtonItem!
    @IBOutlet private var repositoriesTableView: UITableView!

    // MARK: Actions

    @IBAction func dismissButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.didDismissRepositories(controller: self)
    }

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

}

// MARK: - Setup
extension RepositoriesController {

    func setup() {
        repositoriesTableView.refreshControl = refreshControl
    }

}

// MARK: - Binding
extension RepositoriesController {

    func bind() {
        bindViewModel()
        bindRepositoriesTableView()
        bindRefreshControl()
    }

    private func bindViewModel() {
        viewModel
            .repositories
            .asDriver()
            .drive(repositoriesTableView
                .rx
                .items(cellIdentifier: "repositoryCell",
                       cellType: UITableViewCell.self)) { _, repository, cell in
                cell.textLabel?.text = repository.name
                cell.detailTextLabel?.text = repository.url
            }
            .disposed(by: disposeBag)

        viewModel
            .fetchAction
            .executing
            .map { $0 }
            .bind(to: refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)

        viewModel
            .fetchAction
            .underlyingErrors
            .observeOn(MainScheduler.instance)
            .bind(to: rx.error)
            .disposed(by: disposeBag)
    }

    private func bindRepositoriesTableView() {
        repositoriesTableView
            .rx
            .modelSelected(Repository.self)
            .asDriver()
            .drive(onNext: { [weak self] repository in
                guard let self = self else { return }

                self.delegate?.didSelectRepository(controller: self, repository: repository)
            })
            .disposed(by: disposeBag)

        repositoriesTableView
            .rx
            .didScrollToBottom
            .asDriver()
            .drive(viewModel.fetchAction.inputs)
            .disposed(by: disposeBag)
    }

    private func bindRefreshControl() {
        refreshControl
            .rx
            .controlEvent(.valueChanged)
            .asDriver()
            .drive(viewModel.fetchAction.inputs)
            .disposed(by: disposeBag)
    }

}
