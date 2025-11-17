//
//  DoctorProfileCardView.swift
//  PhysioConnect
//

import UIKit

final class DoctorProfileCardView: UIView {

    let doctorImageView = UIImageView()
    let nameLabel = UILabel()
    let ratingLabel = UILabel()
    let distanceLabel = UILabel()
    let specializationLabel = UILabel()
    let feeTitleLabel = UILabel()
    let feeLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCard()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // ----------------------------------------------------
    // MARK: - Card UI Setup
    // ----------------------------------------------------
    private func setupCard() {
        backgroundColor = .white
        layer.cornerRadius = 24
        layer.borderWidth = 1
        layer.borderColor = UIColor(hex: "D4E3FE").cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.08
        layer.shadowRadius = 6
        layer.shadowOffset = CGSize(width: 0, height: 3)

        doctorImageView.layer.cornerRadius = 24
        doctorImageView.clipsToBounds = true
        doctorImageView.contentMode = .scaleAspectFill
        doctorImageView.backgroundColor = UIColor.systemGray5   // placeholder bg

        nameLabel.font = .boldSystemFont(ofSize: 17)
        ratingLabel.font = .systemFont(ofSize: 13)
        distanceLabel.font = .systemFont(ofSize: 13)
        specializationLabel.font = .systemFont(ofSize: 13)
        feeTitleLabel.font = .systemFont(ofSize: 13)
        feeLabel.font = .systemFont(ofSize: 13, weight: .bold)
        feeLabel.textColor = UIColor(hex: "1E6EF7")

        ratingLabel.textColor = .darkGray
        distanceLabel.textColor = .darkGray
        specializationLabel.textColor = .black
        feeTitleLabel.textColor = .darkGray
    }

    // ----------------------------------------------------
    // MARK: - Layout
    // ----------------------------------------------------
    private func setupLayout() {
        [
            doctorImageView, nameLabel, ratingLabel,
            distanceLabel, specializationLabel,
            feeTitleLabel, feeLabel
        ].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            doctorImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            doctorImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            doctorImageView.widthAnchor.constraint(equalToConstant: 110),
            doctorImageView.heightAnchor.constraint(equalToConstant: 110),

            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: doctorImageView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            ratingLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6),
            ratingLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),

            distanceLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 4),
            distanceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),

            specializationLabel.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor, constant: 4),
            specializationLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),

            feeTitleLabel.topAnchor.constraint(equalTo: specializationLabel.bottomAnchor, constant: 10),
            feeTitleLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),

            feeLabel.centerYAnchor.constraint(equalTo: feeTitleLabel.centerYAnchor),
            feeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            bottomAnchor.constraint(equalTo: feeTitleLabel.bottomAnchor, constant: 16)
        ])
    }

    // ----------------------------------------------------
    // MARK: - Configure with Model
    // ----------------------------------------------------
    func configure(with doctor: Doctor) {

        // Text fields
        nameLabel.text = doctor.name
        ratingLabel.text = "⭐️ \(doctor.rating) | \(doctor.reviews) reviews"
        distanceLabel.text = doctor.distance
        specializationLabel.text = doctor.specialization
        feeTitleLabel.text = "Consultation Fees:"
        feeLabel.text = "₹\(doctor.feePerHour)/hr"

        // Reset image first
        doctorImageView.image = UIImage(named: "doctor_placeholder")

        // Load image from Supabase URL
        doctorImageView.loadImage(from: doctor.imageURL)
    }
}
