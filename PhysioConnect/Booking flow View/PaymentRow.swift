//
//  PaymentRow.swift
//  PhysioConnect
//
//  Created by user@8 on 16/11/25.
//
import UIKit
final class PaymentRow: UIView {

    init(icon: String, text: String) {
        super.init(frame: .zero)

        let iconView = UIImageView(image: UIImage(systemName: icon))
        iconView.tintColor = UIColor(hex: "1E6EF7")
        iconView.contentMode = .scaleAspectFit

        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 16)

        let divider = UIView()
        divider.backgroundColor = UIColor(hex: "E9E9E9")

        let hstack = UIStackView(arrangedSubviews: [iconView, label])
        hstack.axis = .horizontal
        hstack.spacing = 12
        hstack.alignment = .center

        addSubview(hstack)
        addSubview(divider)

        hstack.translatesAutoresizingMaskIntoConstraints = false
        divider.translatesAutoresizingMaskIntoConstraints = false
        iconView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 28),
            iconView.heightAnchor.constraint(equalToConstant: 28),

            hstack.topAnchor.constraint(equalTo: topAnchor, constant: 14),
            hstack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            hstack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            hstack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14),

            divider.heightAnchor.constraint(equalToConstant: 1),
            divider.leadingAnchor.constraint(equalTo: leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: trailingAnchor),
            divider.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) { fatalError() }
}
