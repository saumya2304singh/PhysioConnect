//
//  DateAndTimeSelectionViewController.swift
//  PhysioConnect
//
//  Created by user@8 on 16/11/25.
//

import UIKit
import CoreLocation

final class DateAndTimeSelectionViewController: UIViewController, CLLocationManagerDelegate {
    
    // Callback up to DoctorDetail → DoctorList → Home
    var onBookingComplete: ((Doctor, Date) -> Void)?
    
    var passedDoctor: Doctor!
    var selectedDate: Date = Date()
    var selectedTime: Date = Date()
    var currentAddress: String = "Fetching location..."

    private let locationManager = CLLocationManager()

    // MARK: - Header UI
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Book Appointment"
        lbl.textAlignment = .center
        lbl.font = .boldSystemFont(ofSize: 22)
        return lbl
    }()
    
    private let backButton = UIButton(type: .system)
    
    // MARK: - Date & Time UI
    private let container = UIView()
    private let calendarPicker = UIDatePicker()
    private let timePicker = UIDatePicker()
    
    // MARK: - Confirm Button
    let confirmButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Confirm", for: .normal)
        btn.backgroundColor = UIColor(hex: "1E6EF7")
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 24
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowRadius = 6
        btn.layer.shadowOffset = CGSize(width: 0, height: 3)
        return btn
    }()
    

    // MARK: - View Load
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true

        view.backgroundColor = UIColor(hex: "E3F0FF")

        setupUI()
        setupLocation()
    }


    // MARK: - LOCATION
    private func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {

        guard let loc = locations.first else { return }

        let geo = CLGeocoder()
        geo.reverseGeocodeLocation(loc) { placemarks, error in
            guard let place = placemarks?.first else { return }

            let area = place.subLocality ?? ""
            let city = place.locality ?? ""
            let state = place.administrativeArea ?? ""

            self.currentAddress = "\(area), \(city), \(state)"
        }
    }


    // MARK: - UI Setup
    private func setupUI() {
        
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)

        view.addSubview(backButton)
        view.addSubview(titleLabel)

        backButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor)
        ])
        
        container.backgroundColor = .white
        container.layer.cornerRadius = 20
        container.layer.shadowOpacity = 0.15
        container.layer.shadowRadius = 8
        container.layer.shadowOffset = CGSize(width: 0, height: 4)

        view.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        calendarPicker.datePickerMode = .date
        calendarPicker.preferredDatePickerStyle = .inline
        calendarPicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)

        container.addSubview(calendarPicker)
        calendarPicker.translatesAutoresizingMaskIntoConstraints = false
        
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .compact
        timePicker.addTarget(self, action: #selector(timeChanged(_:)), for: .valueChanged)

        container.addSubview(timePicker)
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            calendarPicker.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            calendarPicker.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            calendarPicker.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),

            timePicker.topAnchor.constraint(equalTo: calendarPicker.bottomAnchor, constant: 24),
            timePicker.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            timePicker.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            timePicker.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16)
        ])
        
        view.addSubview(confirmButton)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.addTarget(self, action: #selector(confirmTapped), for: .touchUpInside)

        NSLayoutConstraint.activate([
            confirmButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            confirmButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }


    // MARK: - Date & Time Handlers
    @objc private func dateChanged(_ sender: UIDatePicker) {
        selectedDate = sender.date
    }

    @objc private func timeChanged(_ sender: UIDatePicker) {
        selectedTime = sender.date
    }


    // MARK: - Back Action
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }

    // MARK: - Confirm Action
    @objc private func confirmTapped() {

        let combined = mergeDateAndTime(date: selectedDate, time: selectedTime)

        let confirmVC = ConfirmAppointmentViewController()
        confirmVC.doctor = passedDoctor
        confirmVC.appointmentDate = combined
        confirmVC.userLocation = currentAddress

        // Callback up the chain
        confirmVC.onBookingComplete = { [weak self] doctor, date in
            self?.onBookingComplete?(doctor, date)
        }

        navigationController?.pushViewController(confirmVC, animated: true)
    }

    private func mergeDateAndTime(date: Date, time: Date) -> Date {
        let cal = Calendar.current
        let d = cal.dateComponents([.year, .month, .day], from: date)
        let t = cal.dateComponents([.hour, .minute], from: time)

        var merged = DateComponents()
        merged.year = d.year
        merged.month = d.month
        merged.day = d.day
        merged.hour = t.hour
        merged.minute = t.minute

        return cal.date(from: merged) ?? Date()
    }
}
