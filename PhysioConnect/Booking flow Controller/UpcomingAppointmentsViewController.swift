//
//  UpcomingAppointmentsViewController.swift
//  PhysioConnect
//
//  Created by user@8 on 18/11/25.
//

import UIKit

final class UpcomingAppointmentsViewController: UIViewController {
    
    // MARK: - Views
    private let scrollView = UIScrollView()
    private let content = UIView()
    
    // MARK: - Data
    /// Current upcoming appointment (if any)
    var currentAppointment: AppointmentDetail? {
        didSet {
            reloadUI()
        }
    }
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hex: "E4F0FF")
        setupLayout()

        // Load latest state from store
        currentAppointment = AppointmentStore.shared.currentAppointment
        
        // Listen for updates from the booking flow
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appointmentUpdated(_:)),
            name: .appointmentUpdated,
            object: nil
        )
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Always refresh when the tab is opened
        currentAppointment = AppointmentStore.shared.currentAppointment
    }
    
    
    // MARK: - Notification Handler
    @objc private func appointmentUpdated(_ note: Notification) {
        if let appt = note.object as? AppointmentDetail {
            self.currentAppointment = appt    // triggers reloadUI()
        } else {
            self.currentAppointment = AppointmentStore.shared.currentAppointment
        }
    }
    
    
    // MARK: - Layout Setup
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(content)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        content.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // keep inside safe area
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            content.topAnchor.constraint(equalTo: scrollView.topAnchor),
            content.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            content.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            content.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    
    // MARK: - UI Reload
    private func reloadUI() {
        // Remove old UI
        content.subviews.forEach { $0.removeFromSuperview() }
        
        var lastBottom = content.topAnchor
        
        
        // ----------------------------------------------------
        // 1) If upcoming appointment exists → show appointment card
        // ----------------------------------------------------
        if let appointment = currentAppointment {
            
            //let card = AppointmentCardView(type: .upcoming)
            //card.translatesAutoresizingMaskIntoConstraints = false
            //card.configure(with: appointment)
            let card = UpcomingAppointmentCardView()
            card.configure(appt: appointment)
            
            card.viewDetailsAction = { [weak self] in
                guard let self = self else { return }
                let vc = AppointmentDetailsViewController()
                vc.appointment = appointment
                self.navigationController?.pushViewController(vc, animated: true)
            }


            card.cancelAction = { [weak self] in
                self?.cancelAppointment()
            }
            
            content.addSubview(card)
            
            NSLayoutConstraint.activate([
                card.topAnchor.constraint(equalTo: lastBottom, constant: 20),
                card.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 16),
                card.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -16),
                card.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -16)

            ])
            
            lastBottom = card.bottomAnchor
        }
        
        
        // ----------------------------------------------------
        // 2) SHOW BOOK APPOINTMENT CARD ALWAYS
        // ----------------------------------------------------
        let bookCard = BookAppointmentCardView()
        bookCard.translatesAutoresizingMaskIntoConstraints = false
        
        bookCard.bookAction = { [weak self] in
            self?.openBooking()
        }
        
        content.addSubview(bookCard)
        
        NSLayoutConstraint.activate([
            bookCard.topAnchor.constraint(equalTo: lastBottom, constant: 20),
            bookCard.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 16),
            bookCard.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -16),
            bookCard.heightAnchor.constraint(equalToConstant: 150),
            bookCard.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -30)
        ])
        
        
        // Ensure layout updates properly
        view.layoutIfNeeded()
        scrollView.layoutIfNeeded()
    }
    
    
    // MARK: - Navigation
    private func openBooking() {
        let vc = DoctorListViewController()
        
        // When appointment completes:
        vc.onBookingComplete = { doctor, date in
            
            let newAppt = AppointmentDetail(
                id: UUID(),
                doctor: doctor,
                date: date,
                location: "Home Visit",
                status: .confirmed
            )
            
            // Save globally
            AppointmentStore.shared.currentAppointment = newAppt
            
            // Notify all tabs
            NotificationCenter.default.post(name: .appointmentUpdated, object: newAppt)
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    private func openDetails(_ appt: AppointmentDetail) {
        let vc = AppointmentDetailsViewController()
        vc.appointment = appt
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func cancelAppointment() {

        // 1️⃣ Remove it from global store
        AppointmentStore.shared.cancel()

        // 2️⃣ Notify every screen
        NotificationCenter.default.post(name: .appointmentCancelled, object: nil)
        NotificationCenter.default.post(name: .appointmentUpdated, object: nil)

        // 3️⃣ Show message (toast or alert)
        let alert = UIAlertController(title: "Appointment Cancelled",
                                      message: "Your appointment has been cancelled successfully.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)

        // 4️⃣ Reload UI in this screen
        currentAppointment = nil
    }
    
    @objc private func reloadAfterCancellation() {
        currentAppointment = nil
    }


}
