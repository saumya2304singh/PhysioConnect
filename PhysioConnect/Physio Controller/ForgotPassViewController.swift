// ForgotPassViewController.swift
import UIKit

class ForgotPassViewController: UIViewController {

    private let mainView = ForgotPassView()
    private var model = ForgotPassModel()

    override func loadView() { view = mainView }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        mainView.continueBtn.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
    }

    @objc func continueTapped() {
        model.email = mainView.emailField.text ?? ""
        // Minimal validation
        guard !model.email.isEmpty else {
            print("Please enter email")
            return
        }

        // Show small confirmation popup then go to OTP
        let popup = VerificationPopupView()
        popup.show(in: self.view)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            popup.dismiss()
            let otpVC = PhysioOTPViewController()
            self.navigationController?.pushViewController(otpVC, animated: true)
        }
    }
}
