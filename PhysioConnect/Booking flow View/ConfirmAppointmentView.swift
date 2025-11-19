//
//  ConfirmAppointmentView.swift
//  PhysioConnect
//
//  Created by user@8 on 16/11/25.
//

import UIKit

final class ConfirmAppointmentView: UIView {

    // MARK: - Header
    let backButton = UIButton(type: .system)
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Confirm Appointment"
        lbl.font = .boldSystemFont(ofSize: 22)
        return lbl
    }()

    // MARK: - ScrollView
    let scrollView = UIScrollView()
    let contentView = UIView()

    // MARK: - Doctor Card
    let doctorCard = DoctorProfileCardView()

    // MARK: - Summary Card
    let summaryCard = UIView()
    let dateLabel = UILabel()
    let timeLabel = UILabel()
    let locationLabel = UILabel()

    // NEW → Session Fee Title + Value
    let sessionFeeTitleLabel = UILabel()
    let sessionFeeValueLabel = UILabel()

    // MARK: - Payment Card
    let paymentCard = UIView()
    let cardRow = PaymentRow(icon: "creditcard.fill", text: "Credit/Debit Card")
    let upiRow = PaymentRow(icon: "indianrupeesign.circle.fill", text: "UPI")
    let bankRow = PaymentRow(icon: "building.columns.circle.fill", text: "Net Banking")

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hex: "E3F0FF")
        setupUI()
    }

    required init?(coder: NSCoder) { fatalError() }

    // MARK: - UI Setup
    private func setupUI() {

        // -------------------------
        // HEADER
        // -------------------------
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .black

        addSubview(backButton)
        addSubview(titleLabel)

        backButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 6),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor)
        ])


        // -------------------------
        // SCROLL VIEW
        // -------------------------
        addSubview(scrollView)
        scrollView.addSubview(contentView)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])


        // -------------------------
        // DOCTOR CARD
        // -------------------------
        contentView.addSubview(doctorCard)
        doctorCard.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            doctorCard.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            doctorCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            doctorCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])


        // -------------------------
        // SUMMARY CARD
        // -------------------------
        configureCard(summaryCard)
        contentView.addSubview(summaryCard)
        summaryCard.translatesAutoresizingMaskIntoConstraints = false

        // Default Styles
        [dateLabel, timeLabel, locationLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.font = .systemFont(ofSize: 15)
        }

        // Session Fee Title
        sessionFeeTitleLabel.text = "Session Fee:"
        sessionFeeTitleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        sessionFeeTitleLabel.textColor = .black
        sessionFeeTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        // Session Fee Value
        sessionFeeValueLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        sessionFeeValueLabel.textColor = .systemBlue
        sessionFeeValueLabel.textAlignment = .right
        sessionFeeValueLabel.translatesAutoresizingMaskIntoConstraints = false

        [dateLabel, timeLabel, locationLabel, sessionFeeTitleLabel, sessionFeeValueLabel]
            .forEach { summaryCard.addSubview($0) }

        NSLayoutConstraint.activate([
            summaryCard.topAnchor.constraint(equalTo: doctorCard.bottomAnchor, constant: 16),
            summaryCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            summaryCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            dateLabel.topAnchor.constraint(equalTo: summaryCard.topAnchor, constant: 16),
            dateLabel.leadingAnchor.constraint(equalTo: summaryCard.leadingAnchor, constant: 16),

            timeLabel.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: summaryCard.trailingAnchor, constant: -16),

            locationLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 12),
            locationLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),

            sessionFeeTitleLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 16),
            sessionFeeTitleLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),

            sessionFeeValueLabel.centerYAnchor.constraint(equalTo: sessionFeeTitleLabel.centerYAnchor),
            sessionFeeValueLabel.trailingAnchor.constraint(equalTo: summaryCard.trailingAnchor, constant: -16),
            sessionFeeValueLabel.bottomAnchor.constraint(equalTo: summaryCard.bottomAnchor, constant: -16)
        ])


        // -------------------------
        // PAYMENT OPTIONS CARD
        // -------------------------
        configureCard(paymentCard)
        contentView.addSubview(paymentCard)
        paymentCard.translatesAutoresizingMaskIntoConstraints = false

        let stack = UIStackView(arrangedSubviews: [cardRow, upiRow, bankRow])
        stack.axis = .vertical
        stack.spacing = 0
        stack.distribution = .fillEqually

        paymentCard.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            paymentCard.topAnchor.constraint(equalTo: summaryCard.bottomAnchor, constant: 16),
            paymentCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            paymentCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            paymentCard.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),

            stack.topAnchor.constraint(equalTo: paymentCard.topAnchor),
            stack.leadingAnchor.constraint(equalTo: paymentCard.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: paymentCard.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: paymentCard.bottomAnchor)
        ])
    }

    // Reusable Card Styling
    private func configureCard(_ view: UIView) {
        view.backgroundColor = .white
        view.layer.cornerRadius = 22
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.08
        view.layer.shadowRadius = 6
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
    }
}
