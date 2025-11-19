//
//  AppointmentStore.swift
//  PhysioConnect
//
//  Created by user@8 on 18/11/25.
//
import Foundation

final class AppointmentStore {
    
    static let shared = AppointmentStore()
    private init() {}
    
    // The user's current booked appointment
    var currentAppointment: AppointmentDetail?
    func cancel() {
            currentAppointment = nil
        }
}
