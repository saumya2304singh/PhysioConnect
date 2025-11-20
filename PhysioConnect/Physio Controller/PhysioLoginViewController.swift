import UIKit

class PhysioLoginViewController: UIViewController {

    private let loginView = PhysioLoginView()

    override func loadView() {
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: false)
        setupActions()
    }

    private func setupActions() {
        loginView.loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        loginView.signUpButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        loginView.forgotPasswordButton.addTarget(self, action: #selector(handleForgotPassword), for: .touchUpInside)
    }

    @objc private func handleLogin() {

        let dashVC = PhysioDashboardViewController()

        // 🟦 Make Dashboard the NEW ROOT of navigation
        navigationController?.setViewControllers([dashVC], animated: true)
    }

    @objc private func handleSignUp() {
        dismiss(animated: true)
    }

    @objc private func handleForgotPassword() {
        let forgotVC = ForgotPassViewController()
        navigationController?.pushViewController(forgotVC, animated: true)
    }
}
