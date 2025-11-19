//
//  ReviewCell.swift
//  PhysioConnect
//

import UIKit

final class ReviewCell: UITableViewCell {
    
    let containerView = UIView()
    let userImageView = UIImageView()
    let nameLabel = UILabel()
    let ratingLabel = UILabel()
    let commentLabel = UILabel()
    
    var isExpanded = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        // Card container
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 24
        containerView.layer.borderColor = UIColor(hex: "D4E3FE").cgColor
        containerView.layer.borderWidth = 1
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.06
        containerView.layer.shadowRadius = 4
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Image
        userImageView.layer.cornerRadius = 20
        userImageView.clipsToBounds = true
        userImageView.contentMode = .scaleAspectFill
        
        // Labels
        nameLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        ratingLabel.font = .systemFont(ofSize: 13)
        ratingLabel.textColor = .systemYellow
        
        commentLabel.font = .systemFont(ofSize: 13)
        commentLabel.textColor = .darkGray
        commentLabel.numberOfLines = 2
        
        
        [userImageView, nameLabel, ratingLabel, commentLabel].forEach {
            containerView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            
            userImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            userImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            userImageView.widthAnchor.constraint(equalToConstant: 40),
            userImageView.heightAnchor.constraint(equalToConstant: 40),
            
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            
            ratingLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            ratingLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            ratingLabel.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -12),
            
            commentLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 8),
            commentLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            commentLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            commentLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12)
        ])
    }
    
    func configure(with review: Review, expanded: Bool) {
        // Image
        if let imageName = review.imageName,
           let image = UIImage(named: imageName) {
            userImageView.image = image
        } else {
            userImageView.image = UIImage(named: "reviewPlaceholder") // or nil / any fallback
        }

        nameLabel.text = review.reviewerName
        ratingLabel.text = "⭐️ \(review.rating)"

        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 6
        paragraph.alignment = .left

        commentLabel.attributedText = NSAttributedString(
            string: review.comment,
            attributes: [
                .font: UIFont.systemFont(ofSize: 13),
                .foregroundColor: UIColor.darkGray,
                .paragraphStyle: paragraph
            ]
        )

        commentLabel.numberOfLines = expanded ? 0 : 2
        isExpanded = expanded
    }

}
