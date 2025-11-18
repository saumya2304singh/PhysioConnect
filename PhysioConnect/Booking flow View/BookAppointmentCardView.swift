//
//  BookAppointmentCardView.swift
//  PhysioConnect
//
//  Created by user@8 on 18/11/25.
//

import UIKit

final class BookAppointmentCardView: UIView {
    
    // MARK: - UI Elements
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Book home visits"
        lbl.font = .boldSystemFont(ofSize: 17)
        lbl.textColor = .black
        return lbl
    }()
    
    private let subtitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Get certified physiotherapy at your doorstep"
        lbl.font = .systemFont(ofSize: 13)
        lbl.textColor = UIColor.darkGray
        lbl.numberOfLines = 2
        return lbl
    }()
    
    let bookButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Book appointment", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor(hex: "3278F6")
        btn.layer.cornerRadius = 16
        btn.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        return btn
    }()
    
    var bookAction: (() -> Void)?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCard()
        setupLayout()
        setupActions()
    }
    required init?(coder: NSCoder) { fatalError() }
    
    
    // MARK: - Setup UI
    
    private func setupCard() {
        backgroundColor = .white
        layer.cornerRadius = 22
        layer.shadowOpacity = 0.12
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    
    private func setupLayout() {
        
        
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(bookButton)
        
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        bookButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            
            // Title
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 18),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            // Subtitle
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            // Button
            bookButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 12),
            bookButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            bookButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            bookButton.heightAnchor.constraint(equalToConstant: 36),
            bookButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    
    private func setupActions() {
        bookButton.addTarget(self, action: #selector(didTapBook), for: .touchUpInside)
    }
    
    @objc private func didTapBook() {
        bookAction?()
    }
}
