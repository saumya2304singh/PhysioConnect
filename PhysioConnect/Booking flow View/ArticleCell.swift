//
//  ArticleCell.swift
//  PhysioConnect
//
//  Created by user@8 on 12/11/25.
//

import UIKit

final class ArticleCell: UICollectionViewCell {
    let imageView = UIImageView()
    let title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 16
        contentView.layer.borderColor = UIColor(hex: "D4E3FE").cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.08
        contentView.layer.shadowRadius = 6
        contentView.layer.shadowOffset = CGSize(width: 0, height: 3)
        contentView.layer.masksToBounds = false
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        
        title.font = .systemFont(ofSize: 12, weight: .medium)
        title.textAlignment = .left
        title.numberOfLines = 2
        
        let stack = UIStackView(arrangedSubviews: [imageView, title])
        stack.axis = .vertical
        stack.spacing = 6
        
        contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imageView.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
