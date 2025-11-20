import UIKit

final class PhysioSetDaysView: UIView {

    let scrollView = UIScrollView()
    let contentView = UIView()

    let daysTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Specific Days of Week"
        lbl.font = .boldSystemFont(ofSize: 17)
        return lbl
    }()

    let days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    var dayButtons: [UIButton] = []

    let startDateLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Start Date"
        lbl.font = .boldSystemFont(ofSize: 17)
        return lbl
    }()

    let startDateField = PhysioSetDaysView.createInput(icon: "calendar")

    let endDateLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "End Date"
        lbl.font = .boldSystemFont(ofSize: 17)
        return lbl
    }()

    let endDateField = PhysioSetDaysView.createInput(icon: "calendar")

    let noEndDateLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "No End Date"
        lbl.font = .systemFont(ofSize: 15)
        return lbl
    }()

    let noEndDateSwitch = UISwitch()

    let reminderLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Time of Day Reminder"
        lbl.font = .boldSystemFont(ofSize: 17)
        return lbl
    }()

    let reminderSwitch = UISwitch()

    let reminderTimeField = PhysioSetDaysView.createInput(icon: "clock")

    let confirmButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Confirm", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 22
        btn.titleLabel?.font = .boldSystemFont(ofSize: 17)
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hex: "#E3F0FF")
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) { fatalError() }

    // MARK: - Text Field Style
    static func createInput(icon: String) -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 18

        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 15)
        label.tag = 999

        let iconView = UIImageView(image: UIImage(systemName: icon))
        iconView.tintColor = .gray

        view.addSubview(label)
        view.addSubview(iconView)

        label.translatesAutoresizingMaskIntoConstraints = false
        iconView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            iconView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            iconView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 22)
        ])

        return view
    }

    // MARK: - UI Setup
    private func setupUI() {

        addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(daysTitle)

        // Create day buttons
        for d in days {
            let btn = UIButton(type: .system)
            btn.backgroundColor = .white
            btn.layer.cornerRadius = 18
            btn.contentHorizontalAlignment = .left
            btn.tag = 1000

            let circle = UIImageView(image: UIImage(systemName: "circle"))
            circle.tintColor = .gray
            circle.tag = 2000

            let lbl = UILabel()
            lbl.text = d
            lbl.font = .systemFont(ofSize: 15)
            lbl.textColor = .black

            btn.addSubview(circle)
            btn.addSubview(lbl)

            circle.translatesAutoresizingMaskIntoConstraints = false
            lbl.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                circle.leadingAnchor.constraint(equalTo: btn.leadingAnchor, constant: 15),
                circle.centerYAnchor.constraint(equalTo: btn.centerYAnchor),
                circle.widthAnchor.constraint(equalToConstant: 20),
                circle.heightAnchor.constraint(equalToConstant: 20),

                lbl.leadingAnchor.constraint(equalTo: circle.trailingAnchor, constant: 12),
                lbl.centerYAnchor.constraint(equalTo: btn.centerYAnchor)
            ])

            dayButtons.append(btn)
            contentView.addSubview(btn)
        }

        [
            startDateLabel, startDateField,
            endDateLabel, endDateField,
            noEndDateLabel, noEndDateSwitch,
            reminderLabel, reminderSwitch,
            reminderTimeField, confirmButton
        ].forEach { contentView.addSubview($0) }
    }


    // MARK: - Constraints
    private func setupConstraints() {

        scrollView.translatesAutoresizingMaskIntoConstraints = false
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

        daysTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            daysTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            daysTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])

        var last = daysTitle.bottomAnchor

        for btn in dayButtons {
            btn.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                btn.topAnchor.constraint(equalTo: last, constant: 15),
                btn.leadingAnchor.constraint(equalTo: daysTitle.leadingAnchor),
                btn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                btn.heightAnchor.constraint(equalToConstant: 48)
            ])
            last = btn.bottomAnchor
        }

        [
            startDateLabel, startDateField,
            endDateLabel, endDateField,
            noEndDateLabel, noEndDateSwitch,
            reminderLabel, reminderSwitch,
            reminderTimeField, confirmButton
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        NSLayoutConstraint.activate([
            startDateLabel.topAnchor.constraint(equalTo: last, constant: 25),
            startDateLabel.leadingAnchor.constraint(equalTo: daysTitle.leadingAnchor),

            startDateField.topAnchor.constraint(equalTo: startDateLabel.bottomAnchor, constant: 10),
            startDateField.leadingAnchor.constraint(equalTo: daysTitle.leadingAnchor),
            startDateField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            startDateField.heightAnchor.constraint(equalToConstant: 48),

            endDateLabel.topAnchor.constraint(equalTo: startDateField.bottomAnchor, constant: 25),
            endDateLabel.leadingAnchor.constraint(equalTo: daysTitle.leadingAnchor),

            endDateField.topAnchor.constraint(equalTo: endDateLabel.bottomAnchor, constant: 10),
            endDateField.leadingAnchor.constraint(equalTo: daysTitle.leadingAnchor),
            endDateField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            endDateField.heightAnchor.constraint(equalToConstant: 48),

            noEndDateLabel.topAnchor.constraint(equalTo: endDateField.bottomAnchor, constant: 20),
            noEndDateLabel.leadingAnchor.constraint(equalTo: daysTitle.leadingAnchor),

            noEndDateSwitch.centerYAnchor.constraint(equalTo: noEndDateLabel.centerYAnchor),
            noEndDateSwitch.trailingAnchor.constraint(equalTo: endDateField.trailingAnchor),

            reminderLabel.topAnchor.constraint(equalTo: noEndDateLabel.bottomAnchor, constant: 25),
            reminderLabel.leadingAnchor.constraint(equalTo: daysTitle.leadingAnchor),

            reminderSwitch.centerYAnchor.constraint(equalTo: reminderLabel.centerYAnchor),
            reminderSwitch.trailingAnchor.constraint(equalTo: endDateField.trailingAnchor),

            reminderTimeField.topAnchor.constraint(equalTo: reminderLabel.bottomAnchor, constant: 10),
            reminderTimeField.leadingAnchor.constraint(equalTo: daysTitle.leadingAnchor),
            reminderTimeField.trailingAnchor.constraint(equalTo: endDateField.trailingAnchor),
            reminderTimeField.heightAnchor.constraint(equalToConstant: 48),

            confirmButton.topAnchor.constraint(equalTo: reminderTimeField.bottomAnchor, constant: 40),
            confirmButton.leadingAnchor.constraint(equalTo: daysTitle.leadingAnchor),
            confirmButton.trailingAnchor.constraint(equalTo: endDateField.trailingAnchor),
            confirmButton.heightAnchor.constraint(equalToConstant: 50),

            confirmButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
}
