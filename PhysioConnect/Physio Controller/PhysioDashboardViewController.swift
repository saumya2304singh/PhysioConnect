import UIKit

final class PhysioDashboardViewController: UIViewController {

    private let mainView = PhysioDashboardView()

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(hex: "#E3F0FF")

        // DASHBOARD NEVER SHOWS BACK
        navigationItem.hidesBackButton = true

        // NAVIGATION BAR TITLE
        navigationItem.title = "Dashboard"
        navigationController?.navigationBar.prefersLargeTitles = false

        // PROFILE BUTTON
        let profileButton = UIBarButtonItem(
            image: UIImage(systemName: "person.circle"),
            style: .plain,
            target: self,
            action: #selector(profileTapped)
        )
        navigationItem.rightBarButtonItem = profileButton

        setupPatients()
        setupAppointments()
        setupTasks()
    }

    @objc private func profileTapped() {
        print("Profile icon tapped!")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.hidesBackButton = true
    }

    // MARK: - PATIENT CARDS
    private func setupPatients() {

        setupPatientCard(
            card: mainView.patientCard1,
            imageName: "p1",
            name: "Sophia Carter",
            subtitle: "Strength Training",
            activity: "Last Activity: 2 days ago"
        )

        setupPatientCard(
            card: mainView.patientCard2,
            imageName: "p2",
            name: "Ethan Bennett",
            subtitle: "Post-Surgery Rehab",
            activity: "Last Activity: 1 day ago"
        )

        setupPatientCard(
            card: mainView.patientCard3,
            imageName: "p3",
            name: "Olivia Hayes",
            subtitle: "Pain Management",
            activity: "Last Activity: 5 days ago"
        )
    }

    private func setupPatientCard(
        card: UIView,
        imageName: String,
        name: String,
        subtitle: String,
        activity: String
    ) {

        let img = UIImageView(image: UIImage(named: imageName))
        let nameLbl = UILabel()
        let subLbl = UILabel()
        let actLbl = UILabel()
        let chevron = UIImageView(image: UIImage(systemName: "chevron.right"))

        nameLbl.text = name
        subLbl.text = subtitle
        actLbl.text = activity

        nameLbl.font = .systemFont(ofSize: 17, weight: .semibold)
        subLbl.font = .systemFont(ofSize: 14)
        subLbl.textColor = .darkGray
        actLbl.font = .systemFont(ofSize: 13)
        actLbl.textColor = .gray

        img.layer.cornerRadius = 28
        img.clipsToBounds = true
        chevron.tintColor = .lightGray

        card.isUserInteractionEnabled = true
        card.accessibilityLabel = name
        let tap = UITapGestureRecognizer(target: self, action: #selector(openPatientOverview))
        card.addGestureRecognizer(tap)

        [img, nameLbl, subLbl, actLbl, chevron].forEach {
            card.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            img.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 15),
            img.centerYAnchor.constraint(equalTo: card.centerYAnchor),
            img.widthAnchor.constraint(equalToConstant: 56),
            img.heightAnchor.constraint(equalToConstant: 56),

            nameLbl.topAnchor.constraint(equalTo: card.topAnchor, constant: 14),
            nameLbl.leadingAnchor.constraint(equalTo: img.trailingAnchor, constant: 12),

            subLbl.topAnchor.constraint(equalTo: nameLbl.bottomAnchor, constant: 2),
            subLbl.leadingAnchor.constraint(equalTo: nameLbl.leadingAnchor),

            actLbl.topAnchor.constraint(equalTo: subLbl.bottomAnchor, constant: 3),
            actLbl.leadingAnchor.constraint(equalTo: nameLbl.leadingAnchor),

            chevron.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -15),
            chevron.centerYAnchor.constraint(equalTo: card.centerYAnchor)
        ])
    }

    @objc private func openPatientOverview(_ sender: UITapGestureRecognizer) {

        guard let card = sender.view,
              let name = card.accessibilityLabel else { return }

        let vc = PhysioPatientOverviewViewController()

        switch name {
        case "Sophia Carter":
            vc.patientName = "Sophia Carter"
            vc.patientSubtitle = "Strength Training"
            vc.patientActivity = "Last Activity: 2 days ago"
            vc.patientImageName = "p1"

        case "Ethan Bennett":
            vc.patientName = "Ethan Bennett"
            vc.patientSubtitle = "Post-Surgery Rehab"
            vc.patientActivity = "Last Activity: 1 day ago"
            vc.patientImageName = "p2"

        case "Olivia Hayes":
            vc.patientName = "Olivia Hayes"
            vc.patientSubtitle = "Pain Management"
            vc.patientActivity = "Last Activity: 5 days ago"
            vc.patientImageName = "p3"

        default: break
        }

        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - APPOINTMENTS
    private func setupAppointments() {

        setupAppointmentCard(
            card: mainView.appointmentCard1,
            imageName: "p1",
            name: "Olivia Bennett",
            time: "10:00 AM – 11:00 AM"
        )

        setupAppointmentCard(
            card: mainView.appointmentCard2,
            imageName: "p2",
            name: "Ethan Morgan",
            time: "11:30 AM – 12:30 PM"
        )
    }

    private func setupAppointmentCard(
        card: UIView,
        imageName: String,
        name: String,
        time: String
    ) {

        let img = UIImageView(image: UIImage(named: imageName))
        let nameLbl = UILabel()
        let timeLbl = UILabel()
        let chevron = UIImageView(image: UIImage(systemName: "chevron.right"))

        nameLbl.text = name
        nameLbl.font = .systemFont(ofSize: 17, weight: .semibold)

        timeLbl.text = time
        timeLbl.textColor = .gray
        timeLbl.font = .systemFont(ofSize: 13)

        img.layer.cornerRadius = 25
        img.clipsToBounds = true
        chevron.tintColor = .lightGray

        [img, nameLbl, timeLbl, chevron].forEach {
            card.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            img.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 15),
            img.centerYAnchor.constraint(equalTo: card.centerYAnchor),
            img.widthAnchor.constraint(equalToConstant: 50),
            img.heightAnchor.constraint(equalToConstant: 50),

            nameLbl.topAnchor.constraint(equalTo: card.topAnchor, constant: 10),
            nameLbl.leadingAnchor.constraint(equalTo: img.trailingAnchor, constant: 12),

            timeLbl.topAnchor.constraint(equalTo: nameLbl.bottomAnchor, constant: 2),
            timeLbl.leadingAnchor.constraint(equalTo: nameLbl.leadingAnchor),

            chevron.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -15),
            chevron.centerYAnchor.constraint(equalTo: card.centerYAnchor)
        ])
    }

    // MARK: - TASKS
    private func setupTasks() {

        setupTaskCard(
            card: mainView.pendingCard,
            title: "Pending Logs",
            action: "Review"
        )

        setupTaskCard(
            card: mainView.availabilityCard,
            title: "Set Availability",
            action: "Set"
        )

        // 👉 Tap to open Set Availability Screen
        let tap = UITapGestureRecognizer(target: self, action: #selector(openSetAvailability))
        mainView.availabilityCard.addGestureRecognizer(tap)
        mainView.availabilityCard.isUserInteractionEnabled = true
    }

    private func setupTaskCard(card: UIView, title: String, action: String) {

        let titleLbl = UILabel()
        let actionLbl = UILabel()

        titleLbl.text = title
        titleLbl.font = .systemFont(ofSize: 16)

        actionLbl.text = action
        actionLbl.textColor = .systemBlue
        actionLbl.font = .systemFont(ofSize: 16, weight: .semibold)

        [titleLbl, actionLbl].forEach {
            card.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            titleLbl.centerYAnchor.constraint(equalTo: card.centerYAnchor),
            titleLbl.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 15),

            actionLbl.centerYAnchor.constraint(equalTo: card.centerYAnchor),
            actionLbl.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -15)
        ])
    }

    // MARK: - OPEN SET AVAILABILITY
    @objc private func openSetAvailability() {
        let vc = PhysioSetAvailabilityViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
