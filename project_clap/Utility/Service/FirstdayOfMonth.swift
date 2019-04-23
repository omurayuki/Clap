import Foundation

struct DateOperator {
    static func parseDate(_ str: String) -> Date {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy年MM月dd日"
        return dateFormat.date(from: str) ?? Date()
    }
    
    static func firstDayOfMonth(date: Date) -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return calendar.date(from: components)!
    }
}
