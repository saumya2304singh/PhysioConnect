//
//  LandingHomeView.swift
//  PhysioConnect
//
//  Created by user@8 on 12/11/25.
//

import UIKit

final class LandingHomeView: UIView {
    
    // MARK: - Scroll structure
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    // MARK: - Header
    let locationIcon = UIImageView(image: UIImage(systemName: "mappin.and.ellipse"))
    let locationLabel = UILabel()
    let homeTitle = UILabel()
    let profileButton = UIButton(type: .system)
    
    // MARK: - Appointment Container (holds either Book card or Upcoming card)
    private let appointmentContainer = UIView()
    
    // Book Appointment Card
    let bookCard = UIView()
    let cardImageView = UIImageView(image: UIImage(named: "doc1"))
    let cardTitle = UILabel()
    let cardSubtitle = UILabel()
    let bookButton = UIButton(type: .system)
    
    // Upcoming Appointment Card
    let upcomingCard = UIView()
    let upcomingTitle = UILabel()
    let upcomingName = UILabel()
    let upcomingDate = UILabel()
    let upcomingButton = UIButton(type: .system)
    var onViewDetailsTapped: (() -> Void)?

    
    
    // MARK: - Video Exercises
    var videoCollectionView: UICollectionView!
    
    // MARK: - Progress Tracker
    let progressCard = UIView()
    let progressTitle = UILabel()
    let progressCircle = CircularProgressView(progress: 0.0)
    let adherenceLabel = UILabel()
    let weekSegment = UISegmentedControl(items: ["W1", "W2", "W3", "W4"])
    
    // MARK: - Redeem Code Card
    let redeemCard = UIView()
    let redeemLabel = UILabel()
    let redeemSubLabel = UILabel()
    let redeemTextField = UITextField()
    
    // MARK: - Articles
    var articlesCollectionView: UICollectionView!

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hex: "E3F0FF")
        setupLayout()
    }
    required init?(coder: NSCoder) { fatalError() }
    
    // MARK: - Configure with Model
    func configure(with model: LandingHomeModel) {
        // Future dynamic updates can go here
    }

    // MARK: - Public API for cards
    func showBookAppointmentCard() {
        bookCard.isHidden = false
        upcomingCard.isHidden = true
    }
    
    func updateUpcomingAppointment(doctorName: String, date: Date) {
        // Format date + time
        let df = DateFormatter()
        df.dateFormat = "EEEE, dd MMM"
        let tf = DateFormatter()
        tf.dateFormat = "h:mm a"
        
        upcomingName.text = doctorName
        upcomingDate.text = "\(df.string(from: date))\n\(tf.string(from: date))"
        
        // Toggle visibility
        bookCard.isHidden = true
        upcomingCard.isHidden = false
    }

    // MARK: - Setup
    private func setupLayout() {
        setupScrollView()
        setupHeader()
        setupAppointmentSection()
        setupVideoSection()
        setupProgressTracker()
        setupRedeemCard()
        setupArticlesSection()
    }
}


// MARK: - UI Setup Extensions
extension LandingHomeView {
    
    private func setupScrollView() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupHeader() {
        [locationIcon, locationLabel, homeTitle, profileButton].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        locationIcon.tintColor = .systemBlue
        locationLabel.text = "Chennai"
        locationLabel.font = .systemFont(ofSize: 13, weight: .medium)
        locationLabel.textColor = .darkGray
        homeTitle.text = "Home"
        homeTitle.font = .boldSystemFont(ofSize: 22)
        profileButton.setImage(UIImage(systemName: "person.circle.fill"), for: .normal)
        profileButton.tintColor = .black

        NSLayoutConstraint.activate([
            locationIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            locationIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            locationIcon.widthAnchor.constraint(equalToConstant: 16),
            locationIcon.heightAnchor.constraint(equalToConstant: 16),

            locationLabel.centerYAnchor.constraint(equalTo: locationIcon.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationIcon.trailingAnchor, constant: 4),

            homeTitle.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 6),
            homeTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            profileButton.centerYAnchor.constraint(equalTo: homeTitle.centerYAnchor),
            profileButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            profileButton.widthAnchor.constraint(equalToConstant: 28),
            profileButton.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    

    // MARK: - Appointment Section (Book + Upcoming stacked)
    private func setupAppointmentSection() {
        contentView.addSubview(appointmentContainer)
        appointmentContainer.translatesAutoresizingMaskIntoConstraints = false
        upcomingButton.addTarget(self, action: #selector(viewDetailsTapped), for: .touchUpInside)

        
        NSLayoutConstraint.activate([
            appointmentContainer.topAnchor.constraint(equalTo: homeTitle.bottomAnchor, constant: 20),
            appointmentContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            appointmentContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            appointmentContainer.heightAnchor.constraint(equalToConstant: 160)
        ])
        
        // ------- Book Card -------
        configureCard(bookCard)
        appointmentContainer.addSubview(bookCard)
        bookCard.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bookCard.topAnchor.constraint(equalTo: appointmentContainer.topAnchor),
            bookCard.leadingAnchor.constraint(equalTo: appointmentContainer.leadingAnchor),
            bookCard.trailingAnchor.constraint(equalTo: appointmentContainer.trailingAnchor),
            bookCard.bottomAnchor.constraint(equalTo: appointmentContainer.bottomAnchor)
        ])

        cardImageView.layer.cornerRadius = 24
        cardImageView.contentMode = .scaleAspectFill
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

        [cardImageView, cardTitle, cardSubtitle, bookButton].forEach {
            bookCard.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            cardImageView.topAnchor.constraint(equalTo: bookCard.topAnchor, constant: 16),
            cardImageView.leadingAnchor.constraint(equalTo: bookCard.leadingAnchor, constant: 16),
            cardImageView.bottomAnchor.constraint(equalTo: bookCard.bottomAnchor, constant: -16),
            cardImageView.widthAnchor.constraint(equalToConstant: 120),

            cardTitle.topAnchor.constraint(equalTo: cardImageView.topAnchor),
            cardTitle.leadingAnchor.constraint(equalTo: cardImageView.trailingAnchor, constant: 20),

            cardSubtitle.topAnchor.constraint(equalTo: cardTitle.bottomAnchor, constant: 8),
            cardSubtitle.leadingAnchor.constraint(equalTo: cardTitle.leadingAnchor),
            cardSubtitle.trailingAnchor.constraint(equalTo: bookCard.trailingAnchor, constant: -16),

            bookButton.bottomAnchor.constraint(equalTo: cardImageView.bottomAnchor),
            bookButton.trailingAnchor.constraint(equalTo: bookCard.trailingAnchor, constant: -16),
            bookButton.heightAnchor.constraint(equalToConstant: 36),
            bookButton.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        // ------- Upcoming Card (stacked in same container, initially hidden) -------
        configureCard(upcomingCard)
        appointmentContainer.addSubview(upcomingCard)
        upcomingCard.translatesAutoresizingMaskIntoConstraints = false
        upcomingCard.isHidden = true
        
        
        NSLayoutConstraint.activate([
            upcomingCard.topAnchor.constraint(equalTo: appointmentContainer.topAnchor),
            upcomingCard.leadingAnchor.constraint(equalTo: appointmentContainer.leadingAnchor),
            upcomingCard.trailingAnchor.constraint(equalTo: appointmentContainer.trailingAnchor),
            upcomingCard.bottomAnchor.constraint(equalTo: appointmentContainer.bottomAnchor)
        ])
        
        upcomingTitle.text = "Upcoming appointment"
        upcomingTitle.font = .boldSystemFont(ofSize: 20)
        upcomingTitle.textColor = UIColor.systemGreen
        
        upcomingName.font = .systemFont(ofSize: 17, weight: .semibold)
        upcomingName.textColor = .black
        
        upcomingDate.font = .systemFont(ofSize: 15)
        upcomingDate.numberOfLines = 2
        upcomingDate.textColor = .darkGray
        
        upcomingButton.setTitle("View Details", for: .normal)
        upcomingButton.backgroundColor = UIColor(hex: "3278F6")
        upcomingButton.setTitleColor(.white, for: .normal)
        upcomingButton.layer.cornerRadius = 16
        upcomingButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        
        [upcomingTitle, upcomingName, upcomingDate, upcomingButton].forEach {
            upcomingCard.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            upcomingTitle.topAnchor.constraint(equalTo: upcomingCard.topAnchor, constant: 16),
            upcomingTitle.leadingAnchor.constraint(equalTo: upcomingCard.leadingAnchor, constant: 16),
            
            upcomingName.topAnchor.constraint(equalTo: upcomingTitle.bottomAnchor, constant: 8),
            upcomingName.leadingAnchor.constraint(equalTo: upcomingTitle.leadingAnchor),
            
            upcomingDate.topAnchor.constraint(equalTo: upcomingName.bottomAnchor, constant: 4),
            upcomingDate.leadingAnchor.constraint(equalTo: upcomingTitle.leadingAnchor),
            
            upcomingButton.centerYAnchor.constraint(equalTo: upcomingCard.centerYAnchor),
            upcomingButton.trailingAnchor.constraint(equalTo: upcomingCard.trailingAnchor, constant: -16),
            upcomingButton.heightAnchor.constraint(equalToConstant: 36),
            upcomingButton.widthAnchor.constraint(equalToConstant: 130)
        ])
    }
    
    @objc private func viewDetailsTapped() {
        onViewDetailsTapped?()
    }
    

    
    private func setupVideoSection() {
        let label = UILabel()
        label.text = "Video Exercises"
        label.font = .boldSystemFont(ofSize: 22)
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 130, height: 130)
        layout.minimumLineSpacing = 16
        
        videoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        videoCollectionView.register(VideoCell.self, forCellWithReuseIdentifier: "VideoCell")
        videoCollectionView.backgroundColor = .clear
        videoCollectionView.showsHorizontalScrollIndicator = false
        contentView.addSubview(videoCollectionView)
        videoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: appointmentContainer.bottomAnchor, constant: 24),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            videoCollectionView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
            videoCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            videoCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            videoCollectionView.heightAnchor.constraint(equalToConstant: 130)
        ])
    }

    private func setupProgressTracker() {
        configureCard(progressCard)
        [progressCard, progressTitle, progressCircle, adherenceLabel, weekSegment].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        progressCard.layer.cornerRadius = 24
        progressTitle.text = "Progress Tracker"
        progressTitle.font = .boldSystemFont(ofSize: 20)
        adherenceLabel.text = "Weekly Adherence"
        adherenceLabel.font = .boldSystemFont(ofSize: 14)
        adherenceLabel.textColor = .darkGray
        
        weekSegment.selectedSegmentIndex = 0
        weekSegment.backgroundColor = UIColor(hex: "E3F0FF")
        weekSegment.selectedSegmentTintColor = UIColor(hex: "3278F6")
        weekSegment.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        weekSegment.setTitleTextAttributes([.foregroundColor: UIColor.darkGray], for: .normal)

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

    private func setupRedeemCard() {
        redeemCard.layer.cornerRadius = 24
        redeemCard.clipsToBounds = true
        contentView.addSubview(redeemCard)
        redeemCard.translatesAutoresizingMaskIntoConstraints = false

        redeemLabel.text = "Enter your program code"
        redeemLabel.font = .boldSystemFont(ofSize: 20)
        redeemLabel.textColor = .white

        let redeemSubLabel = UILabel()
        redeemSubLabel.text = "Unlock your personalized video program."
        redeemSubLabel.font = .systemFont(ofSize: 14, weight: .medium)
        redeemSubLabel.textColor = UIColor.white.withAlphaComponent(0.85)

        redeemTextField.placeholder = "Tap to enter code"
        redeemTextField.backgroundColor = .white
        redeemTextField.textColor = .darkGray
        redeemTextField.borderStyle = .none
        redeemTextField.layer.cornerRadius = 12
        redeemTextField.layer.borderWidth = 1
        redeemTextField.layer.borderColor = UIColor.white.cgColor
        redeemTextField.layer.masksToBounds = true
        redeemTextField.textAlignment = .center
        redeemTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true

        [redeemLabel, redeemSubLabel, redeemTextField].forEach {
            redeemCard.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

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
            redeemTextField.trailingAnchor.constraint(equalTo: redeemCard.trailingAnchor, constant: -16)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        redeemCard.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor(hex: "1E6EF7").cgColor,
            UIColor(hex: "5EC6F5").cgColor
        ]
        gradient.startPoint = CGPoint(x: 0.44, y: 0.44)
        gradient.endPoint = CGPoint(x: 0.72, y: 0.72)
        gradient.frame = redeemCard.bounds
        gradient.cornerRadius = redeemCard.layer.cornerRadius
        redeemCard.layer.insertSublayer(gradient, at: 0)
    }

    private func setupArticlesSection() {
        let label = UILabel()
        label.text = "Articles & Tips"
        label.font = .boldSystemFont(ofSize: 22)
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 120)
        layout.minimumLineSpacing = 16
        
        articlesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        articlesCollectionView.register(ArticleCell.self, forCellWithReuseIdentifier: "ArticleCell")
        articlesCollectionView.backgroundColor = .clear
        articlesCollectionView.showsHorizontalScrollIndicator = false
        
        contentView.addSubview(articlesCollectionView)
        articlesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: redeemCard.bottomAnchor, constant: 24),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            articlesCollectionView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
            articlesCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            articlesCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            articlesCollectionView.heightAnchor.constraint(equalToConstant: 130),
            articlesCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
    
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
}
