import UIKit

final class PhysioSetScheduleView: UIView {

    let scrollView = UIScrollView()
    let contentView = UIView()

    // MARK: - Patient Card
    let patientCard = UIView()
    let patientImage = UIImageView()
    let patientNameLabel = UILabel()
    let patientSubtitleLabel = UILabel()

    // MARK: - Summary Title
    let summaryTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Summary"
        lbl.font = .boldSystemFont(ofSize: 18)
        return lbl
    }()

    // MARK: - Summary Card
    let summaryCard = UIView()

    let freqTitle = UILabel()
    let freqValue = UILabel()

    let startDateTitle = UILabel()
    let startDateValue = UILabel()

    let endDateTitle = UILabel()
    let endDateValue = UILabel()

    let programTitle = UILabel()
    let programValue = UILabel()

    // MARK: - Videos
    let videosTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Videos"
        lbl.font = .boldSystemFont(ofSize: 18)
        return lbl
    }()

    let video1 = UIImageView()
    let video2 = UIImageView()

    // MARK: - Redeem Code
    let redeemTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Redeem Code"
        lbl.font = .boldSystemFont(ofSize: 18)
        return lbl
    }()

    let redeemCard = UIView()
    let redeemLabel = UILabel()

    // MARK: - Assign Button
    let assignButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Assign to Patient", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 22
        btn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hex: "#E3F0FF")
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func styleCard(_ v: UIView) {
        v.backgroundColor = .white
        v.layer.cornerRadius = 18
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.08
        v.layer.shadowRadius = 4
        v.layer.shadowOffset = CGSize(width: 0, height: 2)
    }

    private func setupUI() {

        addSubview(scrollView)
        scrollView.addSubview(contentView)

        // Patient Card
        styleCard(patientCard)
        patientImage.layer.cornerRadius = 30
        patientImage.clipsToBounds = true
        patientImage.contentMode = .scaleAspectFill
        patientImage.image = UIImage(named: "patient") ?? UIImage(systemName: "person.circle")

        patientNameLabel.text = "Sophia Carter"
        patientNameLabel.font = .boldSystemFont(ofSize: 16)

        patientSubtitleLabel.text = "Strength Training"
        patientSubtitleLabel.textColor = .gray
        patientSubtitleLabel.font = .systemFont(ofSize: 13)

        // Summary Card styling
        styleCard(summaryCard)

        freqTitle.text = "Frequency"
        startDateTitle.text = "Start Date"
        endDateTitle.text = "End Date"
        programTitle.text = "Program"

        [freqTitle, startDateTitle, endDateTitle, programTitle].forEach {
            $0.font = .systemFont(ofSize: 15)
            $0.textColor = .gray
        }

        freqValue.text = "Mon, Wed, Fri"
        startDateValue.text = "22/09/2025"
        endDateValue.text = "22/10/2025"
        programValue.text = "Strength Training"

        [freqValue, startDateValue, endDateValue, programValue].forEach {
            $0.font = .systemFont(ofSize: 15)
        }

        video1.image = UIImage(named: "ex1") ?? UIImage(systemName: "photo")
        video2.image = UIImage(named: "ex2") ?? UIImage(systemName: "photo")
        video1.layer.cornerRadius = 14
        video2.layer.cornerRadius = 14
        video1.clipsToBounds = true
        video2.clipsToBounds = true
        video1.contentMode = .scaleAspectFill
        video2.contentMode = .scaleAspectFill

        redeemCard.backgroundColor = .white
        redeemCard.layer.cornerRadius = 18

        redeemLabel.text = "FITX2025"
        redeemLabel.font = .systemFont(ofSize: 20, weight: .medium)
        redeemLabel.textColor = .systemBlue
        redeemLabel.textAlignment = .center

        // Add subviews
        [
            patientCard, summaryTitleLabel, summaryCard,
            videosTitle, video1, video2,
            redeemTitle, redeemCard, assignButton
        ].forEach { contentView.addSubview($0) }

        patientCard.addSubview(patientImage)
        patientCard.addSubview(patientNameLabel)
        patientCard.addSubview(patientSubtitleLabel)

        summaryCard.addSubview(freqTitle)
        summaryCard.addSubview(freqValue)
        summaryCard.addSubview(startDateTitle)
        summaryCard.addSubview(startDateValue)
        summaryCard.addSubview(endDateTitle)
        summaryCard.addSubview(endDateValue)
        summaryCard.addSubview(programTitle)
        summaryCard.addSubview(programValue)

        redeemCard.addSubview(redeemLabel)
    }

    private func setupConstraints() {

        [
            scrollView, contentView,
            patientCard, patientImage, patientNameLabel, patientSubtitleLabel,
            summaryTitleLabel, summaryCard,
            freqTitle, freqValue, startDateTitle, startDateValue,
            endDateTitle, endDateValue, programTitle, programValue,
            videosTitle, video1, video2,
            redeemTitle, redeemCard, redeemLabel, assignButton
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            // Patient Card
            patientCard.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            patientCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            patientCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            patientCard.heightAnchor.constraint(equalToConstant: 90),

            patientImage.leadingAnchor.constraint(equalTo: patientCard.leadingAnchor, constant: 15),
            patientImage.centerYAnchor.constraint(equalTo: patientCard.centerYAnchor),
            patientImage.widthAnchor.constraint(equalToConstant: 60),
            patientImage.heightAnchor.constraint(equalToConstant: 60),

            patientNameLabel.leadingAnchor.constraint(equalTo: patientImage.trailingAnchor, constant: 15),
            patientNameLabel.topAnchor.constraint(equalTo: patientCard.topAnchor, constant: 20),

            patientSubtitleLabel.leadingAnchor.constraint(equalTo: patientNameLabel.leadingAnchor),
            patientSubtitleLabel.topAnchor.constraint(equalTo: patientNameLabel.bottomAnchor, constant: 3),

            // Summary title
            summaryTitleLabel.topAnchor.constraint(equalTo: patientCard.bottomAnchor, constant: 28),
            summaryTitleLabel.leadingAnchor.constraint(equalTo: patientCard.leadingAnchor),

            // Summary card
            summaryCard.topAnchor.constraint(equalTo: summaryTitleLabel.bottomAnchor, constant: 12),
            summaryCard.leadingAnchor.constraint(equalTo: patientCard.leadingAnchor),
            summaryCard.trailingAnchor.constraint(equalTo: patientCard.trailingAnchor),
            summaryCard.heightAnchor.constraint(equalToConstant: 180),

            freqTitle.topAnchor.constraint(equalTo: summaryCard.topAnchor, constant: 15),
            freqTitle.leadingAnchor.constraint(equalTo: summaryCard.leadingAnchor, constant: 15),

            freqValue.centerYAnchor.constraint(equalTo: freqTitle.centerYAnchor),
            freqValue.trailingAnchor.constraint(equalTo: summaryCard.trailingAnchor, constant: -15),

            startDateTitle.topAnchor.constraint(equalTo: freqTitle.bottomAnchor, constant: 18),
            startDateTitle.leadingAnchor.constraint(equalTo: freqTitle.leadingAnchor),

            startDateValue.centerYAnchor.constraint(equalTo: startDateTitle.centerYAnchor),
            startDateValue.trailingAnchor.constraint(equalTo: freqValue.trailingAnchor),

            endDateTitle.topAnchor.constraint(equalTo: startDateTitle.bottomAnchor, constant: 18),
            endDateTitle.leadingAnchor.constraint(equalTo: freqTitle.leadingAnchor),

            endDateValue.centerYAnchor.constraint(equalTo: endDateTitle.centerYAnchor),
            endDateValue.trailingAnchor.constraint(equalTo: freqValue.trailingAnchor),

            programTitle.topAnchor.constraint(equalTo: endDateTitle.bottomAnchor, constant: 18),
            programTitle.leadingAnchor.constraint(equalTo: freqTitle.leadingAnchor),

            programValue.centerYAnchor.constraint(equalTo: programTitle.centerYAnchor),
            programValue.trailingAnchor.constraint(equalTo: freqValue.trailingAnchor),

            // Videos
            videosTitle.topAnchor.constraint(equalTo: summaryCard.bottomAnchor, constant: 25),
            videosTitle.leadingAnchor.constraint(equalTo: summaryCard.leadingAnchor),

            video1.topAnchor.constraint(equalTo: videosTitle.bottomAnchor, constant: 12),
            video1.leadingAnchor.constraint(equalTo: videosTitle.leadingAnchor),
            video1.widthAnchor.constraint(equalToConstant: 150),
            video1.heightAnchor.constraint(equalToConstant: 90),

            video2.leadingAnchor.constraint(equalTo: video1.trailingAnchor, constant: 12),
            video2.centerYAnchor.constraint(equalTo: video1.centerYAnchor),
            video2.widthAnchor.constraint(equalToConstant: 150),
            video2.heightAnchor.constraint(equalToConstant: 90),

            // Redeem
            redeemTitle.topAnchor.constraint(equalTo: video1.bottomAnchor, constant: 25),
            redeemTitle.leadingAnchor.constraint(equalTo: summaryCard.leadingAnchor),

            redeemCard.topAnchor.constraint(equalTo: redeemTitle.bottomAnchor, constant: 12),
            redeemCard.leadingAnchor.constraint(equalTo: summaryCard.leadingAnchor),
            redeemCard.trailingAnchor.constraint(equalTo: summaryCard.trailingAnchor),
            redeemCard.heightAnchor.constraint(equalToConstant: 52),

            redeemLabel.centerXAnchor.constraint(equalTo: redeemCard.centerXAnchor),
            redeemLabel.centerYAnchor.constraint(equalTo: redeemCard.centerYAnchor),

            assignButton.topAnchor.constraint(equalTo: redeemCard.bottomAnchor, constant: 30),
            assignButton.leadingAnchor.constraint(equalTo: summaryCard.leadingAnchor),
            assignButton.trailingAnchor.constraint(equalTo: summaryCard.trailingAnchor),
            assignButton.heightAnchor.constraint(equalToConstant: 50),

            assignButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
    }
}
