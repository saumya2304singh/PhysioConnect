//
//  FilterRow.swift
//  PhysioConnect
//
//  Created by user@8 on 17/11/25.
//

import Foundation
import UIKit

final class FilterRow: UIView {

    let titleLabel = UILabel()
    let dotView = UIView()

    init(title: String) {
        super.init(frame: .zero)

        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 15)
        titleLabel.textColor = .black

        dotView.backgroundColor = UIColor(hex: "1E6EF7")
        dotView.layer.cornerRadius = 8

        addSubview(titleLabel)
        addSubview(dotView)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        dotView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            dotView.widthAnchor.constraint(equalToConstant: 16),
            dotView.heightAnchor.constraint(equalToConstant: 16),
            dotView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dotView.centerYAnchor.constraint(equalTo: centerYAnchor),

            heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    required init?(coder: NSCoder) { fatalError() }
}
