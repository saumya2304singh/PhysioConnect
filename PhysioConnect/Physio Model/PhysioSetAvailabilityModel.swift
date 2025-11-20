import Foundation

struct PhysioSetAvailabilityModel {
    let days: [DayAvailability]

    struct DayAvailability {
        let day: String
        let time: String?   // nil = No availability
    }
}
