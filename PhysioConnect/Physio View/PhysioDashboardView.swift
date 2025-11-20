import UIKit

final class PhysioDashboardView: UIView {

    // MARK: - Scroll Area
    let scrollView = UIScrollView()
    let contentView = UIView()

    // MARK: - Section Titles
    let patientsTitle = UILabel()
    let upcomingTitle = UILabel()
    let tasksTitle = UILabel()

    // MARK: - Cards
    let patientCard1 = UIView()
    let patientCard2 = UIView()
    let patientCard3 = UIView()

    let appointmentCard1 = UIView()
    let appointmentCard2 = UIView()

    let pendingCard = UIView()
    let availabilityCard = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hex: "#E3F0FF")
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func styleCard(_ v: UIView) {
        v.backgroundColor = .white
        v.layer.cornerRadius = 24
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.1
        v.layer.shadowOffset = CGSize(width: 0, height: 3)
        v.layer.shadowRadius = 4
    }

    private func setupUI() {

        // Titles
        patientsTitle.text = "My Patients"
        patientsTitle.font = .boldSystemFont(ofSize: 18)

        upcomingTitle.text = "Upcoming Appointments"
        upcomingTitle.font = .boldSystemFont(ofSize: 18)

        tasksTitle.text = "Tasks & Alerts"
        tasksTitle.font = .boldSystemFont(ofSize: 18)

        [
            patientCard1, patientCard2, patientCard3,
            appointmentCard1, appointmentCard2,
            pendingCard, availabilityCard
        ].forEach { styleCard($0) }

        // Add scroll view and content
        addSubview(scrollView)
        scrollView.addSubview(contentView)

        // Add all content into the scrolling container
        [
            patientsTitle, patientCard1, patientCard2, patientCard3,
            upcomingTitle, appointmentCard1, appointmentCard2,
            tasksTitle, pendingCard, availabilityCard
        ].forEach { contentView.addSubview($0) }
    }

    // MARK: - Constraints
    private func setupConstraints() {

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        patientsTitle.translatesAutoresizingMaskIntoConstraints = false
        patientCard1.translatesAutoresizingMaskIntoConstraints = false
        patientCard2.translatesAutoresizingMaskIntoConstraints = false
        patientCard3.translatesAutoresizingMaskIntoConstraints = false

        upcomingTitle.translatesAutoresizingMaskIntoConstraints = false
        appointmentCard1.translatesAutoresizingMaskIntoConstraints = false
        appointmentCard2.translatesAutoresizingMaskIntoConstraints = false

        tasksTitle.translatesAutoresizingMaskIntoConstraints = false
        pendingCard.translatesAutoresizingMaskIntoConstraints = false
        availabilityCard.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            // ScrollView attaches directly under navigation bar
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            // My Patients
            patientsTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            patientsTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            patientCard1.topAnchor.constraint(equalTo: patientsTitle.bottomAnchor, constant: 12),
            patientCard1.leadingAnchor.constraint(equalTo: patientsTitle.leadingAnchor),
            patientCard1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            patientCard1.heightAnchor.constraint(equalToConstant: 95),

            patientCard2.topAnchor.constraint(equalTo: patientCard1.bottomAnchor, constant: 12),
            patientCard2.leadingAnchor.constraint(equalTo: patientCard1.leadingAnchor),
            patientCard2.trailingAnchor.constraint(equalTo: patientCard1.trailingAnchor),
            patientCard2.heightAnchor.constraint(equalToConstant: 95),

            patientCard3.topAnchor.constraint(equalTo: patientCard2.bottomAnchor, constant: 12),
            patientCard3.leadingAnchor.constraint(equalTo: patientCard1.leadingAnchor),
            patientCard3.trailingAnchor.constraint(equalTo: patientCard1.trailingAnchor),
            patientCard3.heightAnchor.constraint(equalToConstant: 95),

            // Upcoming Appointments
            upcomingTitle.topAnchor.constraint(equalTo: patientCard3.bottomAnchor, constant: 28),
            upcomingTitle.leadingAnchor.constraint(equalTo: patientsTitle.leadingAnchor),

            appointmentCard1.topAnchor.constraint(equalTo: upcomingTitle.bottomAnchor, constant: 12),
            appointmentCard1.leadingAnchor.constraint(equalTo: patientCard1.leadingAnchor),
            appointmentCard1.trailingAnchor.constraint(equalTo: patientCard1.trailingAnchor),
            appointmentCard1.heightAnchor.constraint(equalToConstant: 60),

            appointmentCard2.topAnchor.constraint(equalTo: appointmentCard1.bottomAnchor, constant: 12),
            appointmentCard2.leadingAnchor.constraint(equalTo: patientCard1.leadingAnchor),
            appointmentCard2.trailingAnchor.constraint(equalTo: patientCard1.trailingAnchor),
            appointmentCard2.heightAnchor.constraint(equalToConstant: 60),

            // Tasks & Alerts
            tasksTitle.topAnchor.constraint(equalTo: appointmentCard2.bottomAnchor, constant: 28),
            tasksTitle.leadingAnchor.constraint(equalTo: patientsTitle.leadingAnchor),

            pendingCard.topAnchor.constraint(equalTo: tasksTitle.bottomAnchor, constant: 12),
            pendingCard.leadingAnchor.constraint(equalTo: patientCard1.leadingAnchor),
            pendingCard.trailingAnchor.constraint(equalTo: patientCard1.trailingAnchor),
            pendingCard.heightAnchor.constraint(equalToConstant: 55),

            availabilityCard.topAnchor.constraint(equalTo: pendingCard.bottomAnchor, constant: 12),
            availabilityCard.leadingAnchor.constraint(equalTo: pendingCard.leadingAnchor),
            availabilityCard.trailingAnchor.constraint(equalTo: pendingCard.trailingAnchor),
            availabilityCard.heightAnchor.constraint(equalToConstant: 55),

            availabilityCard.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
    }
}
