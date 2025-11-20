import UIKit

final class PhysioSetAvailabilityView: UIView {

    let scrollView = UIScrollView()
    let contentView = UIView()

    // WEEK ROWS
    let days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    var dayRows: [UIView] = []

    // Publish Button
    let publishButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Set Availability", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        btn.layer.cornerRadius = 22.5        // capsule
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hex: "#E3F0FF")
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupUI() {

        addSubview(scrollView)
        scrollView.addSubview(contentView)

        // WEEK AVAILABILITY ROWS
        for day in days {
            let row = createDayRow(day: day)
            dayRows.append(row)
            contentView.addSubview(row)
        }

        contentView.addSubview(publishButton)
    }

    // MARK: - Day Row
    private func createDayRow(day: String) -> UIView {

        let card = UIView()
        card.backgroundColor = .white
        card.layer.cornerRadius = 16

        let dayLabel = UILabel()
        dayLabel.text = day
        dayLabel.font = .systemFont(ofSize: 16, weight: .semibold)

        let status = UILabel()
        status.text = "No availability"
        status.textColor = .gray
        status.font = .systemFont(ofSize: 14)
        status.tag = 2000   // for update

        let addButton = UIButton(type: .system)
        addButton.setTitle("Add", for: .normal)
        addButton.setTitleColor(.systemBlue, for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        addButton.tag = 3000 // identifier for controller

        [dayLabel, status, addButton].forEach {
            card.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            dayLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 15),
            dayLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: 12),

            status.leadingAnchor.constraint(equalTo: dayLabel.leadingAnchor),
            status.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 4),

            addButton.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -15),
            addButton.centerYAnchor.constraint(equalTo: dayLabel.centerYAnchor)
        ])

        return card
    }

    private func setupConstraints() {

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        publishButton.translatesAutoresizingMaskIntoConstraints = false

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

        var last = contentView.topAnchor

        for row in dayRows {
            row.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                row.topAnchor.constraint(equalTo: last, constant: 12),
                row.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                row.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                row.heightAnchor.constraint(equalToConstant: 80)
            ])
            last = row.bottomAnchor
        }

        NSLayoutConstraint.activate([
            publishButton.topAnchor.constraint(equalTo: last, constant: 30),
            publishButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            publishButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            publishButton.heightAnchor.constraint(equalToConstant: 45),
            publishButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
    }
}
