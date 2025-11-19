//
//  AppointmentCardView.swift
//  PhysioConnect
//
//  Created by user@8 on 18/11/25.
//
import UIKit

enum AppointmentCardType {
    case upcoming
    case completed
}

final class AppointmentCardView: UIView {

    private let type: AppointmentCardType
    
    // Doctor card
    private let doctorCard = DoctorProfileCardView()

    // Date label
    private let dateLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 15, weight: .semibold)
        lbl.textColor = .darkGray
        return lbl
    }()
    
    // --- UPCOMING BUTTON (Red Cancel) ---
    private let cancelButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Cancel", for: .normal)
        btn.backgroundColor = UIColor(hex: "FF6B6B")
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 16
        return btn
    }()
    
    // --- COMPLETED BUTTONS ---
    private let rebookButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Re-book", for: .normal)
        btn.backgroundColor = UIColor(hex: "3278F6")
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 16
        return btn
    }()
    
    private let reportButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("View Report", for: .normal)
        btn.backgroundColor = UIColor.white
        btn.setTitleColor(UIColor(hex: "3278F6"), for: .normal)
        btn.layer.cornerRadius = 16
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor(hex: "3278F6").cgColor
        return btn
    }()
    
    // Callbacks
    var cancelAction: (() -> Void)?
    var viewDetailsAction: (() -> Void)?       // For upcoming card
    var rebookAction: (() -> Void)?
    var reportAction: (() -> Void)?
    
    // MARK: - Init
    init(type: AppointmentCardType) {
        self.type = type
        super.init(frame: .zero)
        setupCard()
    }
    required init?(coder: NSCoder) { fatalError() }

    // ----------------------------------------------------
    // MARK: - Configure with model
    // ----------------------------------------------------
    func configure(with model: AppointmentDetail) {
        
        // Doctor info
        doctorCard.configure(with: model.doctor)
        
        // Date formatting
        let df = DateFormatter()
        df.dateFormat = "MMM dd, yyyy – hh:mm a"
        dateLabel.text = df.string(from: model.date)
    }
    
    // ----------------------------------------------------
    // MARK: - Layout
    // ----------------------------------------------------
    private func setupCard() {
        
        backgroundColor = .white
        layer.cornerRadius = 20
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 6
        layer.shadowOffset = CGSize(width: 0, height: 3)
        
        addSubview(dateLabel)
        addSubview(doctorCard)
        
        // Bottom buttons depending on type
        if type == .upcoming {
            addSubview(cancelButton)
            cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        } else {
            addSubview(rebookButton)
            addSubview(reportButton)
            rebookButton.addTarget(self, action: #selector(rebookTapped), for: .touchUpInside)
            reportButton.addTarget(self, action: #selector(reportTapped), for: .touchUpInside)
        }
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        doctorCard.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        rebookButton.translatesAutoresizingMaskIntoConstraints = false
        reportButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            doctorCard.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 12),
            doctorCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            doctorCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            doctorCard.heightAnchor.constraint(equalToConstant: 90)
        ])

        if type == .upcoming {
            NSLayoutConstraint.activate([
                cancelButton.topAnchor.constraint(equalTo: doctorCard.bottomAnchor, constant: 12),
                cancelButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
                cancelButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
                cancelButton.heightAnchor.constraint(equalToConstant: 40),
                cancelButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
            ])
        } else {
            NSLayoutConstraint.activate([
                rebookButton.topAnchor.constraint(equalTo: doctorCard.bottomAnchor, constant: 12),
                rebookButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
                rebookButton.widthAnchor.constraint(equalToConstant: 120),
                rebookButton.heightAnchor.constraint(equalToConstant: 40),
                
                reportButton.centerYAnchor.constraint(equalTo: rebookButton.centerYAnchor),
                reportButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
                reportButton.widthAnchor.constraint(equalToConstant: 120),
                reportButton.heightAnchor.constraint(equalToConstant: 40),
                
                reportButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
            ])
        }
    }
    
    // ----------------------------------------------------
    // MARK: - Actions
    // ----------------------------------------------------
    @objc private func cancelTapped() { cancelAction?() }
    @objc private func rebookTapped() { rebookAction?() }
    @objc private func reportTapped() { reportAction?() }
}
