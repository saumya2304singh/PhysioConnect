//
//  AppointmentManager.swift
//  PhysioConnect
//
//  Created by user@8 on 17/11/25.
//

import Foundation

struct Appointment: Codable {
    let doctorName: String
    let doctorImage: String
    let date: Date
    let location: String
}

final class AppointmentManager {

    static let shared = AppointmentManager()

    private let key = "latestAppointment"

    private init() {}

    // Save appointment
    func save(_ appt: Appointment) {
        if let data = try? JSONEncoder().encode(appt) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    // Load appointment
    func load() -> Appointment? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(Appointment.self, from: data)
    }

    // Clear appointment
    func clear() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
