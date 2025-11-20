import UIKit

final class PhysioPatientOverviewView: UIView {

    // MARK: - ScrollView
    let scrollView = UIScrollView()
    let contentView = UIView()

    // MARK: Patient Card
    let patientCard = UIView()
    let patientImage = UIImageView()
    let nameLabel = UILabel()
    let subtitleLabel = UILabel()
    let activityLabel = UILabel()

    // MARK: - Personal Info
    let personalInfoTitle = UILabel()
    let personalInfoCard = UIView()

    let ageTitle = UILabel()
    let ageValue = UILabel()
    let divider1 = UIView()

    let contactTitle = UILabel()
    let contactValue = UILabel()
    let divider2 = UIView()

    let therapistTitle = UILabel()
    let therapistValue = UILabel()

    // MARK: - Programs
    let programsTitle = UILabel()
    let programsCard = UIView()
    let programStatusLabel = UILabel()
    let assignButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hex: "#E3F0FF")
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func styleCard(_ view: UIView) {
        view.backgroundColor = .white
        view.layer.cornerRadius = 24
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 4
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
    }

    private func setupUI() {

        scrollView.showsVerticalScrollIndicator = false

        // Patient Card
        styleCard(patientCard)

        patientImage.layer.cornerRadius = 32
        patientImage.clipsToBounds = true
        patientImage.contentMode = .scaleAspectFill

        nameLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        subtitleLabel.font = .systemFont(ofSize: 14)
        subtitleLabel.textColor = .darkGray
        activityLabel.font = .systemFont(ofSize: 13)
        activityLabel.textColor = .gray

        // Personal Info Title
        personalInfoTitle.text = "Personal Information"
        personalInfoTitle.font = .boldSystemFont(ofSize: 18)

        // Personal Info Card
        styleCard(personalInfoCard)

        ageTitle.text = "Age/Gender"
        ageTitle.font = .systemFont(ofSize: 15)
        ageValue.font = .systemFont(ofSize: 15)
        ageValue.textColor = .darkGray

        divider1.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)

        contactTitle.text = "Contact"
        contactTitle.font = .systemFont(ofSize: 15)
        contactValue.font = .systemFont(ofSize: 15)
        contactValue.textColor = .systemBlue

        divider2.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)

        therapistTitle.text = "Assigned Therapist"
        therapistTitle.font = .systemFont(ofSize: 15)
        therapistValue.font = .systemFont(ofSize: 15)
        therapistValue.textColor = .systemBlue

        // Programs Section
        programsTitle.text = "Programs"
        programsTitle.font = .boldSystemFont(ofSize: 18)

        styleCard(programsCard)

        programStatusLabel.text = "Not Yet Assigned"
        programStatusLabel.font = .systemFont(ofSize: 16, weight: .medium)
        programStatusLabel.textAlignment = .center

        assignButton.setTitle("Assign To Patient", for: .normal)
        assignButton.backgroundColor = .systemBlue
        assignButton.setTitleColor(.white, for: .normal)
        assignButton.layer.cornerRadius = 22

        // Add subviews
        addSubview(scrollView)
        scrollView.addSubview(contentView)

        [
            patientCard,
            personalInfoTitle, personalInfoCard,
            programsTitle, programsCard
        ].forEach { contentView.addSubview($0) }

        [patientImage, nameLabel, subtitleLabel, activityLabel]
            .forEach { patientCard.addSubview($0) }

        [
            ageTitle, ageValue, divider1,
            contactTitle, contactValue, divider2,
            therapistTitle, therapistValue
        ].forEach { personalInfoCard.addSubview($0) }

        [programStatusLabel, assignButton]
            .forEach { programsCard.addSubview($0) }
    }

    private func setupConstraints() {

        // Enable Auto Layout
        [
            scrollView, contentView, patientCard, patientImage,
            nameLabel, subtitleLabel, activityLabel,
            personalInfoTitle, personalInfoCard, ageTitle, ageValue,
            divider1, contactTitle, contactValue, divider2,
            therapistTitle, therapistValue,
            programsTitle, programsCard, programStatusLabel,
            assignButton
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        NSLayoutConstraint.activate([

            // ScrollView
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
            patientCard.heightAnchor.constraint(equalToConstant: 110),

            patientImage.leadingAnchor.constraint(equalTo: patientCard.leadingAnchor, constant: 15),
            patientImage.centerYAnchor.constraint(equalTo: patientCard.centerYAnchor),
            patientImage.widthAnchor.constraint(equalToConstant: 64),
            patientImage.heightAnchor.constraint(equalToConstant: 64),

            nameLabel.topAnchor.constraint(equalTo: patientImage.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: patientImage.trailingAnchor, constant: 12),

            subtitleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            subtitleLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),

            activityLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 2),
            activityLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),

            // Personal Info Title
            personalInfoTitle.topAnchor.constraint(equalTo: patientCard.bottomAnchor, constant: 25),
            personalInfoTitle.leadingAnchor.constraint(equalTo: patientCard.leadingAnchor),

            // Personal Info Card
            personalInfoCard.topAnchor.constraint(equalTo: personalInfoTitle.bottomAnchor, constant: 12),
            personalInfoCard.leadingAnchor.constraint(equalTo: patientCard.leadingAnchor),
            personalInfoCard.trailingAnchor.constraint(equalTo: patientCard.trailingAnchor),
            personalInfoCard.heightAnchor.constraint(equalToConstant: 150),

            ageTitle.topAnchor.constraint(equalTo: personalInfoCard.topAnchor, constant: 14),
            ageTitle.leadingAnchor.constraint(equalTo: personalInfoCard.leadingAnchor, constant: 15),

            ageValue.centerYAnchor.constraint(equalTo: ageTitle.centerYAnchor),
            ageValue.trailingAnchor.constraint(equalTo: personalInfoCard.trailingAnchor, constant: -15),

            divider1.topAnchor.constraint(equalTo: ageTitle.bottomAnchor, constant: 14),
            divider1.leadingAnchor.constraint(equalTo: ageTitle.leadingAnchor),
            divider1.trailingAnchor.constraint(equalTo: ageValue.trailingAnchor),
            divider1.heightAnchor.constraint(equalToConstant: 1),

            contactTitle.topAnchor.constraint(equalTo: divider1.bottomAnchor, constant: 14),
            contactTitle.leadingAnchor.constraint(equalTo: ageTitle.leadingAnchor),

            contactValue.centerYAnchor.constraint(equalTo: contactTitle.centerYAnchor),
            contactValue.trailingAnchor.constraint(equalTo: ageValue.trailingAnchor),

            divider2.topAnchor.constraint(equalTo: contactTitle.bottomAnchor, constant: 14),
            divider2.leadingAnchor.constraint(equalTo: ageTitle.leadingAnchor),
            divider2.trailingAnchor.constraint(equalTo: ageValue.trailingAnchor),
            divider2.heightAnchor.constraint(equalToConstant: 1),

            therapistTitle.topAnchor.constraint(equalTo: divider2.bottomAnchor, constant: 14),
            therapistTitle.leadingAnchor.constraint(equalTo: ageTitle.leadingAnchor),

            therapistValue.centerYAnchor.constraint(equalTo: therapistTitle.centerYAnchor),
            therapistValue.trailingAnchor.constraint(equalTo: ageValue.trailingAnchor),

            // Programs Title
            programsTitle.topAnchor.constraint(equalTo: personalInfoCard.bottomAnchor, constant: 30),
            programsTitle.leadingAnchor.constraint(equalTo: personalInfoCard.leadingAnchor),

            // Programs Card
            programsCard.topAnchor.constraint(equalTo: programsTitle.bottomAnchor, constant: 12),
            programsCard.leadingAnchor.constraint(equalTo: personalInfoCard.leadingAnchor),
            programsCard.trailingAnchor.constraint(equalTo: personalInfoCard.trailingAnchor),
            programsCard.heightAnchor.constraint(equalToConstant: 160),

            programStatusLabel.topAnchor.constraint(equalTo: programsCard.topAnchor, constant: 20),
            programStatusLabel.centerXAnchor.constraint(equalTo: programsCard.centerXAnchor),

            assignButton.topAnchor.constraint(equalTo: programStatusLabel.bottomAnchor, constant: 20),
            assignButton.leadingAnchor.constraint(equalTo: programsCard.leadingAnchor, constant: 20),
            assignButton.trailingAnchor.constraint(equalTo: programsCard.trailingAnchor, constant: -20),
            assignButton.heightAnchor.constraint(equalToConstant: 45),

            programsCard.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
}
