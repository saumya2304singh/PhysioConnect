// PhysioOTPView.swift
import UIKit

class PhysioOTPView: UIView {
    let titleLabel: UILabel = { let l=UILabel(); l.text="Enter Code"; l.font = .boldSystemFont(ofSize:22); l.textAlignment = .center; return l }()
    let subTitleLabel: UILabel = { let l=UILabel(); l.text="We have sent a code to your email"; l.font = .systemFont(ofSize:15); l.textColor = .darkGray; l.textAlignment = .center; return l }()
    let tf1 = PhysioOTPView.createOTPBox(); let tf2 = PhysioOTPView.createOTPBox(); let tf3 = PhysioOTPView.createOTPBox(); let tf4 = PhysioOTPView.createOTPBox()
    static func createOTPBox() -> UITextField {
        let tf = UITextField(); tf.textAlignment = .center; tf.keyboardType = .numberPad; tf.layer.cornerRadius = 10; tf.layer.borderWidth = 1; tf.layer.borderColor = UIColor(hex: "#d4e3fe")?.cgColor; tf.font = .systemFont(ofSize:20); tf.translatesAutoresizingMaskIntoConstraints = false; return tf
    }
    let verifyBtn: UIButton = { let b=UIButton(); b.setTitle("Verify", for:.normal); b.backgroundColor = .systemBlue; b.setTitleColor(.white, for:.normal); b.titleLabel?.font = .boldSystemFont(ofSize:18); b.layer.cornerRadius = 25; b.translatesAutoresizingMaskIntoConstraints = false; return b }()
    let resendLabel: UILabel = { let l=UILabel(); l.text="Didn't receive code?"; l.font = .systemFont(ofSize:15); l.textColor = .darkGray; return l }()
    let resendButton: UIButton = { let b=UIButton(); b.setTitle("Resend code", for:.normal); b.setTitleColor(.systemBlue, for:.normal); b.titleLabel?.font = .boldSystemFont(ofSize:15); return b }()
    override init(frame:CGRect){ super.init(frame:frame); backgroundColor = UIColor(hex: "#E3F0FF") ?? .systemBackground; addSubview(titleLabel); addSubview(subTitleLabel)
        let otpStack = UIStackView(arrangedSubviews:[tf1,tf2,tf3,tf4]); otpStack.axis = .horizontal; otpStack.spacing = 12; otpStack.distribution = .equalSpacing; otpStack.translatesAutoresizingMaskIntoConstraints = false; addSubview(otpStack)
        addSubview(verifyBtn)
        let resendStack = UIStackView(arrangedSubviews:[resendLabel,resendButton]); resendStack.axis = .horizontal; resendStack.spacing = 8; resendStack.translatesAutoresizingMaskIntoConstraints = false; addSubview(resendStack)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false; subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 180),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            otpStack.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 28),
            otpStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            tf1.widthAnchor.constraint(equalToConstant:55), tf1.heightAnchor.constraint(equalToConstant:55),
            tf2.widthAnchor.constraint(equalToConstant:55), tf2.heightAnchor.constraint(equalToConstant:55),
            tf3.widthAnchor.constraint(equalToConstant:55), tf3.heightAnchor.constraint(equalToConstant:55),
            tf4.widthAnchor.constraint(equalToConstant:55), tf4.heightAnchor.constraint(equalToConstant:55),
            verifyBtn.topAnchor.constraint(equalTo: otpStack.bottomAnchor, constant: 30),
            verifyBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            verifyBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            verifyBtn.heightAnchor.constraint(equalToConstant: 50),
            resendStack.topAnchor.constraint(equalTo: verifyBtn.bottomAnchor, constant: 16),
            resendStack.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    required init?(coder:NSCoder){ fatalError("init(coder:) not implemented") }
}
