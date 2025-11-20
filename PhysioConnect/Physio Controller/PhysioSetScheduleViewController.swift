import UIKit

final class PhysioSetScheduleViewController: UIViewController {

    private let mainView = PhysioSetScheduleView()

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(hex: "#E3F0FF")
        navigationItem.title = "Confirm Schedule"
        navigationItem.backButtonTitle = "Back"

        mainView.assignButton.addTarget(self, action: #selector(assignToPatient), for: .touchUpInside)
    }

    @objc private func assignToPatient() {
        let alert = UIAlertController(
            title: "Assigned",
            message: "The program has been assigned successfully.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
