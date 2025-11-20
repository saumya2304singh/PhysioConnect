//
//  PhysioDetailsViewController.swift
//  PhysioConnect
//

import UIKit

class PhysioDetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private let mainView = PhysioDetailsView()
    private var model = PhysioDetailsModel()

    private var qualificationProofImage: UIImage?
    private var identityProofImage: UIImage?

    // MARK: - Load View
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.continueButton.addTarget(self, action: #selector(handleContinue), for: .touchUpInside)

        mainView.proofButton.addTarget(self, action: #selector(openPicker(_:)), for: .touchUpInside)
        mainView.identityProofButton.addTarget(self, action: #selector(openPicker(_:)), for: .touchUpInside)
    }

    // MARK: - Image Picker
    @objc func openPicker(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary

        // Tag used to identify which button triggered it
        picker.view.tag = sender.tag

        present(picker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        let img = info[.editedImage] as? UIImage ??
                  info[.originalImage] as? UIImage

        if picker.view.tag == 1 {
            // Qualification image
            qualificationProofImage = img
            mainView.proofButton.setTitle("Uploaded ✓", for: .normal)
            mainView.proofButton.setTitleColor(.systemGreen, for: .normal)
        } else {
            // Identity proof image
            identityProofImage = img
            mainView.identityProofButton.setTitle("Uploaded ✓", for: .normal)
            mainView.identityProofButton.setTitleColor(.systemGreen, for: .normal)
        }

        dismiss(animated: true)
    }

    // MARK: - Continue Logic
    @objc private func handleContinue() {

        // Transfer UI values to model
        model.specialization = mainView.specializationField.text ?? ""
        model.experience = mainView.experienceField.text ?? ""
        model.institution = mainView.institutionField.text ?? ""
        model.city = mainView.cityField.text ?? ""
        model.qualification = mainView.qualificationField.text ?? ""
        model.gender = mainView.genderControl.titleForSegment(at: mainView.genderControl.selectedSegmentIndex) ?? ""

        if mainView.aboutField.text != "About the doctor" {
            model.about = mainView.aboutField.text
        }

        model.qualificationProof = qualificationProofImage
        model.identityProof = identityProofImage

        // Validation
        if !model.isValid {
            alert("Please fill all required fields and upload both documents.")
            shakeFields()
            return
        }

        print("MODEL COMPLETE → \(model)")

        // MARK: - Navigate to Dashboard
        let dashboardVC = PhysioDashboardViewController()
        navigationController?.pushViewController(dashboardVC, animated: true)
    }

    // MARK: - Alert
    private func alert(_ msg: String) {
        let a = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
        a.addAction(UIAlertAction(title: "OK", style: .default))
        present(a, animated: true)
    }

    // MARK: - Shake Animation
    private func shakeFields() {
        let fields = [
            mainView.specializationField,
            mainView.experienceField,
            mainView.institutionField,
            mainView.cityField,
            mainView.qualificationField
        ]

        fields.forEach { f in
            if f.text?.isEmpty == true {
                UIView.animate(withDuration: 0.05, animations: {
                    f.transform = CGAffineTransform(translationX: 8, y: 0)
                }) { _ in
                    f.transform = .identity
                }
            }
        }

        if mainView.aboutField.text == "About the doctor" {
            UIView.animate(withDuration: 0.05, animations: {
                self.mainView.aboutField.transform = CGAffineTransform(translationX: 8, y: 0)
            }) { _ in
                self.mainView.aboutField.transform = .identity
            }
        }
    }
}
