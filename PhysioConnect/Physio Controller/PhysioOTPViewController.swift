// PhysioOTPViewController.swift
import UIKit

class PhysioOTPViewController: UIViewController {

    private let mainView = PhysioOTPView()
    private var model = PhysioOTPModel()

    override func loadView() { view = mainView }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Hide nav bar, disable pop gesture to make OTP modal-like
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        setupActions()
    }

    private func setupActions() {
        mainView.verifyBtn.addTarget(self, action: #selector(verifyTapped), for: .touchUpInside)
        mainView.resendButton.addTarget(self, action: #selector(resendTapped), for: .touchUpInside)
    }

    @objc func verifyTapped() {
        model.code = (mainView.tf1.text ?? "") + (mainView.tf2.text ?? "") + (mainView.tf3.text ?? "") + (mainView.tf4.text ?? "")
        if model.isValidCode() {
            showSuccessPopup()
        } else {
            print("Invalid OTP — show inline error UI")
        }
    }

    @objc func resendTapped() {
        print("Resend code tapped")
    }

    func showSuccessPopup() {
        let popup = VerificationSuccessPopupView()
        popup.show(in: self.view)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
            popup.dismiss {
                // Dismiss the whole signUp/login modal stack and present a fresh Login modal
                if let presenting = self.navigationController?.presentingViewController {
                    self.navigationController?.dismiss(animated: true) {
                        let loginVC = PhysioLoginViewController()
                        let loginNav = UINavigationController(rootViewController: loginVC)
                        loginNav.modalPresentationStyle = .fullScreen
                        presenting.present(loginNav, animated: true)
                    }
                } else {
                    // fallback: reset controller stack to login (if inside same nav)
                    let loginVC = PhysioLoginViewController()
                    self.navigationController?.setViewControllers([loginVC], animated: true)
                }
            }
        }
    }
}
