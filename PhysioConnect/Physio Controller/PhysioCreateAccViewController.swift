import UIKit

class PhysioCreateAccController: UIViewController {

    private let mainView = PhysioCreateAccView()

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: false)
        setupActions()
    }

    private func setupActions() {
        mainView.createButton.addTarget(self, action: #selector(createAccountTapped), for: .touchUpInside)
        mainView.signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
    }

    @objc private func createAccountTapped() {
        let nextVC = PhysioDetailsViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }

    @objc private func signInTapped() {
        let loginVC = PhysioLoginViewController()
        let nav = UINavigationController(rootViewController: loginVC)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
}
