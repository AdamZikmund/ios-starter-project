import UIKit

/// Protocol for loading view nib file
protocol NibViewProtocol where Self: UIView {

    /// Gets view nib
    ///
    /// - Returns: Nib
    static func nib() -> UINib

}

// MARK: - NibViewProtocol
extension NibViewProtocol {

    /// Gets view nib
    ///
    /// - Returns: Nib
    static func nib() -> UINib {
        let nibName = String(describing: self)
        let bundle = Bundle(for: self)

        return UINib(nibName: nibName,
                     bundle: bundle)
    }

}
