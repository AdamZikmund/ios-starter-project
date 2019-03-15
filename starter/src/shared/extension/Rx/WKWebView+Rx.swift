import WebKit

import RxSwift
import RxCocoa

// MARK: - WKWebView
extension Reactive where Base: WKWebView {

    var request: Binder<URLRequest> {
        return Binder(base, binding: { webView, request in
            webView.load(request)
        })
    }

}
