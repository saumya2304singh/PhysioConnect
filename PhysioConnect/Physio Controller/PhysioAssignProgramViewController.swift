import UIKit

final class PhysioAssignProgramViewController: UIViewController {

    private let mainView = PhysioAssignProgramView()
    private var programModel = PhysioAssignProgram()

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(hex: "#E3F0FF")

        // Navigation Bar Title
        navigationItem.title = "Assign Program"
        navigationItem.backButtonTitle = "Back"

        setupDropdown()
        mainView.redeemCodeLabel.text = programModel.redeemCode

        // Navigate to Select Videos
        mainView.selectVideosButton.addTarget(self, action: #selector(openSelectExercise), for: .touchUpInside)

        // 👉 Navigate to Set Days (NEW)
        mainView.setDaysButton.addTarget(self, action: #selector(openSetDays), for: .touchUpInside)
    }

    // MARK: - Dropdown for Template Selection
    private func setupDropdown() {

        let actions = programModel.templates.map { template in
            UIAction(title: template) { [weak self] _ in
                guard let self else { return }

                // Update selected value
                self.programModel.selectedTemplate = template

                // Update button title
                self.mainView.templateButton.setTitle(template, for: .normal)
            }
        }

        mainView.templateButton.menu = UIMenu(children: actions)
    }

    // MARK: - Navigation to Select Exercise Screen
    @objc private func openSelectExercise() {
        let vc = PhysioSelectExerciseViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - Navigation to Set Days Screen
    @objc private func openSetDays() {
        let vc = PhysioSetDaysViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
