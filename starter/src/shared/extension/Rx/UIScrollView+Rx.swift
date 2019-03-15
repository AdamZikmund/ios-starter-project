import RxSwift
import RxCocoa
import RxSwiftExt

// MARK: - UIScrollView Rx extension
extension Reactive where Base: UIScrollView {

    var didScrollToBottom: ControlEvent<Void> {
        let events = delegate
            .methodInvoked(#selector(UIScrollViewDelegate.scrollViewDidEndDragging(_: willDecelerate:)))
            .map { arguments in
                arguments[0] as? UIScrollView
            }
            .unwrap()
            .map { scrollView -> Bool in
                let currentOffset = scrollView.contentOffset.y
                let maximumOffset = scrollView.contentSize.height - scrollView.bounds.size.height
                let bottomOffset: CGFloat = 20

                return maximumOffset - currentOffset <= bottomOffset
            }
            .filter { $0 }
            .map { _ in Void() }

        return ControlEvent(events: events)
    }

    var didScrollToRight: ControlEvent<Void> {
        let events = delegate
            .methodInvoked(#selector(UIScrollViewDelegate.scrollViewDidEndDragging(_: willDecelerate:)))
            .map { arguments in
                arguments[0] as? UIScrollView
            }
            .unwrap()
            .map { scrollView -> Bool in
                let currentOffset = scrollView.contentOffset.x
                let maximumOffset = scrollView.contentSize.width - scrollView.bounds.size.width
                let rightOffset: CGFloat = 20

                return maximumOffset - currentOffset <= rightOffset
            }
            .filter { $0 }
            .map { _ in Void() }

        return ControlEvent(events: events)
    }

}
