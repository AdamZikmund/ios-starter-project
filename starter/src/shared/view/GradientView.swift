import UIKit

/// Linear gradient view
@IBDesignable
class GradientView: UIView {

    // MARK: Inspectables

    @IBInspectable var startColor: UIColor = .blue {
        didSet { colorDidSet() }
    }

    @IBInspectable var endColor: UIColor = .red {
        didSet { colorDidSet() }
    }

    // MARK: Properties

    private var gradient: CGGradient?

    // MARK: Rendering

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard let gradient = gradient,
            let context = UIGraphicsGetCurrentContext() else {
                return
        }

        let start = CGPoint(x: bounds.midX, y: bounds.minY)
        let end = CGPoint(x: bounds.midX, y: bounds.maxY)
        let options = CGGradientDrawingOptions()

        context
            .drawLinearGradient(gradient,
                                start: start,
                                end: end,
                                options: options)
    }

    /// Updates gradient when color did set
    private func colorDidSet() {
        let colorsSpace = CGColorSpaceCreateDeviceRGB()
        let colors = [startColor.cgColor,
                      endColor.cgColor] as CFArray
        let locations: [CGFloat] = [0.0, 1.0]

        gradient = CGGradient(colorsSpace: colorsSpace,
                              colors: colors,
                              locations: UnsafePointer(locations))

        setNeedsDisplay()
    }

}
