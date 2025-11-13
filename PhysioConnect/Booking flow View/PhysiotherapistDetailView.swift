//
//  PhysiotherapistDetailView.swift
//  PhysioConnect
//
//  Created by user@8 on 13/11/25.
//

import UIKit

final class PhysiotherapistDetailView: UIView {

    // MARK: - Header (STATIC, not scrolling)
    let headerContainer = UIView()
    let backButton = UIButton(type: .system)
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Physiotherapist Details"
        label.font = .boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        return label
    }()

    // MARK: - ScrollView
    let scrollView = UIScrollView()
    let contentView = UIView()

    // MARK: - Doctor Card
    let doctorCard = UIView()
    let doctorImageView = UIImageView()
    let nameLabel = UILabel()
    let ratingLabel = UILabel()
    let distanceLabel = UILabel()
    let specializationLabel = UILabel()

    // Consultation Fee Row
    let feeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Consultation Fees:"
        label.font = .systemFont(ofSize: 13)
        label.textColor = .darkGray
        return label
    }()

    let feeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.textColor = UIColor(hex: "1E6EF7")
        return label
    }()

    // MARK: - Stats Card
    let statsCard = UIView()
    let patientsStat = StatView(icon: "person.3.fill", title: "2,000+ patients")
    let experienceStat = StatView(icon: "clock.fill", title: "10+ yrs exp.")
    //let ratingStat = StatView(icon: "star.fill", title: "5.0 rating")
    //let reviewsStat = StatView(icon: "text.bubble.fill", title: "1,872 reviews")

    // MARK: - About Section
    let aboutTitle = UILabel()
    let aboutText = UILabel()
    let seeMoreButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("See More", for: .normal)
        btn.setTitleColor(UIColor(hex: "1E6EF7"), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
        return btn
    }()

    // MARK: - Book Button
    let bookButton = UIButton(type: .system)

    // MARK: - Reviews
    let reviewsTitle = UILabel()
    let seeAllButton = UIButton(type: .system)
    let reviewsTableView = UITableView()

    // Dynamic height
    var reviewsTableHeightConstraint: NSLayoutConstraint!

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hex: "E3F0FF")
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: ----------------------------------------
    // MARK: FULL LAYOUT SETUP
    // MARK: ----------------------------------------

    private func setupLayout() {

        // -------------------------------------------------
        // STATIC HEADER (NOT inside scroll view)
        // -------------------------------------------------
        addSubview(headerContainer)
        headerContainer.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.backgroundColor = .clear


        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .black
        headerContainer.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false

        headerContainer.addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            headerContainer.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerContainer.heightAnchor.constraint(equalToConstant: 50),

            backButton.centerYAnchor.constraint(equalTo: headerContainer.centerYAnchor),
            backButton.leadingAnchor.constraint(equalTo: headerContainer.leadingAnchor, constant: 16),

            headerLabel.centerYAnchor.constraint(equalTo: headerContainer.centerYAnchor),
            headerLabel.centerXAnchor.constraint(equalTo: headerContainer.centerXAnchor)
        ])

        // -------------------------------------------------
        // SCROLL VIEW CONTENT
        // -------------------------------------------------
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

        // -------------------------------------------------
        // DOCTOR CARD
        // -------------------------------------------------
        configureCard(doctorCard)
        contentView.addSubview(doctorCard)
        doctorCard.translatesAutoresizingMaskIntoConstraints = false
        doctorCard.layer.cornerRadius = 24

        doctorImageView.layer.cornerRadius = 24
        doctorImageView.clipsToBounds = true
        doctorImageView.contentMode = .scaleAspectFill

        nameLabel.font = .boldSystemFont(ofSize: 17)
        ratingLabel.font = .systemFont(ofSize: 13)
        ratingLabel.textColor = .darkGray
        distanceLabel.font = .systemFont(ofSize: 13)
        distanceLabel.textColor = .darkGray
        specializationLabel.font = .systemFont(ofSize: 13)
        specializationLabel.textColor = .darkGray

        let doctorStack = UIStackView(arrangedSubviews: [
            nameLabel,
            ratingLabel,
            distanceLabel,
            specializationLabel
        ])
        doctorStack.axis = .vertical
        doctorStack.spacing = 6
        doctorStack.alignment = .leading

        doctorCard.addSubview(doctorImageView)
        doctorCard.addSubview(doctorStack)
        doctorCard.addSubview(feeTitleLabel)
        doctorCard.addSubview(feeLabel)

        doctorImageView.translatesAutoresizingMaskIntoConstraints = false
        doctorStack.translatesAutoresizingMaskIntoConstraints = false
        feeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        feeLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            doctorCard.topAnchor.constraint(equalTo: contentView.topAnchor),
            doctorCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            doctorCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            doctorImageView.leadingAnchor.constraint(equalTo: doctorCard.leadingAnchor, constant: 16),
            doctorImageView.topAnchor.constraint(equalTo: doctorCard.topAnchor, constant: 17),
            doctorImageView.widthAnchor.constraint(equalToConstant: 110),
            doctorImageView.heightAnchor.constraint(equalToConstant: 110),

            doctorStack.topAnchor.constraint(equalTo: doctorCard.topAnchor, constant: 18),
            doctorStack.leadingAnchor.constraint(equalTo: doctorImageView.trailingAnchor, constant: 16),
            doctorStack.trailingAnchor.constraint(equalTo: doctorCard.trailingAnchor, constant: -16),

            feeTitleLabel.topAnchor.constraint(equalTo: doctorStack.bottomAnchor, constant: 6),
            feeTitleLabel.leadingAnchor.constraint(equalTo: doctorStack.leadingAnchor),
            feeTitleLabel.bottomAnchor.constraint(equalTo: doctorCard.bottomAnchor, constant: -20),

            feeLabel.centerYAnchor.constraint(equalTo: feeTitleLabel.centerYAnchor),
            feeLabel.trailingAnchor.constraint(equalTo: doctorCard.trailingAnchor, constant: -16)
        ])

        // -------------------------------------------------
        // STATS CARD
        // -------------------------------------------------
        configureCard(statsCard)
        contentView.addSubview(statsCard)
        statsCard.translatesAutoresizingMaskIntoConstraints = false
        statsCard.backgroundColor = .white
        statsCard.layer.cornerRadius = 24

        // Create only 2 StatViews
        let patientsStat = StatView(icon: "person.3.fill", title: "2,000+ patients")
        let experienceStat = StatView(icon: "clock.fill", title: "10+ yrs exp.")

        let statsStack = UIStackView(arrangedSubviews: [patientsStat, experienceStat])
        statsStack.axis = .horizontal
        statsStack.distribution = .fillEqually
        statsStack.alignment = .center
        statsStack.spacing = 8

        statsCard.addSubview(statsStack)
        statsStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            statsCard.topAnchor.constraint(equalTo: doctorCard.bottomAnchor, constant: 20),
            statsCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            statsCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            statsCard.heightAnchor.constraint(equalToConstant: 70),
            
            statsStack.topAnchor.constraint(equalTo: statsCard.topAnchor, constant: 8),
            statsStack.leadingAnchor.constraint(equalTo: statsCard.leadingAnchor, constant: 16),
            statsStack.trailingAnchor.constraint(equalTo: statsCard.trailingAnchor, constant: -16),
            statsStack.bottomAnchor.constraint(equalTo: statsCard.bottomAnchor, constant: -8)
        ])


        // -------------------------------------------------
        // ABOUT SECTION
        // -------------------------------------------------
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
            aboutTitle.topAnchor.constraint(equalTo: statsCard.bottomAnchor, constant: 20),
            aboutTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            aboutText.topAnchor.constraint(equalTo: aboutTitle.bottomAnchor, constant: 8),
            aboutText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            aboutText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            seeMoreButton.topAnchor.constraint(equalTo: aboutText.bottomAnchor, constant: 4),
            seeMoreButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])

        // -------------------------------------------------
        // BOOK BUTTON
        // -------------------------------------------------
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

        // -------------------------------------------------
        // REVIEWS
        // -------------------------------------------------
        reviewsTitle.text = "Reviews"
        reviewsTitle.font = .boldSystemFont(ofSize: 20)

        seeAllButton.setTitle("See All", for: .normal)
        seeAllButton.setTitleColor(.darkGray, for: .normal)
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
            reviewsTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])

        reviewsTableHeightConstraint = reviewsTableView.heightAnchor.constraint(equalToConstant: 1)
        reviewsTableHeightConstraint.isActive = true

        reviewsTableView.register(ReviewCell.self, forCellReuseIdentifier: "ReviewCell")
        reviewsTableView.isScrollEnabled = false
        reviewsTableView.backgroundColor = .clear
        reviewsTableView.separatorStyle = .none
        reviewsTableView.rowHeight = UITableView.automaticDimension
        reviewsTableView.estimatedRowHeight = 130
    }

    // MARK: - Helpers
    private func configureCard(_ view: UIView) {
        view.backgroundColor = .white
        view.layer.cornerRadius = 24
        view.layer.borderColor = UIColor(hex: "D4E3FE").cgColor
        view.layer.borderWidth = 1
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.08
        view.layer.shadowRadius = 6
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
    }
}

//
//  StatView.swift
//

final class StatView: UIView {
    init(icon: String, title: String) {
        super.init(frame: .zero)

        let iv = UIImageView(image: UIImage(systemName: icon))
        iv.tintColor = UIColor(hex: "1E6EF7")
        iv.contentMode = .scaleAspectFit

        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .center
        label.textColor = .darkGray

        let stack = UIStackView(arrangedSubviews: [iv, label])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 4

        addSubview(stack)
        iv.translatesAutoresizingMaskIntoConstraints = false
        stack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            iv.heightAnchor.constraint(equalToConstant: 20),
            iv.widthAnchor.constraint(equalToConstant: 20),

            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
