//
//  PhysiotherapistDetailView.swift
//  PhysioConnect
//
//  Created by user@8 on 13/11/25.
//

import UIKit

// ------------------------------------------------------------
// MARK: - ADVANCED STAT VIEW (ICON + TWO-LINE TEXT)
// ------------------------------------------------------------
final class AdvancedStatView: UIView {

    private let iconContainer = UIView()
    private let iconView = UIImageView()

    private let topLabel = UILabel()
    private let bottomLabel = UILabel()

    init(icon: String, topText: String, bottomText: String) {
        super.init(frame: .zero)
        setup(icon: icon, topText: topText, bottomText: bottomText)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private func setup(icon: String, topText: String, bottomText: String) {

        // Circle background
        iconContainer.backgroundColor = .white
        iconContainer.layer.cornerRadius = 16
        iconContainer.layer.shadowColor = UIColor.black.cgColor
        iconContainer.layer.shadowOpacity = 0.08
        iconContainer.layer.shadowRadius = 6
        iconContainer.layer.shadowOffset = CGSize(width: 0, height: 3)

        // Icon
        iconView.image = UIImage(systemName: icon)
        iconView.tintColor = UIColor(hex: "1E6EF7")
        iconView.contentMode = .scaleAspectFit

        // Text
        topLabel.text = topText
        topLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        topLabel.textAlignment = .center

        bottomLabel.text = bottomText
        bottomLabel.font = .systemFont(ofSize: 13)
        bottomLabel.textColor = .darkGray
        bottomLabel.textAlignment = .center

        // Stack
        let stack = UIStackView(arrangedSubviews: [iconContainer, topLabel, bottomLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 6

        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        iconContainer.translatesAutoresizingMaskIntoConstraints = false
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconContainer.addSubview(iconView)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),

            iconContainer.widthAnchor.constraint(equalToConstant: 40),
            iconContainer.heightAnchor.constraint(equalToConstant: 40),

            iconView.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 24),
            iconView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }

    // Update text dynamically
    func setValues(top: String, bottom: String) {
        topLabel.text = top
        bottomLabel.text = bottom
    }
}


// ------------------------------------------------------------
// MARK: - MAIN VIEW
// ------------------------------------------------------------
final class PhysiotherapistDetailView: UIView {

    // MARK: Header
    let headerContainer = UIView()
    let backButton = UIButton(type: .system)
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Physiotherapist Details"
        label.font = .boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        return label
    }()

    // MARK: Scroll Section
    let scrollView = UIScrollView()
    let contentView = UIView()

    // MARK: Doctor Card
    let doctorCard = DoctorProfileCardView()

    // MARK: Stats Section
    let patientsStat = AdvancedStatView(icon: "person.3.fill", topText: "0+", bottomText: "patients")
    let experienceStat = AdvancedStatView(icon: "medal.fill", topText: "0+", bottomText: "experience")

    // MARK: About Section
    let aboutTitle = UILabel()
    let aboutText = UILabel()
    let seeMoreButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("See More", for: .normal)
        btn.setTitleColor(UIColor(hex: "1E6EF7"), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
        return btn
    }()

    // MARK: Book Button
    let bookButton = UIButton(type: .system)
    

    // MARK: Reviews
    let reviewsTitle = UILabel()
    let seeAllButton = UIButton(type: .system)
    let reviewsTableView = UITableView()
    var reviewsTableHeightConstraint: NSLayoutConstraint!

    // ------------------------------------------------------------
    // MARK: Init
    // ------------------------------------------------------------
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hex: "E3F0FF")
        setupLayout()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }


    // ------------------------------------------------------------
    // MARK: Layout Setup
    // ------------------------------------------------------------
    private func setupLayout() {

        // HEADER
        addSubview(headerContainer)
        headerContainer.translatesAutoresizingMaskIntoConstraints = false

        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .black

        headerContainer.addSubview(backButton)
        headerContainer.addSubview(headerLabel)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            headerContainer.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerContainer.heightAnchor.constraint(equalToConstant: 50),

            backButton.leadingAnchor.constraint(equalTo: headerContainer.leadingAnchor, constant: 16),
            backButton.centerYAnchor.constraint(equalTo: headerContainer.centerYAnchor),

            headerLabel.centerXAnchor.constraint(equalTo: headerContainer.centerXAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: headerContainer.centerYAnchor)
        ])

        // SCROLL SECTION
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: headerContainer.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

        // DOCTOR CARD
        contentView.addSubview(doctorCard)
        doctorCard.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            doctorCard.topAnchor.constraint(equalTo: contentView.topAnchor),
            doctorCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            doctorCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])

        // STATS SECTION
        let statsStack = UIStackView(arrangedSubviews: [patientsStat, experienceStat])
        statsStack.axis = .horizontal
        statsStack.distribution = .fillEqually
        statsStack.alignment = .center
        statsStack.spacing = 16

        let statsContainer = UIView()
        statsContainer.backgroundColor = .clear
        statsContainer.layer.cornerRadius = 24
        statsContainer.layer.shadowColor = UIColor.black.cgColor
        statsContainer.layer.shadowOpacity = 0.08
        statsContainer.layer.shadowRadius = 6
        statsContainer.layer.shadowOffset = CGSize(width: 0, height: 3)

        contentView.addSubview(statsContainer)
        statsContainer.addSubview(statsStack)
        statsContainer.translatesAutoresizingMaskIntoConstraints = false
        statsStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            statsContainer.topAnchor.constraint(equalTo: doctorCard.bottomAnchor, constant: 12),
            statsContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            statsContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            statsContainer.heightAnchor.constraint(equalToConstant: 106),

            statsStack.topAnchor.constraint(equalTo: statsContainer.topAnchor, constant: 6),
            statsStack.leadingAnchor.constraint(equalTo: statsContainer.leadingAnchor, constant: 16),
            statsStack.trailingAnchor.constraint(equalTo: statsContainer.trailingAnchor, constant: -16),
            statsStack.bottomAnchor.constraint(equalTo: statsContainer.bottomAnchor, constant: -6)
        ])

        // ABOUT SECTION
        aboutTitle.text = "About"
        aboutTitle.font = .boldSystemFont(ofSize: 20)

        aboutText.font = .systemFont(ofSize: 13)
        aboutText.textColor = .darkGray
        aboutText.numberOfLines = 3
        aboutText.textAlignment = .justified

        contentView.addSubview(aboutTitle)
        contentView.addSubview(aboutText)
        contentView.addSubview(seeMoreButton)

        aboutTitle.translatesAutoresizingMaskIntoConstraints = false
        aboutText.translatesAutoresizingMaskIntoConstraints = false
        seeMoreButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            aboutTitle.topAnchor.constraint(equalTo: statsContainer.bottomAnchor, constant: 20),
            aboutTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            aboutText.topAnchor.constraint(equalTo: aboutTitle.bottomAnchor, constant: 8),
            aboutText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            aboutText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            seeMoreButton.topAnchor.constraint(equalTo: aboutText.bottomAnchor, constant: 4),
            seeMoreButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])

        // BOOK BUTTON
        bookButton.setTitle("Book Appointment", for: .normal)
        bookButton.backgroundColor = UIColor(hex: "1E6EF7")
        bookButton.setTitleColor(.white, for: .normal)
        bookButton.layer.cornerRadius = 24

        contentView.addSubview(bookButton)
        bookButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            bookButton.topAnchor.constraint(equalTo: seeMoreButton.bottomAnchor, constant: 20),
            bookButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bookButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            bookButton.heightAnchor.constraint(equalToConstant: 48)
        ])

        // REVIEWS
        reviewsTitle.text = "Reviews"
        reviewsTitle.font = .boldSystemFont(ofSize: 20)

        seeAllButton.setTitle("See All", for: .normal)
        seeAllButton.titleLabel?.font = .systemFont(ofSize: 13)

        contentView.addSubview(reviewsTitle)
        contentView.addSubview(seeAllButton)
        contentView.addSubview(reviewsTableView)

        reviewsTitle.translatesAutoresizingMaskIntoConstraints = false
        seeAllButton.translatesAutoresizingMaskIntoConstraints = false
        reviewsTableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            reviewsTitle.topAnchor.constraint(equalTo: bookButton.bottomAnchor, constant: 20),
            reviewsTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            seeAllButton.centerYAnchor.constraint(equalTo: reviewsTitle.centerYAnchor),
            seeAllButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            reviewsTableView.topAnchor.constraint(equalTo: reviewsTitle.bottomAnchor, constant: 12),
            reviewsTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            reviewsTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            reviewsTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50)
        ])

        reviewsTableHeightConstraint = reviewsTableView.heightAnchor.constraint(equalToConstant: 1)
        reviewsTableHeightConstraint.isActive = true

        reviewsTableView.register(ReviewCell.self, forCellReuseIdentifier: "ReviewCell")
        reviewsTableView.isScrollEnabled = false
        reviewsTableView.separatorStyle = .none
        reviewsTableView.backgroundColor = .clear
    }
}
