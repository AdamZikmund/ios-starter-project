import UIKit

import Moya

// MARK: - NetworkActivityPlugin
extension NetworkActivityPlugin {

    // MARK: Initialization

    convenience init() {
        self.init { type, _ in
            DispatchQueue.main.async {
                UIApplication
                    .shared
                    .isNetworkActivityIndicatorVisible = type == .began
            }
        }
    }

}
