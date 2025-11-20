// WelcomePageViewController.swift
import UIKit

class WelcomePageViewController: UIViewController {

    private let welcomeView = WelcomePageView()

    override func loadView() { view = welcomeView }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Keep nav bar hidden for Apple-like full-screen onboarding
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupActions()
    }

    private func setupActions() {
        welcomeView.patientButton.addTarget(self, action: #selector(handlePatientTap), for: .touchUpInside)
        welcomeView.physioButton.addTarget(self, action: #selector(handlePhysioTap), for: .touchUpInside)
    }

    @objc private func handlePatientTap() {
        // Add patient flow later
        print("Patient tapped")
    }

    @objc private func handlePhysioTap() {
        let signUpVC = PhysioSignUpViewController()
        let nav = UINavigationController(rootViewController: signUpVC)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
}
