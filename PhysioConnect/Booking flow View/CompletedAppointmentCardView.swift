//
//  CompletedAppointmentCardView.swift
//  PhysioConnect
//
//  Created by user@8 on 18/11/25.
//

import UIKit

final class CompletedAppointmentCardView: UIView {
    
    // MARK: - Callbacks
    var rebookAction: (() -> Void)?
    var reportAction: (() -> Void)?
    
    // MARK: - UI Elements
    private let card = UIView()
    private let dateLabel = UILabel()
    
    private let doctorImage = UIImageView()
    private let nameLabel = UILabel()
    private let ratingLabel = UILabel()
    private let distanceLabel = UILabel()
    private let specializationLabel = UILabel()
    
    private let feeTitleLabel = UILabel()
    private let feeLabel = UILabel()
    private let divider = UIView()
    
    private let rebookButton = UIButton(type: .system)
    private let reportButton = UIButton(type: .system)
    
    private let cancelledLabel = UILabel()

    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UI Setup
    private func setupUI() {
        
        // Card container
        card.backgroundColor = .white
        card.layer.cornerRadius = 22
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowOpacity = 0.06
        card.layer.shadowOffset = CGSize(width: 0, height: 4)
        card.layer.shadowRadius = 10
        addSubview(card)
        card.translatesAutoresizingMaskIntoConstraints = false
        
        // Date inside card
        dateLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        dateLabel.textColor = UIColor(hex: "2A2A2A")
        card.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Doctor Image
        doctorImage.contentMode = .scaleAspectFill
        doctorImage.layer.cornerRadius = 20
        doctorImage.clipsToBounds = true
        doctorImage.backgroundColor = UIColor.systemGray5
        card.addSubview(doctorImage)
        doctorImage.translatesAutoresizingMaskIntoConstraints = false
        
        // Labels
        nameLabel.font = .boldSystemFont(ofSize: 17)
        ratingLabel.font = .systemFont(ofSize: 13)
        ratingLabel.textColor = .darkGray
        distanceLabel.font = .systemFont(ofSize: 13)
        distanceLabel.textColor = .darkGray
        specializationLabel.font = .systemFont(ofSize: 13)
        specializationLabel.textColor = .black
        
        feeTitleLabel.font = .systemFont(ofSize: 13)
        feeTitleLabel.textColor = .darkGray
        feeTitleLabel.text = "Consultation fees:"
        
        feeLabel.font = .systemFont(ofSize: 13, weight: .bold)
        feeLabel.textColor = UIColor(hex: "1E6EF7")
        
        [nameLabel, ratingLabel, distanceLabel, specializationLabel,
         feeTitleLabel, feeLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            card.addSubview($0)
        }
        
        // Divider
        divider.backgroundColor = UIColor(hex: "E4E8F0")
        card.addSubview(divider)
        divider.translatesAutoresizingMaskIntoConstraints = false
        
        // Buttons
        setupButton(rebookButton, title: "Re-book", bg: UIColor(hex: "3278F6"), textColor: .white)
        setupButton(reportButton, title: "View Report", bg: .white,
                    textColor: UIColor(hex: "3278F6"), border: true)
        
        card.addSubview(rebookButton)
        card.addSubview(reportButton)
        rebookButton.translatesAutoresizingMaskIntoConstraints = false
        reportButton.translatesAutoresizingMaskIntoConstraints = false
        
        rebookButton.addTarget(self, action: #selector(rebookTapped), for: .touchUpInside)
        reportButton.addTarget(self, action: #selector(reportTapped), for: .touchUpInside)
        
        // Cancelled Label
        cancelledLabel.text = "Appointment Cancelled"
        cancelledLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        cancelledLabel.textColor = UIColor(hex: "E95C59")
        cancelledLabel.textAlignment = .center
        cancelledLabel.isHidden = true
        card.addSubview(cancelledLabel)
        cancelledLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func setupButton(_ btn: UIButton, title: String,
                             bg: UIColor, textColor: UIColor, border: Bool = false) {
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(textColor, for: .normal)
        btn.backgroundColor = bg
        btn.layer.cornerRadius = 14
        btn.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        if border {
            btn.layer.borderWidth = 1
            btn.layer.borderColor = UIColor(hex: "3278F6").cgColor
        }
    }

    
    
    // MARK: - Layout
    private func setupLayout() {
        
        NSLayoutConstraint.activate([
            // Card fills entire component
            card.topAnchor.constraint(equalTo: topAnchor),
            card.leadingAnchor.constraint(equalTo: leadingAnchor),
            card.trailingAnchor.constraint(equalTo: trailingAnchor),
            card.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            // Date inside card
            dateLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: 16),
            dateLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            doctorImage.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16),
            doctorImage.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
            doctorImage.widthAnchor.constraint(equalToConstant: 95),
            doctorImage.heightAnchor.constraint(equalToConstant: 95),
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: doctorImage.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: doctorImage.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16),
            
            ratingLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6),
            ratingLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            distanceLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 4),
            distanceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            specializationLabel.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor, constant: 4),
            specializationLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            feeTitleLabel.topAnchor.constraint(equalTo: specializationLabel.bottomAnchor, constant: 4),
            feeTitleLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            feeLabel.centerYAnchor.constraint(equalTo: feeTitleLabel.centerYAnchor),
            feeLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            divider.topAnchor.constraint(equalTo: feeTitleLabel.bottomAnchor, constant: 16),
            divider.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
            divider.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16),
            divider.heightAnchor.constraint(equalToConstant: 1),
        ])
        
        NSLayoutConstraint.activate([
            rebookButton.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 16),
            rebookButton.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
            rebookButton.widthAnchor.constraint(equalToConstant: 120),
            rebookButton.heightAnchor.constraint(equalToConstant: 36),
            
            reportButton.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 16),
            reportButton.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16),
            reportButton.widthAnchor.constraint(equalToConstant: 140),
            reportButton.heightAnchor.constraint(equalToConstant: 36),
        ])
        
        NSLayoutConstraint.activate([
            cancelledLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 16),
            cancelledLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
            cancelledLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16),
            cancelledLabel.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -16)
        ])
    }
    
    
    // MARK: - Configure
    func configure(with appt: AppointmentDetail) {
        
        // Date formatting
        let df = DateFormatter()
        df.dateFormat = "MMMM dd, yyyy – h:mm a"
        dateLabel.text = df.string(from: appt.date)
        
        let doc = appt.doctor
        
        doctorImage.image = UIImage(named: "doctor_placeholder")
        doctorImage.loadImage(from: doc.imageURL)
        
        nameLabel.text = doc.name
        ratingLabel.text = "⭐️ \(doc.rating) | \(doc.reviews) reviews"
        distanceLabel.text = doc.distance
        specializationLabel.text = doc.specialization
        feeLabel.text = "₹\(doc.feePerHour)/hr"
        
        if appt.status == .cancelled {
            rebookButton.isHidden = true
            reportButton.isHidden = true
            cancelledLabel.isHidden = false
        } else {
            rebookButton.isHidden = false
            reportButton.isHidden = false
            cancelledLabel.isHidden = true
        }
    }
    
    
    // MARK: - Actions
    @objc private func rebookTapped() {
        rebookAction?()
    }
    
    @objc private func reportTapped() {
        reportAction?()
    }
}
