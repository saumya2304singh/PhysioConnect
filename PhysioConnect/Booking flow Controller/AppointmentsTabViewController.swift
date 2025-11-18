//
//  AppointmentsTabViewController.swift
//  PhysioConnect
//
//  Created by user@8 on 18/11/25.


import UIKit

final class AppointmentsTabViewController: UIViewController {

    private let segmentedControl = UISegmentedControl(items: ["Upcoming", "Completed"])
    private let scrollView = UIScrollView()
    private let contentView = UIStackView()

    // Cards
    private let bookCard = BookAppointmentCardView()
    private var upcomingCard: UpcomingAppointmentCardView?   // 🔹 single upcoming card
    private var completedCards: [AppointmentCardView] = []   // keep your existing type
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.subviews.first?.backgroundColor = .clear
        view.backgroundColor = UIColor(hex: "E5F0FF")
    }

    // ---------------------------------------------------------
    // MARK: - Lifecycle
    // ---------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(hex: "E5F0FF")
        title = "Appointments"

        setupSegmentControl()
        setupScrollView()
        setupBookCard()
        setupNotifications()

        showUpcoming()   // initial state
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showUpcoming()   // refresh when tab becomes visible
    }

    // ---------------------------------------------------------
    // MARK: - Notifications
    // ---------------------------------------------------------
    private func setupNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appointmentUpdated(_:)),
            name: .appointmentUpdated,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appointmentCancelled(_:)),
            name: .appointmentCancelled,
            object: nil
        )
    }

    @objc private func appointmentUpdated(_ note: Notification) {
        showUpcoming()
    }

    @objc private func appointmentCancelled(_ note: Notification) {
        showUpcoming()
    }

    // ---------------------------------------------------------
    // MARK: - SEGMENT CONTROL
    // ---------------------------------------------------------
    private func setupSegmentControl() {
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = UIColor(hex: "DDE6F7")
        segmentedControl.selectedSegmentTintColor = UIColor(hex: "3278F6")
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.darkGray], for: .normal)

        view.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            segmentedControl.heightAnchor.constraint(equalToConstant: 36)
        ])

        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
    }

    // ---------------------------------------------------------
    // MARK: - SCROLL VIEW + STACK VIEW
    // ---------------------------------------------------------
    private func setupScrollView() {

        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = UIColor(hex: "E5F0FF")

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 12),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        scrollView.addSubview(contentView)
        contentView.axis = .vertical
        contentView.spacing = 16
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 12),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -40),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
    }

    // ---------------------------------------------------------
    // MARK: - BOOK CARD SETUP
    // ---------------------------------------------------------
    private func setupBookCard() {
        bookCard.bookAction = { [weak self] in
            guard let self = self else { return }
            let vc = DoctorListViewController()

            vc.onBookingComplete = { doctor, date in
                let appt = AppointmentDetail(
                    id: UUID(),
                    doctor: doctor,
                    date: date,
                    location: "Home Visit",
                    status: .confirmed
                )

                AppointmentStore.shared.currentAppointment = appt
                NotificationCenter.default.post(name: .appointmentUpdated, object: appt)
            }

            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    // ---------------------------------------------------------
    // MARK: - SHOW UPCOMING
    // ---------------------------------------------------------
    private func showUpcoming() {

        contentView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        if let appt = AppointmentStore.shared.currentAppointment {

            if upcomingCard == nil {
                let card = UpcomingAppointmentCardView()
                card.cancelAction = { [weak self] in
                    self?.handleCancel()
                }
                upcomingCard = card
            }

            // Configure with latest appointment
            if let card = upcomingCard {
                card.configure(appt: appt)

                // 🔹 ADD THIS: tap → open details screen
                card.viewDetailsAction = { [weak self] in
                    guard let self = self else { return }
                    let vc = AppointmentDetailsViewController()
                    vc.appointment = appt
                    self.navigationController?.pushViewController(vc, animated: true)
                }

                contentView.addArrangedSubview(card)
                contentView.setCustomSpacing(24, after: card)
            }

            contentView.addArrangedSubview(bookCard)

        } else {
            upcomingCard = nil
            contentView.addArrangedSubview(bookCard)
        }
    }
    
    
    private func openRebook(_ appt: AppointmentDetail) {
        let vc = DoctorListViewController()
        //vc.preselectedDoctor = appt.doctor   // OPTIONAL if you want
        navigationController?.pushViewController(vc, animated: true)
    }



    // ---------------------------------------------------------
    // MARK: - SHOW COMPLETED
    // ---------------------------------------------------------
    private func showCompleted() {

        // 1. Clear previous cards
        contentView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        // 2. Fetch completed items
        let items = CompletedAppointmentStore.shared.items

        // 3. If no records → show message
        if items.isEmpty {
            let label = UILabel()
            label.text = "No completed appointments"
            label.textAlignment = .center
            label.textColor = .gray
            label.font = .systemFont(ofSize: 16)
            contentView.addArrangedSubview(label)
            return
        }

        // 4. Display completed cards
        for appt in items {
            
            let card = CompletedAppointmentCardView()
            card.translatesAutoresizingMaskIntoConstraints = false
            card.configure(with: appt)

            // REBOOK → Start booking with same doctor
            card.rebookAction = { [weak self] in
                self?.openRebook(appt)
            }

            // REPORT → open report or PDF screen
            card.reportAction = {
                print("View Report for: \(appt.id)")
            }

            contentView.addArrangedSubview(card)

            // spacing between cards
            contentView.setCustomSpacing(20, after: card)
        }
    }


    // ---------------------------------------------------------
    // MARK: - Segment Switch
    // ---------------------------------------------------------
    @objc private func segmentChanged() {
        if segmentedControl.selectedSegmentIndex == 0 {
            showUpcoming()
        } else {
            showCompleted()
        }
    }

    // ---------------------------------------------------------
    // MARK: - Cancel Handler
    // ---------------------------------------------------------
    // ---------------------------------------------------------
    // MARK: - Cancel Handler
    // ---------------------------------------------------------
    private func handleCancel() {

        guard var appt = AppointmentStore.shared.currentAppointment else { return }

        // 1) Mark appointment as cancelled
        appt.status = .cancelled

        // 2) Move to completed list
        CompletedAppointmentStore.shared.add(appt)

        // 3) Clear current appointment (so Upcoming becomes empty)
        AppointmentStore.shared.currentAppointment = nil

        // 4) Notify listeners (Home, Upcoming, Completed)
        NotificationCenter.default.post(name: .appointmentCancelled, object: appt)
        NotificationCenter.default.post(name: .appointmentUpdated, object: appt)

        // 5) Alert user
        let alert = UIAlertController(
            title: "Appointment Cancelled",
            message: "Your appointment was moved to Completed.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)

        // 6) Refresh Upcoming tab UI
        showUpcoming()
    }


}


extension Notification.Name {
    static let appointmentUpdated = Notification.Name("appointmentUpdated")
    static let appointmentCancelled = Notification.Name("appointmentCancelled")
}
