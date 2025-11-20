import UIKit

final class PhysioSetDaysViewController: UIViewController {

    private let mainView = PhysioSetDaysView()

    private let datePicker = UIDatePicker()
    private let timePicker = UIDatePicker()

    override func loadView() { view = mainView }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Set Program Schedule"

        setupDayButtons()
        setupFieldTapActions()

        // 👉 ADD THIS — Navigate to Confirm Schedule Screen
        mainView.confirmButton.addTarget(self, action: #selector(confirmPressed), for: .touchUpInside)
    }

    // Navigate to Confirm Schedule (Static Version)
    @objc private func confirmPressed() {
        let vc = PhysioSetScheduleViewController()   // your static confirm screen
        navigationController?.pushViewController(vc, animated: true)
    }

    private func setupDayButtons() {
        for btn in mainView.dayButtons {
            btn.addTarget(self, action: #selector(toggleDay(_:)), for: .touchUpInside)
        }
    }

    @objc private func toggleDay(_ sender: UIButton) {
        let circle = sender.viewWithTag(2000) as! UIImageView
        let selected = circle.image == UIImage(systemName: "largecircle.fill.circle")

        if selected {
            circle.image = UIImage(systemName: "circle")
            circle.tintColor = .gray
        } else {
            circle.image = UIImage(systemName: "largecircle.fill.circle")
            circle.tintColor = .systemBlue
        }
    }

    private func setupFieldTapActions() {

        let startTap = UITapGestureRecognizer(target: self, action: #selector(openStartPicker))
        mainView.startDateField.addGestureRecognizer(startTap)

        let endTap = UITapGestureRecognizer(target: self, action: #selector(openEndPicker))
        mainView.endDateField.addGestureRecognizer(endTap)

        let timeTap = UITapGestureRecognizer(target: self, action: #selector(openTimePicker))
        mainView.reminderTimeField.addGestureRecognizer(timeTap)
    }

    @objc private func openStartPicker() {
        datePicker.datePickerMode = .date

        let alert = UIAlertController(title: "Select Start Date", message: "\n\n\n\n\n\n\n\n\n", preferredStyle: .actionSheet)

        datePicker.frame = CGRect(x: 0, y: 40, width: alert.view.frame.width - 20, height: 200)

        alert.view.addSubview(datePicker)

        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { _ in
            let f = DateFormatter()
            f.dateFormat = "dd/MM/yyyy"
            let lbl = self.mainView.startDateField.viewWithTag(999) as! UILabel
            lbl.text = f.string(from: self.datePicker.date)
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }

    @objc private func openEndPicker() {
        datePicker.datePickerMode = .date

        let alert = UIAlertController(title: "Select End Date", message: "\n\n\n\n\n\n\n\n\n", preferredStyle: .actionSheet)

        datePicker.frame = CGRect(x: 0, y: 40, width: alert.view.frame.width - 20, height: 200)

        alert.view.addSubview(datePicker)

        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { _ in
            let f = DateFormatter()
            f.dateFormat = "dd/MM/yyyy"
            let lbl = self.mainView.endDateField.viewWithTag(999) as! UILabel
            lbl.text = f.string(from: self.datePicker.date)
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }

    @objc private func openTimePicker() {
        timePicker.datePickerMode = .time

        let alert = UIAlertController(title: "Select Time", message: "\n\n\n\n\n\n\n\n\n", preferredStyle: .actionSheet)

        timePicker.frame = CGRect(x: 0, y: 40, width: alert.view.frame.width - 20, height: 200)

        alert.view.addSubview(timePicker)

        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { _ in
            let f = DateFormatter()
            f.dateFormat = "hh:mm a"
            let lbl = self.mainView.reminderTimeField.viewWithTag(999) as! UILabel
            lbl.text = f.string(from: self.timePicker.date)
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}
