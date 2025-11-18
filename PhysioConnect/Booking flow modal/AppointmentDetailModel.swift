//
// AppointmentDetailModel.swift
//  PhysioConnect
//
//  Created by user@8 on 18/11/25.


import Foundation

struct AppointmentDetail {
    let id: UUID
    let doctor: Doctor
    let date: Date
    let location: String
    let status: String
    
    var notesKey: String {
        "appointment_notes_\(id.uuidString)"
    }
}
