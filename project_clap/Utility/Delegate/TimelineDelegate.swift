import Foundation

protocol TimelineDelegate: AnyObject {
    func reloadData()
    func showTimelineIndicator()
    func hideTimelineIndicator()
}
