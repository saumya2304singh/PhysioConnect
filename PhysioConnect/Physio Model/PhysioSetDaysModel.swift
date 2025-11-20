import Foundation

struct PhysioSetDaysModel {
    var selectedDays: Set<String> = []
    var startDate: Date?
    var endDate: Date?
    var noEndDate: Bool = false
    var reminderEnabled: Bool = false
    var reminderTime: Date?
}
