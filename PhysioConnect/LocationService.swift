//
//  LocationService.swift
//  PhysioConnect
//
//  Created by user@8 on 14/11/25.
//


import Foundation
import CoreLocation

final class LocationService: NSObject, CLLocationManagerDelegate {

    static let shared = LocationService()

    private let manager = CLLocationManager()
    private(set) var lastLocation: CLLocation?
    private(set) var currentCity: String = "Chennai"

    /// Called whenever we get a new location
    /// (cityName, location)
    var onLocationUpdate: ((String, CLLocation?) -> Void)?

    override private init() {
        super.init()
        manager.delegate = self
    }

    func requestLocation() {
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
    }

    // MARK: - Delegate

    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lastLocation = location

        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, _ in
            let city = placemarks?.first?.locality ?? "Your area"
            self.currentCity = city
            self.onLocationUpdate?(city, location)
        }
    }

    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        print("Location error:", error.localizedDescription)
        onLocationUpdate?(currentCity, lastLocation)
    }
}
