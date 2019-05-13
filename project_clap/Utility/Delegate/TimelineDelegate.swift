import Foundation

protocol DiaryDelegate: AnyObject {
    func reloadData()
    func showTimelineIndicator()
    func hideTimelineIndicator()
}
