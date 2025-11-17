//
//  SuccessAppointmentViewController.swift
//  PhysioConnect
//
//  Created by user@8 on 17/11/25.
//

import UIKit

final class SuccessAppointmentViewController: UIViewController {
    
    // Passed in
    var doctor: Doctor!
    var appointmentDate: Date!
    var userLocation: String = ""
    
    // Dimmed background
    private let dimView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.black.withAlphaComponent(0.35)
        return v
    }()
    
    // White popup card
    private let popupView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 28
        v.layer.masksToBounds = false
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.15
        v.layer.shadowRadius = 12
        v.layer.shadowOffset = CGSize(width: 0, height: 6)
        return v
    }()
    
    // Blue circle icon
    private let iconContainer: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(hex: "1E6EF7")
        v.layer.cornerRadius = 44 / 2
        v.clipsToBounds = true
        return v
    }()
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "checkmark"))
        iv.tintColor = .white
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Congratulations!"
        lbl.font = .boldSystemFont(ofSize: 22)
        lbl.textAlignment = .center
        return lbl
    }()
    
    private let messageLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 15)
        lbl.textAlignment = .center
        lbl.textColor = .darkGray
        return lbl
    }()
    
    private let doneButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Done", for: .normal)
        btn.backgroundColor = UIColor(hex: "1E6EF7")
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 24
        btn.titleLabel?.font = .boldSystemFont(ofSize: 17)
        return btn
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Transparent background so underlying screen is visible
        view.backgroundColor = .clear
        
        setupLayout()
        fillContent()
    }
    
    
    // MARK: - Layout
    
    private func setupLayout() {
        view.addSubview(dimView)
        view.addSubview(popupView)
        
        dimView.translatesAutoresizingMaskIntoConstraints = false
        popupView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dimView.topAnchor.constraint(equalTo: view.topAnchor),
            dimView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            popupView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            popupView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            popupView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
        
        // Icon
        popupView.addSubview(iconContainer)
        iconContainer.translatesAutoresizingMaskIntoConstraints = false
        
        iconContainer.addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Title, message, button
        [titleLabel, messageLabel, doneButton].forEach {
            popupView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            iconContainer.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 32),
            iconContainer.centerXAnchor.constraint(equalTo: popupView.centerXAnchor),
            iconContainer.widthAnchor.constraint(equalToConstant: 64),
            iconContainer.heightAnchor.constraint(equalToConstant: 64),
            
            iconImageView.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 26),
            iconImageView.heightAnchor.constraint(equalToConstant: 26),
            
            titleLabel.topAnchor.constraint(equalTo: iconContainer.bottomAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -24),
            
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            messageLabel.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 24),
            messageLabel.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -24),
            
            doneButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 24),
            doneButton.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 40),
            doneButton.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -40),
            doneButton.heightAnchor.constraint(equalToConstant: 48),
            doneButton.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -24)
        ])
        
        doneButton.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
    }
    
    
    // MARK: - Content
    
    private func fillContent() {
        guard let doctor = doctor, let date = appointmentDate else { return }
        
        let df = DateFormatter()
        df.dateFormat = "MMMM dd, yyyy"
        
        let tf = DateFormatter()
        tf.dateFormat = "h:mm a"
        
        let dateString = df.string(from: date)
        let timeString = tf.string(from: date)
        
        messageLabel.text =
        """
        Your appointment with \(doctor.name)
        at \(userLocation)
        is confirmed for \(dateString),
        at \(timeString).
        """
    }
    
    
    // MARK: - Actions
    
    @objc private func doneTapped() {
        // Dismiss popup and return to root booking screen
        dismiss(animated: true)
    }
}
