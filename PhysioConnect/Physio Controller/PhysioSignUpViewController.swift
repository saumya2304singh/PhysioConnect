import UIKit

class PhysioSignUpViewController: UIViewController {

    private let signUpView = PhysioSignUpView()

    override func loadView() {
        view = signUpView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: false)
        setupActions()
    }

    private func setupActions() {
        signUpView.signUpButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        signUpView.loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        signUpView.googleButton.addTarget(self, action: #selector(handleGoogle), for: .touchUpInside)
        signUpView.appleButton.addTarget(self, action: #selector(handleApple), for: .touchUpInside)
    }

    @objc private func handleSignUp() {
        let createVC = PhysioCreateAccController()
        navigationController?.pushViewController(createVC, animated: true)
    }

    @objc private func handleLogin() {
        let loginVC = PhysioLoginViewController()
        let nav = UINavigationController(rootViewController: loginVC)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }

    @objc private func handleGoogle() {
        print("Google tapped")
    }

    @objc private func handleApple() {
        print("Apple tapped")
    }
}
