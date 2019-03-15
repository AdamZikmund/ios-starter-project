import UIKit

/// Dismiss button
@IBDesignable
class DismissButton: NibView {

    // MARK: Properties

    weak var delegate: DismissButtonDelegate?

    // MARK: Outlets

    @IBOutlet private var button: UIButton!

    // MARK: Inspectables

    @IBInspectable var color: UIColor = .white {
        didSet { didSetColor() }
    }

    @IBInspectable var title: String = "Button" {
        didSet { didSetTitle() }
    }

    // MARK: Actions

    @IBAction private func buttonPressed(sender: UIButton) {
        delegate?.dismissButtonPressed(button: self)
    }

}

// MARK: - Observers
extension DismissButton {

    private func didSetColor() {
        button.backgroundColor = color
    }

    private func didSetTitle() {
        button.setTitle(title, for: .normal)
    }

}
