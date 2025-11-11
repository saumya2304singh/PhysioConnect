//
//  LandingHomeScreenViewController.swift
//  PhysioConnect
//
//  Created by user@8 on 11/11/25.
//

import UIKit

// MARK: - LandingHomeScreenViewController
// Programmatic Home screen: scrollable + cards + collections + animated progress.

class LandingHomeScreenViewController: UIViewController {
    
    
    // MARK: - Dummy Data
    private let videoImages = ["vid1", "vid2", "vid3", "vid4", "vid5"]

    private let articlesData: [(image: String, title: String)] = [
        ("art1", "5 Stretches for Lower Back Pain"),
        ("art2", "Posture Tips for Desk Workers"),
        ("art3", "How to Avoid Shoulder Stiffness"),
        ("art4", "When to See a Physiotherapist"),
        ("art5", "The Science of Muscle Recovery")
    ]



    // MARK: Scroll container
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    // MARK: Header
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Chennai"
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .darkGray
        return label
    }()
    
    private let locationIcon: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "mappin.and.ellipse"))
        iv.tintColor = .systemBlue
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    private let homeTitle: UILabel = {
        let label = UILabel()
        label.text = "Home"
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()

    private let profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "person.circle.fill"), for: .normal)
        button.tintColor = .black
        return button
    }()

    // MARK: Card 1 – Book appointment
    private let bookCard = UIView()
    private let cardImageView = UIImageView(image: UIImage(named: "doc1"))
    private let cardTitle = UILabel()
    private let cardSubtitle = UILabel()
    private let bookButton = UIButton(type: .system)

    // MARK: Card 2 – Video exercises
    private var videoCollectionView: UICollectionView!

    // MARK: Card 3 – Progress tracker
    private let progressCard = UIView()
    private let progressTitle = UILabel()
    private let progressCircle = CircularProgressView(progress: 0.0) // start at 0, we animate later
    private let adherenceLabel = UILabel()
    private let weekSegment = UISegmentedControl(items: ["W1", "W2", "W3", "W4"])

    // MARK: Card 4 – Redeem code (gradient)
    private let redeemCard = UIView()
    private let redeemLabel = UILabel()
    private let redeemTextField = UITextField()
    private let redeemButton = UIButton(type: .system)

    // MARK: Card 5 – Articles
    private var articlesCollectionView: UICollectionView!

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "E3F0FF")

        setupScrollView()
        setupHeader()
        setupBookCard()
        setupVideoSection()
        setupProgressTracker()
        setupRedeemCard()
        setupArticlesSection()

        // Animate progress after layout
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // Example: 85% weekly adherence
            self.progressCircle.setProgress(to: 0.85, withAnimation: true)
        }
    }

    // MARK: Scroll structure
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }

    // MARK: Header
    private func setupHeader() {
        [locationIcon, locationLabel, homeTitle, profileButton].forEach {
                contentView.addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false

        }

        NSLayoutConstraint.activate([
            
            // locationIcon constraints
            locationIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            locationIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            locationIcon.widthAnchor.constraint(equalToConstant: 16),
            locationIcon.heightAnchor.constraint(equalToConstant: 16),

            // locationLabel right next to icon
            locationLabel.centerYAnchor.constraint(equalTo: locationIcon.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationIcon.trailingAnchor, constant: 4),
            
            

            homeTitle.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 4),
            homeTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            profileButton.centerYAnchor.constraint(equalTo: homeTitle.centerYAnchor),
            profileButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            profileButton.heightAnchor.constraint(equalToConstant: 28),
            profileButton.widthAnchor.constraint(equalToConstant: 28)
        ])
    }

    // MARK: Book appointment card
    private func setupBookCard() {
        configureCard(bookCard)
        
        bookCard.layer.cornerRadius = 24


        cardImageView.contentMode = .scaleAspectFill
        cardImageView.layer.cornerRadius = 24
        cardImageView.clipsToBounds = true

        cardTitle.text = "Book home visits"
        cardTitle.font = .boldSystemFont(ofSize: 18)

        cardSubtitle.text = "Get certified physiotherapy at your doorstep"
        cardSubtitle.font = .systemFont(ofSize: 13)
        cardSubtitle.textColor = .darkGray
        cardSubtitle.numberOfLines = 2

        bookButton.setTitle("Book appointment", for: .normal)
        bookButton.setTitleColor(.white, for: .normal)
        bookButton.backgroundColor = UIColor(hex: "3278F6")
        bookButton.layer.cornerRadius = 18

        [bookCard, cardImageView, cardTitle, cardSubtitle, bookButton].forEach {
            contentView.addSubview($0); $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            bookCard.topAnchor.constraint(equalTo: homeTitle.bottomAnchor, constant: 20),
            bookCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bookCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            bookCard.heightAnchor.constraint(equalToConstant: 160),

            cardImageView.topAnchor.constraint(equalTo: bookCard.topAnchor, constant: 16),
            cardImageView.leadingAnchor.constraint(equalTo: bookCard.leadingAnchor, constant: 16),
            cardImageView.bottomAnchor.constraint(equalTo: bookCard.bottomAnchor, constant: -16),
            cardImageView.widthAnchor.constraint(equalToConstant: 120),

            cardTitle.topAnchor.constraint(equalTo: cardImageView.topAnchor),
            cardTitle.leadingAnchor.constraint(equalTo: cardImageView.trailingAnchor, constant: 20),

            cardSubtitle.topAnchor.constraint(equalTo: cardTitle.bottomAnchor, constant: 8),
            cardSubtitle.leadingAnchor.constraint(equalTo: cardTitle.leadingAnchor),
            cardSubtitle.trailingAnchor.constraint(lessThanOrEqualTo: bookCard.trailingAnchor, constant: -16),

            bookButton.bottomAnchor.constraint(equalTo: cardImageView.bottomAnchor),
            bookButton.trailingAnchor.constraint(equalTo: bookCard.trailingAnchor, constant: -16),
            bookButton.heightAnchor.constraint(equalToConstant: 36),
            bookButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }

    // MARK: Video exercises (horizontal collection)
    private func setupVideoSection() {
        let label = UILabel()
        label.text = "Video Exercises"
        label.font = .boldSystemFont(ofSize: 22)
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: bookCard.bottomAnchor, constant: 24),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 130, height: 130)
        layout.minimumLineSpacing = 16

        videoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        videoCollectionView.register(VideoCell.self, forCellWithReuseIdentifier: "VideoCell")
        videoCollectionView.delegate = self
        videoCollectionView.dataSource = self
        videoCollectionView.backgroundColor = .clear
        videoCollectionView.showsHorizontalScrollIndicator = false

        contentView.addSubview(videoCollectionView)
        videoCollectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            videoCollectionView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
            videoCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            videoCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            videoCollectionView.heightAnchor.constraint(equalToConstant: 130)
        ])
    }

    // MARK: Progress tracker
    private func setupProgressTracker() {
        configureCard(progressCard)
        progressCard.layer.cornerRadius = 24

        progressTitle.text = "Progress Tracker"
        progressTitle.font = .boldSystemFont(ofSize: 22)

        adherenceLabel.text = "Weekly Adherence"
        adherenceLabel.font = .boldSystemFont(ofSize: 14)
        adherenceLabel.textColor = .darkGray

        weekSegment.selectedSegmentIndex = 0
        weekSegment.backgroundColor = UIColor(hex: "E3F0FF")
        weekSegment.selectedSegmentTintColor = UIColor(hex: "3278F6")
        weekSegment.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        weekSegment.setTitleTextAttributes([.foregroundColor: UIColor.darkGray], for: .normal)
        weekSegment.addTarget(self, action: #selector(weekChanged(_:)), for: .valueChanged)

        [progressCard, progressTitle, progressCircle, adherenceLabel, weekSegment].forEach {
            contentView.addSubview($0); $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            progressCard.topAnchor.constraint(equalTo: videoCollectionView.bottomAnchor, constant: 24),
            progressCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            progressCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            progressCard.heightAnchor.constraint(equalToConstant: 200),

            progressTitle.topAnchor.constraint(equalTo: progressCard.topAnchor, constant: 12),
            progressTitle.leadingAnchor.constraint(equalTo: progressCard.leadingAnchor, constant: 16),

            progressCircle.centerYAnchor.constraint(equalTo: progressCard.centerYAnchor, constant: -8),
            progressCircle.leadingAnchor.constraint(equalTo: progressCard.leadingAnchor, constant: 40),
            progressCircle.widthAnchor.constraint(equalToConstant: 80),
            progressCircle.heightAnchor.constraint(equalToConstant: 80),

            adherenceLabel.centerYAnchor.constraint(equalTo: progressCircle.centerYAnchor),
            adherenceLabel.leadingAnchor.constraint(equalTo: progressCircle.trailingAnchor, constant: 16),

            weekSegment.bottomAnchor.constraint(equalTo: progressCard.bottomAnchor, constant: -12),
            weekSegment.leadingAnchor.constraint(equalTo: progressCard.leadingAnchor, constant: 16),
            weekSegment.trailingAnchor.constraint(equalTo: progressCard.trailingAnchor, constant: -16),
            weekSegment.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    @objc private func weekChanged(_ sender: UISegmentedControl) {
        // DEMO data: pretend W1..W4 adherence values
        let values: [CGFloat] = [0.62, 0.85, 0.73, 0.90]
        let target = values[min(max(sender.selectedSegmentIndex, 0), values.count - 1)]
        progressCircle.setProgress(to: target, withAnimation: true)
    }

    // MARK: - STEP 6: REDEEM CODE CARD (Gradient + Popup on Tap)
    private func setupRedeemCard() {
        // 🔹 Card background with gradient
        redeemCard.layer.cornerRadius = 24
        redeemCard.clipsToBounds = true
        redeemCard.layer.insertSublayer(makeGradient(), at: 0)
        contentView.addSubview(redeemCard)
        redeemCard.translatesAutoresizingMaskIntoConstraints = false

        // 🔹 Title
        redeemLabel.text = "Enter your program code"
        redeemLabel.font = .boldSystemFont(ofSize: 20)
        redeemLabel.textColor = .white

        // 🔹 Subtitle
        let redeemSubLabel = UILabel()
        redeemSubLabel.text = "Unlock your personalized video program."
        redeemSubLabel.font = .boldSystemFont(ofSize: 14)
        redeemSubLabel.textColor = UIColor.white.withAlphaComponent(0.85)

        // 🔹 Capsule text field
        redeemTextField.placeholder = "Tap to enter code"
        redeemTextField.backgroundColor = .white
        redeemTextField.textColor = .darkGray
        redeemTextField.borderStyle = .none
        redeemTextField.layer.cornerRadius = 12
        redeemTextField.layer.borderWidth = 1
        redeemTextField.layer.borderColor = UIColor.white.cgColor
        redeemTextField.layer.masksToBounds = true
        
        redeemTextField.heightAnchor.constraint(equalToConstant: 28).isActive = true
        redeemTextField.textAlignment = .center

        
        // Disable keyboard, we’ll trigger a popup instead
        redeemTextField.isUserInteractionEnabled = true
        redeemTextField.delegate = self

        // Add all to view hierarchy
        [redeemLabel, redeemSubLabel, redeemTextField].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        // 🔹 Layout constraints
        NSLayoutConstraint.activate([
            redeemCard.topAnchor.constraint(equalTo: progressCard.bottomAnchor, constant: 24),
            redeemCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            redeemCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            redeemCard.heightAnchor.constraint(equalToConstant: 150),

            redeemLabel.topAnchor.constraint(equalTo: redeemCard.topAnchor, constant: 16),
            redeemLabel.leadingAnchor.constraint(equalTo: redeemCard.leadingAnchor, constant: 16),

            redeemSubLabel.topAnchor.constraint(equalTo: redeemLabel.bottomAnchor, constant: 8),
            redeemSubLabel.leadingAnchor.constraint(equalTo: redeemCard.leadingAnchor, constant: 16),

            redeemTextField.topAnchor.constraint(equalTo: redeemSubLabel.bottomAnchor, constant: 36),
            redeemTextField.leadingAnchor.constraint(equalTo: redeemCard.leadingAnchor, constant: 16),
            redeemTextField.trailingAnchor.constraint(equalTo: redeemCard.trailingAnchor, constant: -16),
        ])
    }


    @objc private func showRedeemPopup() {
        let alert = UIAlertController(title: "Redeem Code",
                                      message: "Enter your physiotherapist-provided code:",
                                      preferredStyle: .alert)
        alert.addTextField { $0.placeholder = "Enter code" }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Redeem", style: .default))
        present(alert, animated: true)
    }

    // MARK: Articles (horizontal collection)
    private func setupArticlesSection() {
        let label = UILabel()
        label.text = "Articles & Tips"
        label.font = .boldSystemFont(ofSize: 22)
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: redeemCard.bottomAnchor, constant: 24),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 120)
        layout.minimumLineSpacing = 16

        articlesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        articlesCollectionView.register(ArticleCell.self, forCellWithReuseIdentifier: "ArticleCell")
        articlesCollectionView.delegate = self
        articlesCollectionView.dataSource = self
        articlesCollectionView.backgroundColor = .clear
        articlesCollectionView.showsHorizontalScrollIndicator = false

        contentView.addSubview(articlesCollectionView)
        articlesCollectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            articlesCollectionView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
            articlesCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            articlesCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            articlesCollectionView.heightAnchor.constraint(equalToConstant: 130),
            articlesCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // Ensure gradient fills redeemCard correctly even after layout updates
        if let gradient = redeemCard.layer.sublayers?.first as? CAGradientLayer {
            gradient.frame = redeemCard.bounds
            gradient.cornerRadius = redeemCard.layer.cornerRadius
        }
    }


    // MARK: Shared card styling
    private func configureCard(_ card: UIView) {
        card.backgroundColor = .white
        card.layer.cornerRadius = 24
        card.layer.borderColor = UIColor(hex: "D4E3FE").cgColor
        card.layer.borderWidth = 1
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowOpacity = 0.08
        card.layer.shadowRadius = 6
        card.layer.shadowOffset = CGSize(width: 0, height: 3)
    }

    // MARK: Gradient for redeem card
    private func makeGradient() -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor(hex: "1E6EF7").cgColor,
            UIColor(hex: "5EC6F5").cgColor
        ]
        gradient.startPoint = CGPoint(x: 0.44, y: 0.44)
        gradient.endPoint = CGPoint(x: 0.72, y: 0.72)
        return gradient
    }
}

// MARK: - Collections
extension LandingHomeScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == articlesCollectionView ? articlesData.count : videoImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == articlesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
            let data = articlesData[indexPath.row]
            cell.imageView.image = UIImage(named: data.image)
            cell.title.text = data.title
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath) as! VideoCell
            let imageName = videoImages[indexPath.row % videoImages.count]
            cell.imageView.image = UIImage(named: imageName)
            return cell
        }
    }

}

// MARK: - Reusable collection cells
final class VideoCell: UICollectionViewCell {
    let imageView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
                contentView.layer.cornerRadius = 24
                contentView.layer.borderColor = UIColor(hex: "D4E3FE").cgColor
                contentView.layer.borderWidth = 1

                // Add light shadow for depth
                layer.shadowColor = UIColor.black.cgColor
                layer.shadowOpacity = 0.08
                layer.shadowRadius = 6
                layer.shadowOffset = CGSize(width: 0, height: 3)
                layer.masksToBounds = false

                // MARK: - Image setup
                imageView.contentMode = .scaleAspectFill
                imageView.layer.cornerRadius = 24
                imageView.layer.borderWidth = 1
                imageView.layer.borderColor = UIColor.systemGray5.cgColor   // light gray border
                imageView.clipsToBounds = true

                contentView.addSubview(imageView)
                imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    required init?(coder: NSCoder) { fatalError() }
}

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
        imageView.heightAnchor.constraint(equalToConstant: 90).isActive = true

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    required init?(coder: NSCoder) { fatalError() }
}

// MARK: - Helpers

extension LandingHomeScreenViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == redeemTextField {
            showRedeemPopup()     // show popup when tapped
            return false          // prevent keyboard from appearing
        }
        return true
    }
}

extension UIColor {
    convenience init(hex: String) {
        let hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0; Scanner(string: hexSanitized).scanHexInt64(&rgb)
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255
        let b = CGFloat(rgb & 0x0000FF) / 255
        self.init(red: r, green: g, blue: b, alpha: 1)
    }
}


