//
//  AppointmentDetailView.swift
//  PhysioConnect
//
//  Created by user@8 on 18/11/25.
//

import UIKit

final class AppointmentDetailsView: UIView {
    
    // ---------- HEADER ----------
    let backButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        btn.tintColor = .black
        return btn
    }()
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Appointment Details"
        lbl.font = .boldSystemFont(ofSize: 22)
        lbl.textAlignment = .center
        return lbl
    }()
    
    // ---------- DOCTOR CARD ----------
    let doctorCard = DoctorProfileCardView()
    
    
    // ---------- SUMMARY CARD ----------
    let summaryCard: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 18
        v.layer.shadowOpacity = 0.12
        v.layer.shadowRadius = 8
        v.layer.shadowOffset = CGSize(width: 0, height: 4)
        return v
    }()
    
    let dateTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Date & Time"
        lbl.font = .systemFont(ofSize: 15, weight: .semibold)
        return lbl
    }()
    
    // FIXED NAME
    let dateValueLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "-"
        lbl.font = .systemFont(ofSize: 15)
        return lbl
    }()
    
    let locationTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Location"
        lbl.font = .systemFont(ofSize: 15, weight: .semibold)
        return lbl
    }()
    
    // FIXED NAME
    let locationValueLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "-"
        lbl.font = .systemFont(ofSize: 15)
        return lbl
    }()
    
    let statusTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Status"
        lbl.font = .systemFont(ofSize: 15, weight: .semibold)
        return lbl
    }()
    
    // FIXED NAME
    let statusValueLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Confirmed"
        lbl.textColor = UIColor(hex: "2ECC71")
        lbl.font = .systemFont(ofSize: 15)
        return lbl
    }()
    
    
    // ---------- NOTES CARD ----------
    let notesCard: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 18
        v.layer.shadowOpacity = 0.12
        v.layer.shadowRadius = 8
        v.layer.shadowOffset = CGSize(width: 0, height: 4)
        return v
    }()
    
    let notesTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Session Notes"
        lbl.font = .systemFont(ofSize: 16, weight: .semibold)
        return lbl
    }()
    
    let notesTextView: UITextView = {
        let tv = UITextView()
        tv.font = .systemFont(ofSize: 15)
        tv.layer.cornerRadius = 12
        tv.backgroundColor = UIColor(hex: "EFF4FF")
        tv.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        return tv
    }()
    
    let clearNotesButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        btn.tintColor = .darkGray
        return btn
    }()
    
    
    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hex: "E5F0FF")
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    // ---------------------------------------------------------
    // MARK: - CONFIGURE VIEW WITH MODEL (ADDED)
    // ---------------------------------------------------------
    func configure(with model: AppointmentDetail) {
        // Use if you want to apply default UI styling or future extensions.
        // Controller is already populating data; this remains optional.
    }
    
    
    // ---------------------------------------------------------
    // MARK: - LAYOUT
    // ---------------------------------------------------------
    private func setupLayout() {
        
        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(doctorCard)
        addSubview(summaryCard)
        addSubview(notesCard)
        
        [dateTitle, dateValueLabel,
         locationTitle, locationValueLabel,
         statusTitle, statusValueLabel].forEach {
            summaryCard.addSubview($0)
        }
        
        [notesTitle, notesTextView, clearNotesButton].forEach {
            notesCard.addSubview($0)
        }
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        doctorCard.translatesAutoresizingMaskIntoConstraints = false
        summaryCard.translatesAutoresizingMaskIntoConstraints = false
        notesCard.translatesAutoresizingMaskIntoConstraints = false
        
        dateTitle.translatesAutoresizingMaskIntoConstraints = false
        dateValueLabel.translatesAutoresizingMaskIntoConstraints = false
        locationTitle.translatesAutoresizingMaskIntoConstraints = false
        locationValueLabel.translatesAutoresizingMaskIntoConstraints = false
        statusTitle.translatesAutoresizingMaskIntoConstraints = false
        statusValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        notesTitle.translatesAutoresizingMaskIntoConstraints = false
        notesTextView.translatesAutoresizingMaskIntoConstraints = false
        clearNotesButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            // HEADER
            backButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 4),
            
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            
            // DOCTOR CARD
            doctorCard.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            doctorCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            doctorCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            doctorCard.heightAnchor.constraint(equalToConstant: 140),
            
            // SUMMARY CARD
            summaryCard.topAnchor.constraint(equalTo: doctorCard.bottomAnchor, constant: 20),
            summaryCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            summaryCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            summaryCard.heightAnchor.constraint(equalToConstant: 120),
            
            dateTitle.topAnchor.constraint(equalTo: summaryCard.topAnchor, constant: 16),
            dateTitle.leadingAnchor.constraint(equalTo: summaryCard.leadingAnchor, constant: 16),
            
            dateValueLabel.centerYAnchor.constraint(equalTo: dateTitle.centerYAnchor),
            dateValueLabel.trailingAnchor.constraint(equalTo: summaryCard.trailingAnchor, constant: -16),
            
            locationTitle.topAnchor.constraint(equalTo: dateTitle.bottomAnchor, constant: 16),
            locationTitle.leadingAnchor.constraint(equalTo: dateTitle.leadingAnchor),
            
            locationValueLabel.centerYAnchor.constraint(equalTo: locationTitle.centerYAnchor),
            locationValueLabel.trailingAnchor.constraint(equalTo: dateValueLabel.trailingAnchor),
            
            statusTitle.topAnchor.constraint(equalTo: locationTitle.bottomAnchor, constant: 16),
            statusTitle.leadingAnchor.constraint(equalTo: dateTitle.leadingAnchor),
            
            statusValueLabel.centerYAnchor.constraint(equalTo: statusTitle.centerYAnchor),
            statusValueLabel.trailingAnchor.constraint(equalTo: dateValueLabel.trailingAnchor),
            
            // NOTES CARD
            notesCard.topAnchor.constraint(equalTo: summaryCard.bottomAnchor, constant: 20),
            notesCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            notesCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            notesCard.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            notesTitle.topAnchor.constraint(equalTo: notesCard.topAnchor, constant: 16),
            notesTitle.leadingAnchor.constraint(equalTo: notesCard.leadingAnchor, constant: 16),
            
            clearNotesButton.centerYAnchor.constraint(equalTo: notesTitle.centerYAnchor),
            clearNotesButton.trailingAnchor.constraint(equalTo: notesCard.trailingAnchor, constant: -16),
            
            notesTextView.topAnchor.constraint(equalTo: notesTitle.bottomAnchor, constant: 12),
            notesTextView.leadingAnchor.constraint(equalTo: notesCard.leadingAnchor, constant: 16),
            notesTextView.trailingAnchor.constraint(equalTo: notesCard.trailingAnchor, constant: -16),
            notesTextView.bottomAnchor.constraint(equalTo: notesCard.bottomAnchor, constant: -16),
            notesTextView.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
}
