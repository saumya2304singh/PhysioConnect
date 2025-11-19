//
//  Doctor.swift
//  PhysioConnect
//


import Foundation
import CoreLocation

struct Doctor: Identifiable {
    let id: UUID
    let name: String
    let rating: Double
    let reviews: Int
    let specialization: String
    let feePerHour: String        // formatted string: "₹1000/hr"
    let imageURL: String          // Supabase public URL or CDN URL
    let latitude: Double?
    let longitude: Double?

    // This is the formatted label you show in UI
    var distance: String          // e.g. "within 5 km"

    /// Update distance string using user location + stored lat/long
    mutating func updateDistance(from userLocation: CLLocation) {
        guard let lat = latitude, let lon = longitude else { return }

        let physioLocation = CLLocation(latitude: lat, longitude: lon)
        let meters = userLocation.distance(from: physioLocation)

        let km = meters / 1000.0
        let rounded = (km < 1) ? 1 : Int(round(km))
        distance = "within \(rounded) km"
    }
}
