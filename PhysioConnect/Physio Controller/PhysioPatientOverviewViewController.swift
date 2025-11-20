import UIKit

final class PhysioPatientOverviewViewController: UIViewController {

    private let mainView = PhysioPatientOverviewView()

    // Passed from Dashboard
    var patientName: String?
    var patientSubtitle: String?
    var patientActivity: String?
    var patientImageName: String?

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(hex: "#E3F0FF")

        // NAV BAR SETTINGS
        navigationController?.navigationBar.isHidden = false
        navigationItem.hidesBackButton = false
        navigationItem.backButtonTitle = "Back"
        navigationItem.title = "Patient Overview"
        
        // Add button action
        mainView.assignButton.addTarget(self, action: #selector(openAssignProgram), for: .touchUpInside)

        setupData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.hidesBackButton = false
    }

    private func setupData() {
        mainView.nameLabel.text = patientName
        mainView.subtitleLabel.text = patientSubtitle
        mainView.activityLabel.text = patientActivity
        
        if let imgName = patientImageName {
            mainView.patientImage.image = UIImage(named: imgName)
        }

        mainView.ageValue.text = "33 / Female"
        mainView.contactValue.text = "+91 8758163713"
        mainView.therapistValue.text = "Dr. David Patel"
    }

    // MARK: - Navigation
    @objc private func openAssignProgram() {
        let vc = PhysioAssignProgramViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
