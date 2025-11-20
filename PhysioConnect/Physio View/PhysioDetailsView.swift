//
//  PhysioDetailsView.swift
//  PhysioConnect
//

import UIKit

class PhysioDetailsView: UIView, UITextViewDelegate {

    // FIXED TOP TITLE
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Tell us about you"
        lbl.font = UIFont.boldSystemFont(ofSize: 22)
        lbl.textAlignment = .center
        return lbl
    }()

    // SCROLL AREA
    let scrollView = UIScrollView()
    let contentView = UIView()

    // FIXED BOTTOM BUTTON
    let continueButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Continue", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 22
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 17)
        btn.heightAnchor.constraint(equalToConstant: 48).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    // INPUT FIELDS
    private func buildField(_ placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.placeholder = placeholder
        tf.font = .systemFont(ofSize: 16)
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor(hex: "#D4E3FE")?.cgColor
        tf.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tf.translatesAutoresizingMaskIntoConstraints = false

        let pad = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 50))
        tf.leftView = pad
        tf.leftViewMode = .always
        return tf
    }

    lazy var specializationField = buildField("Specialization")
    lazy var experienceField = buildField("Years of experience")
    lazy var institutionField = buildField("Institution")
    lazy var cityField = buildField("City / Location")
    lazy var qualificationField = buildField("Educational Qualification")

    let genderLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Gender"
        lbl.font = .systemFont(ofSize: 16, weight: .medium)
        return lbl
    }()

    let genderControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Male", "Female", "Other"])
        sc.selectedSegmentIndex = 0
        sc.backgroundColor = .white
        sc.selectedSegmentTintColor = .systemBlue
        sc.layer.cornerRadius = 10
        sc.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return sc
    }()

    let aboutField: UITextView = {
        let tv = UITextView()
        tv.font = .systemFont(ofSize: 16)
        tv.text = "About the doctor"
        tv.textColor = .lightGray
        tv.layer.cornerRadius = 10
        tv.layer.borderWidth = 1
        tv.layer.borderColor = UIColor(hex: "#D4E3FE")?.cgColor
        tv.backgroundColor = .white
        tv.heightAnchor.constraint(equalToConstant: 120).isActive = true
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    let proofButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Upload Qualification Proof", for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 10
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor(hex: "#D4E3FE")?.cgColor
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.tag = 1
        return btn
    }()

    let identityProofButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Upload Identity Proof", for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 10
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor(hex: "#D4E3FE")?.cgColor
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.tag = 2
        return btn
    }()

    // INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hex: "#E3F0FF")
        aboutField.delegate = self

        // FIXED TOP
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        // SCROLL VIEW
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false

        // FIXED BOTTOM
        addSubview(continueButton)

        // STACK INSIDE SCROLL
        let genderStack = UIStackView(arrangedSubviews: [genderLabel, genderControl])
        genderStack.axis = .vertical
        genderStack.spacing = 8

        let stack = UIStackView(arrangedSubviews: [
            specializationField,
            experienceField,
            institutionField,
            cityField,
            genderStack,
            qualificationField,
            aboutField,
            proofButton,
            identityProofButton
        ])

        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stack)

        // CONSTRAINTS
        NSLayoutConstraint.activate([

            // FIXED TOP TITLE
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            // SCROLL VIEW BELOW TITLE
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -12),

            // CONTENT VIEW
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            // STACK INSIDE SCROLL
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),

            // FIXED BOTTOM BUTTON
            continueButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            continueButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            continueButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    required init?(coder: NSCoder) { fatalError() }

    // PLACEHOLDER FOR ABOUT FIELD
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "About the doctor" {
            textView.text = ""
            textView.textColor = .black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespaces).isEmpty {
            textView.text = "About the doctor"
            textView.textColor = .lightGray
        }
    }
}
