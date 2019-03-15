import UIKit

/// Base class for loading view from nib file
@IBDesignable
class NibView: UIView, NibViewProtocol {

    // MARK: Properties

    weak private(set) var view: UIView!

    /// Initalizes view with frame
    ///
    /// - Parameter frame: Frame size
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    /// Initializes view from coder
    ///
    /// - Parameter aDecoder: Coder
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    /// Setups inner view from file owner root hiearchy
    func setup() {
        let view = viewFromNib()

        self.addSubview(view)
        self.view = view

        view.frame = bounds
        view.autoresizingMask = [
                .flexibleWidth,
                .flexibleHeight
        ]

        addSubview(view)
    }

    /// Gets view from nib
    ///
    /// - Returns: View
    private func viewFromNib() -> UIView {
        guard let view = type(of: self).nib()
            .instantiate(withOwner: self, options: nil)[0] as? UIView else {
                fatalError("Invalid nib file hierarchy")
        }

        return view
    }

}
