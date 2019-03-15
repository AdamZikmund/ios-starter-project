import UIKit
import WebKit

import RxSwift
import RxCocoa
import RxSwiftExt

/// Repository detail view controller
class RepositoryController: UIViewController, StoryboardProtocol, BindableProtocol {

    // MARK: View model

    typealias ViewModel = RepositoryViewModel

    var viewModel: RepositoryViewModel! {
        willSet { unbind() }
        didSet { bind() }
    }
    var disposeBag: DisposeBag = DisposeBag()

    // MARK: Properties

    weak var delegate: RepositoryControllerDelegate?

    // MARK: Outlets

    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var webView: WKWebView!
    @IBOutlet private var dismissButton: DismissButton!

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

}

// MARK: - Setup
extension RepositoryController {

    func setup() {
        dismissButton.delegate = self
    }

}

// MARK: - Binding
extension RepositoryController {

    func bind() {
        viewModel
            .name
            .asDriver()
            .drive(nameLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel
            .url
            .unwrap()
            .map { url in URLRequest(url: url) }
            .bind(to: webView.rx.request)
            .disposed(by: disposeBag)
    }

}

// MARK: - DismissButtonDelegate
extension RepositoryController: DismissButtonDelegate {

    func dismissButtonPressed(button: DismissButton) {
        delegate?.didDismissRepository(controller: self)
    }

}
