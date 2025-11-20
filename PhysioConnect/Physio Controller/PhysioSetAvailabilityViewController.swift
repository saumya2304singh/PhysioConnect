import UIKit

final class PhysioSetAvailabilityViewController: UIViewController {

    private let mainView = PhysioSetAvailabilityView()

    override func loadView() { view = mainView }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Set Availability"

        setupAddButtons()
        setupPublishAction()
    }

    // MARK: - Make "Add" buttons active
    private func setupAddButtons() {
        for row in mainView.dayRows {
            if let addButton = row.viewWithTag(3000) as? UIButton {
                addButton.addTarget(self, action: #selector(addTimeSlot(_:)), for: .touchUpInside)
            }
        }
    }

    @objc private func addTimeSlot(_ sender: UIButton) {
        let alert = UIAlertController(
            title: "Select Availability",
            message: "Choose a preset time slot",
            preferredStyle: .actionSheet
        )

        let slots = [
            "08:00 AM – 11:00 AM",
            "10:00 AM – 12:00 PM",
            "01:00 PM – 04:00 PM",
            "03:00 PM – 06:00 PM"
        ]

        for slot in slots {
            alert.addAction(UIAlertAction(title: slot, style: .default, handler: { _ in
                if let row = sender.superview,
                   let label = row.viewWithTag(2000) as? UILabel {
                    label.text = slot
                    label.textColor = .black
                }
            }))
        }

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }

    // MARK: - Publish Button
    private func setupPublishAction() {
        mainView.publishButton.addTarget(self, action: #selector(publishTapped), for: .touchUpInside)
    }

    @objc private func publishTapped() {

        let alert = UIAlertController(
            title: "Success",
            message: "Availability has been set successfully.",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            // Go back to Dashboard (root)
            self.navigationController?.popToRootViewController(animated: true)
        }))

        present(alert, animated: true)
    }
}
