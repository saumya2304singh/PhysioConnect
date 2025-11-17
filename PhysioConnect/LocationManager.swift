//
//  LocationManager.swift
//  PhysioConnect
//
//  Created by user@8 on 15/11/25.
//
import Foundation
import CoreLocation

final class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    private let manager = CLLocationManager()
    
    private(set) var userLocation: CLLocation?

    private override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }

    func requestLocation() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last
        manager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("❌ Location error:", error)
    }
}

func calculateDistance(from: CLLocation, toLat: Double, toLng: Double) -> Double {
    let doctorLocation = CLLocation(latitude: toLat, longitude: toLng)
    return from.distance(from: doctorLocation) / 1000.0   // in KM
}
