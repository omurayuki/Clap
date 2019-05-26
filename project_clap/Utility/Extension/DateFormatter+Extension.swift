import Foundation
import UIKit

extension DateFormatter {
    //// can change static func
    func convertToMonthAndYears(_ date: Date?) -> String {
        guard let date = date else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        return formatter.string(from: date)
    }
    
    func convertToTime(_ date: Date?, second: Int = 1) -> String {
        guard let date = date else { return "" }
        let calcDate = NSDate(timeInterval: TimeInterval(second), since: date)
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        return formatter.string(from: calcDate as Date)
    }
    
    static func acquireCurrentTime() -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let time = formatter.string(from: now)
        return time
    }
    
    //// Calendarの日付を生成するための冗長な処理
    func generateBetweenDate(start: String, end: String) -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        let eventStartDateText = start
        let eventStartDate = formatter.date(from: eventStartDateText)
        let eventEndDateText = end
        let eventEndDate = formatter.date(from: eventEndDateText)
        guard let endDate = eventEndDate?.timeIntervalSince1970 else { return [String]() }
        guard let startDate = eventStartDate?.timeIntervalSince1970 else { return [String]() }
        let endDateIntType = Int(endDate)
        let startDateIntType = Int(startDate)
        let dateCount = (endDateIntType - startDateIntType) / (60 * 60 * 24)
        var array = [eventStartDateText]
        for date in 0...dateCount {
            let addingValue = date * (60 * 60 * 24)
            let addedDateValue = startDateIntType + addingValue
            let addedDateValueConvertToTimeInterval = TimeInterval(addedDateValue)
            let addedDateValueConvertToDateType = Date(timeIntervalSince1970: addedDateValueConvertToTimeInterval)
            let addedDateValueConvertToStringType: String = formatter.string(from: addedDateValueConvertToDateType)
            array.append(addedDateValueConvertToStringType)
        }
        return array
    }
}
