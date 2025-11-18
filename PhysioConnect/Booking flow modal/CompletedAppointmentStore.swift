//
//  CompletedAppointmentStore.swift
//  PhysioConnect
//
//  Created by user@8 on 18/11/25.
//
import Foundation

final class CompletedAppointmentStore {
    
    static let shared = CompletedAppointmentStore()
    private init() { }
    
    private(set) var items: [AppointmentDetail] = []
    
    func add(_ appointment: AppointmentDetail) {
        items.append(appointment)
    }
}
