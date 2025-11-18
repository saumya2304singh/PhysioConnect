//
//  UpcomingAppointmentCardView.swift
//  PhysioConnect
//
//  Created by user@8 on 18/11/25.
//

import UIKit

final class UpcomingAppointmentCardView: UIView {

    // MARK: - Callbacks
    var cancelAction: (() -> Void)?
    var viewDetailsAction: (() -> Void)?

    // MARK: - UI Elements
    private let card = UIView()
    private let dateLabel = UILabel()

    private let doctorImage = UIImageView()
    private let nameLabel = UILabel()
    private let ratingLabel = UILabel()
    private let distanceLabel = UILabel()
    private let specializationLabel = UILabel()

    private let divider = UIView()
    private let feeTitleLabel = UILabel()
    private let feeLabel = UILabel()

    private let cancelButton = UIButton(type: .system)

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
        card.layer.cornerRadius = 20
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowOpacity = 0.05
        card.layer.shadowRadius = 8
        card.layer.shadowOffset = CGSize(width: 0, height: 3)

        addSubview(card)
        card.translatesAutoresizingMaskIntoConstraints = false

        // Date inside card
        dateLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        dateLabel.textColor = UIColor(hex: "2A2A2A")

        // Image
        doctorImage.layer.cornerRadius = 16
        doctorImage.clipsToBounds = true
        doctorImage.contentMode = .scaleAspectFill

        // Text styles
        nameLabel.font = .boldSystemFont(ofSize: 17)

        ratingLabel.font = .systemFont(ofSize: 13)
        ratingLabel.textColor = .darkGray

        distanceLabel.font = .systemFont(ofSize: 13)
        distanceLabel.textColor = .darkGray

        specializationLabel.font = .systemFont(ofSize: 13)
        specializationLabel.textColor = .black

        // Divider
        divider.backgroundColor = UIColor(hex: "E4E8F0")

        // Fee labels
        feeTitleLabel.font = .systemFont(ofSize: 13)
        feeTitleLabel.textColor = .darkGray
        feeTitleLabel.text = "Consultation Fees:"

        feeLabel.font = .systemFont(ofSize: 13, weight: .bold)
        feeLabel.textColor = UIColor(hex: "1E6EF7")

        // Cancel button
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.backgroundColor = UIColor(hex: "E95C59")
        cancelButton.layer.cornerRadius = 18
        cancelButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)

        // Add subviews to card
        [dateLabel,
         doctorImage, nameLabel, ratingLabel, distanceLabel, specializationLabel,
         divider, feeTitleLabel, feeLabel,
         cancelButton].forEach {
            card.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        // Whole card tappable
        let tap = UITapGestureRecognizer(target: self, action: #selector(cardTapped))
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }

    // MARK: - Layout
    private func setupLayout() {
        NSLayoutConstraint.activate([

            // Card container
            card.topAnchor.constraint(equalTo: topAnchor),
            card.leadingAnchor.constraint(equalTo: leadingAnchor),
            card.trailingAnchor.constraint(equalTo: trailingAnchor),
            card.bottomAnchor.constraint(equalTo: bottomAnchor),

            // Date inside card
            dateLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: 16),
            dateLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16),

            // Doctor image
            doctorImage.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
            doctorImage.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16),
            doctorImage.widthAnchor.constraint(equalToConstant: 110),
            doctorImage.heightAnchor.constraint(equalToConstant: 105),

            // Name
            nameLabel.topAnchor.constraint(equalTo: doctorImage.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: doctorImage.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16),

            // Rating
            ratingLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6),
            ratingLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),

            // Distance
            distanceLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 4),
            distanceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),

            // Specialization
            specializationLabel.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor, constant: 4),
            specializationLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),

            // ---------- NEW PART (Fee ABOVE divider) ----------
            feeTitleLabel.topAnchor.constraint(equalTo: specializationLabel.bottomAnchor, constant: 4),
            feeTitleLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),

            feeLabel.centerYAnchor.constraint(equalTo: feeTitleLabel.centerYAnchor),
            feeLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16),

            // Divider BELOW fee
            divider.topAnchor.constraint(equalTo: feeTitleLabel.bottomAnchor, constant: 16),
            divider.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
            divider.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16),
            divider.heightAnchor.constraint(equalToConstant: 1),

            // Cancel button
            cancelButton.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 16),
            cancelButton.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
            cancelButton.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16),
            cancelButton.heightAnchor.constraint(equalToConstant: 42),
            cancelButton.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -16)
        ])
    }


    // MARK: - Configure
    func configure(appt: AppointmentDetail) {
        // Date + time
        let df = DateFormatter()
        df.dateFormat = "MMMM dd, yyyy – h:mm a"
        dateLabel.text = df.string(from: appt.date)

        let doctor = appt.doctor

        doctorImage.image = UIImage(named: "doctor_placeholder")
        doctorImage.loadImage(from: doctor.imageURL)

        nameLabel.text = doctor.name
        ratingLabel.text = "⭐️ \(doctor.rating) | \(doctor.reviews) reviews"
        distanceLabel.text = doctor.distance       // or "Calculating…" if you want
        specializationLabel.text = doctor.specialization

        feeLabel.text = "₹\(doctor.feePerHour)/hr"
        // feeTitleLabel.text is already "Consultation Fees:"
    }

    // MARK: - Actions
    @objc private func cancelTapped() {
        cancelAction?()
    }

    @objc private func cardTapped() {
        viewDetailsAction?()
    }
}
