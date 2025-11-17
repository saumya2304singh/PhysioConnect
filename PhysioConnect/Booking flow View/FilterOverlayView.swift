//
//  FilterOverlayView.swift
//  PhysioConnect
//
//  Created by user@8 on 17/11/25.
//

import Foundation
import UIKit

final class FiltersOverlayView: UIView {

    // MAIN rounded popup
    let sheetView = UIView()

    // Title + remove button
    let titleLabel = UILabel()
    let removeButton = UIButton(type: .system)

    // Section Cards
    let specialityCard = UIView()
    let genderCard = UIView()
    let distanceCard = UIView()
    let ratingCard = UIView()

    // Distance
    let distanceTitle = UILabel()
    let slider = UISlider()
    let distanceValueLabel = UILabel()

    // Bottom Buttons
    let cancelButton = UIButton(type: .system)
    let applyButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupUI() {
        backgroundColor = UIColor.clear

        // ------------------- SHEET VIEW -------------------
        addSubview(sheetView)
        sheetView.translatesAutoresizingMaskIntoConstraints = false
        sheetView.backgroundColor = UIColor(hex: "E9F2FF")
        sheetView.layer.cornerRadius = 32
        sheetView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        NSLayoutConstraint.activate([
            sheetView.leadingAnchor.constraint(equalTo: leadingAnchor),
            sheetView.trailingAnchor.constraint(equalTo: trailingAnchor),
            sheetView.bottomAnchor.constraint(equalTo: bottomAnchor),
            sheetView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.85)
        ])

        // ------------------- TITLE -------------------
        titleLabel.text = "Filters"
        titleLabel.font = .boldSystemFont(ofSize: 22)
        titleLabel.textAlignment = .center

        removeButton.setTitle("remove", for: .normal)
        removeButton.setTitleColor(.darkGray, for: .normal)
        removeButton.titleLabel?.font = .systemFont(ofSize: 14)

        sheetView.addSubview(titleLabel)
        sheetView.addSubview(removeButton)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        removeButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: sheetView.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: sheetView.centerXAnchor),

            removeButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            removeButton.trailingAnchor.constraint(equalTo: sheetView.trailingAnchor, constant: -16)
        ])

        // ------------------- SPECIALITY SECTION -------------------
        setupCard(specialityCard)
        sheetView.addSubview(specialityCard)

        let spTitle = sectionTitle("Speciality")
        let sp1 = FilterRow(title: "Knee Physiotherapy")
        let sp2 = FilterRow(title: "Neck Physiotherapy")
        let sp3 = FilterRow(title: "Shoulder Physiotherapy")

        specialityCard.addSubview(spTitle)
        specialityCard.addSubview(sp1)
        specialityCard.addSubview(sp2)
        specialityCard.addSubview(sp3)

        spTitle.translatesAutoresizingMaskIntoConstraints = false
        sp1.translatesAutoresizingMaskIntoConstraints = false
        sp2.translatesAutoresizingMaskIntoConstraints = false
        sp3.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            specialityCard.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            specialityCard.leadingAnchor.constraint(equalTo: sheetView.leadingAnchor, constant: 16),
            specialityCard.trailingAnchor.constraint(equalTo: sheetView.trailingAnchor, constant: -16),

            spTitle.topAnchor.constraint(equalTo: specialityCard.topAnchor, constant: 16),
            spTitle.leadingAnchor.constraint(equalTo: specialityCard.leadingAnchor, constant: 16),

            sp1.topAnchor.constraint(equalTo: spTitle.bottomAnchor, constant: 12),
            sp1.leadingAnchor.constraint(equalTo: spTitle.leadingAnchor),
            sp1.trailingAnchor.constraint(equalTo: specialityCard.trailingAnchor, constant: -16),

            sp2.topAnchor.constraint(equalTo: sp1.bottomAnchor, constant: 12),
            sp2.leadingAnchor.constraint(equalTo: sp1.leadingAnchor),
            sp2.trailingAnchor.constraint(equalTo: sp1.trailingAnchor),

            sp3.topAnchor.constraint(equalTo: sp2.bottomAnchor, constant: 12),
            sp3.leadingAnchor.constraint(equalTo: sp1.leadingAnchor),
            sp3.trailingAnchor.constraint(equalTo: sp1.trailingAnchor),
            sp3.bottomAnchor.constraint(equalTo: specialityCard.bottomAnchor, constant: -16)
        ])

        // ------------------- GENDER SECTION -------------------
        setupCard(genderCard)
        sheetView.addSubview(genderCard)

        let gTitle = sectionTitle("Gender Preference")
        let g1 = FilterRow(title: "Male")
        let g2 = FilterRow(title: "Female")
        let g3 = FilterRow(title: "Prefer not to say")

        [gTitle, g1, g2, g3].forEach { genderCard.addSubview($0); $0.translatesAutoresizingMaskIntoConstraints = false }

        NSLayoutConstraint.activate([
            genderCard.topAnchor.constraint(equalTo: specialityCard.bottomAnchor, constant: 16),
            genderCard.leadingAnchor.constraint(equalTo: specialityCard.leadingAnchor),
            genderCard.trailingAnchor.constraint(equalTo: specialityCard.trailingAnchor),

            gTitle.topAnchor.constraint(equalTo: genderCard.topAnchor, constant: 16),
            gTitle.leadingAnchor.constraint(equalTo: genderCard.leadingAnchor, constant: 16),

            g1.topAnchor.constraint(equalTo: gTitle.bottomAnchor, constant: 12),
            g1.leadingAnchor.constraint(equalTo: gTitle.leadingAnchor),
            g1.trailingAnchor.constraint(equalTo: gTitle.trailingAnchor),

            g2.topAnchor.constraint(equalTo: g1.bottomAnchor, constant: 12),
            g2.leadingAnchor.constraint(equalTo: g1.leadingAnchor),
            g2.trailingAnchor.constraint(equalTo: g1.trailingAnchor),

            g3.topAnchor.constraint(equalTo: g2.bottomAnchor, constant: 12),
            g3.leadingAnchor.constraint(equalTo: g1.leadingAnchor),
            g3.trailingAnchor.constraint(equalTo: g1.trailingAnchor),
            g3.bottomAnchor.constraint(equalTo: genderCard.bottomAnchor, constant: -16)
        ])

        // ------------------- DISTANCE SECTION -------------------
        setupCard(distanceCard)
        sheetView.addSubview(distanceCard)

        distanceTitle.text = "Distance"
        distanceTitle.font = .boldSystemFont(ofSize: 16)

        distanceValueLabel.text = "within 15 km"
        distanceValueLabel.font = .systemFont(ofSize: 14)
        distanceValueLabel.textColor = .darkGray

        slider.minimumValue = 1
        slider.maximumValue = 50
        slider.value = 15
        slider.tintColor = UIColor(hex: "1E6EF7")

        distanceCard.addSubview(distanceTitle)
        distanceCard.addSubview(distanceValueLabel)
        distanceCard.addSubview(slider)

        distanceTitle.translatesAutoresizingMaskIntoConstraints = false
        distanceValueLabel.translatesAutoresizingMaskIntoConstraints = false
        slider.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            distanceCard.topAnchor.constraint(equalTo: genderCard.bottomAnchor, constant: 16),
            distanceCard.leadingAnchor.constraint(equalTo: genderCard.leadingAnchor),
            distanceCard.trailingAnchor.constraint(equalTo: genderCard.trailingAnchor),

            distanceTitle.topAnchor.constraint(equalTo: distanceCard.topAnchor, constant: 16),
            distanceTitle.leadingAnchor.constraint(equalTo: distanceCard.leadingAnchor, constant: 16),

            distanceValueLabel.centerYAnchor.constraint(equalTo: distanceTitle.centerYAnchor),
            distanceValueLabel.trailingAnchor.constraint(equalTo: distanceCard.trailingAnchor, constant: -16),

            slider.topAnchor.constraint(equalTo: distanceTitle.bottomAnchor, constant: 16),
            slider.leadingAnchor.constraint(equalTo: distanceTitle.leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: distanceCard.trailingAnchor, constant: -16),
            slider.bottomAnchor.constraint(equalTo: distanceCard.bottomAnchor, constant: -16)
        ])


        // ------------------- BUTTONS -------------------
        sheetView.addSubview(cancelButton)
        sheetView.addSubview(applyButton)

        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        applyButton.translatesAutoresizingMaskIntoConstraints = false

        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.layer.cornerRadius = 22
        cancelButton.backgroundColor = .white
        cancelButton.setTitleColor(.black, for: .normal)

        applyButton.setTitle("Apply", for: .normal)
        applyButton.layer.cornerRadius = 22
        applyButton.backgroundColor = UIColor(hex: "1E6EF7")
        applyButton.setTitleColor(.white, for: .normal)

        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: distanceCard.bottomAnchor, constant: 20),
            cancelButton.leadingAnchor.constraint(equalTo: sheetView.leadingAnchor, constant: 20),
            cancelButton.widthAnchor.constraint(equalTo: sheetView.widthAnchor, multiplier: 0.42),
            cancelButton.heightAnchor.constraint(equalToConstant: 44),

            applyButton.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor),
            applyButton.trailingAnchor.constraint(equalTo: sheetView.trailingAnchor, constant: -20),
            applyButton.widthAnchor.constraint(equalTo: sheetView.widthAnchor, multiplier: 0.42),
            applyButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func setupCard(_ card: UIView) {
        card.layer.cornerRadius = 20
        card.backgroundColor = .white
        card.layer.shadowOpacity = 0.05
        card.layer.shadowRadius = 5
        card.layer.shadowOffset = .zero
        card.translatesAutoresizingMaskIntoConstraints = false
    }

    private func sectionTitle(_ text: String) -> UILabel {
        let lbl = UILabel()
        lbl.text = text
        lbl.font = .boldSystemFont(ofSize: 16)
        return lbl
    }
}
