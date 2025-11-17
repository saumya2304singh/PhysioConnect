//
//  ConfirmAppointmentViewController.swift
//  PhysioConnect
//
//  Created by user@8 on 16/11/25.
//

import UIKit

final class ConfirmAppointmentViewController: UIViewController {

    private let confirmView = ConfirmAppointmentView()
    
    // MARK: - Passed from previous screen
    var doctor: Doctor!
    var appointmentDate: Date!          // combined date + time
    var userLocation: String = "Unknown Location"

    override func loadView() {
        view = confirmView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true

        confirmView.backButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)

        fillDoctorDetails()
        fillAppointmentSummary()
        
        // Payment row taps
        confirmView.cardRow.isUserInteractionEnabled = true
        confirmView.upiRow.isUserInteractionEnabled = true
        confirmView.bankRow.isUserInteractionEnabled = true

        confirmView.cardRow.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(paymentSelected))
        )
        confirmView.upiRow.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(paymentSelected))
        )
        confirmView.bankRow.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(paymentSelected))
        )
    }

    // MARK: - Fill Doctor Card
    private func fillDoctorDetails() {
        confirmView.doctorCard.configure(with: doctor)
    }

    // MARK: - Fill Summary Card
    private func fillAppointmentSummary() {
        guard let appt = appointmentDate else { return }

        let df = DateFormatter()
        df.dateFormat = "EEE, dd MMM"

        let tf = DateFormatter()
        tf.dateFormat = "h:mm a"

        confirmView.dateLabel.text = df.string(from: appt)
        confirmView.timeLabel.text = tf.string(from: appt)
        confirmView.locationLabel.text = userLocation

        confirmView.sessionFeeTitleLabel.text = "Session Fee:"
        confirmView.sessionFeeValueLabel.text = "\(doctor.feePerHour) Rs/hr"
    }

    // MARK: - Back Button
    @objc private func backPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Payment Selected → Success Screen
    @objc private func paymentSelected() {
        let vc = SuccessAppointmentViewController()
        vc.doctor = doctor
        vc.appointmentDate = appointmentDate
        vc.userLocation = userLocation

        vc.modalPresentationStyle = .overFullScreen   // overlay on top
        vc.modalTransitionStyle = .crossDissolve      // simple fade, no fancy animation

        present(vc, animated: true)
    }

}
