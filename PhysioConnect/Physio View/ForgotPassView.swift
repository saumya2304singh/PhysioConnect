// ForgotPassView.swift
import UIKit

class ForgotPassView: UIView {
    let titleLabel: UILabel = { let l=UILabel(); l.text = "Confirm your email."; l.font = .boldSystemFont(ofSize: 22); l.textAlignment = .center; return l }()
    let subTitleLabel: UILabel = { let l=UILabel(); l.text = "We will send you a mail to enter the app"; l.font = .systemFont(ofSize: 13); l.textColor = .darkGray; l.textAlignment = .center; return l }()
    let emailField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Your Email"
        tf.font = .systemFont(ofSize: 16)
        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor(hex: "#d4e3fe")?.cgColor
        tf.backgroundColor = .white
        tf.heightAnchor.constraint(equalToConstant: 50).isActive = true
        let icon = UIImageView(image: UIImage(systemName: "envelope.fill")); icon.tintColor = .gray; icon.frame = CGRect(x:10,y:0,width:22,height:22)
        let container = UIView(frame: CGRect(x:0,y:0,width:40,height:55)); icon.center.y = container.center.y; container.addSubview(icon)
        tf.leftView = container; tf.leftViewMode = .always
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    let continueBtn: UIButton = { let b = UIButton(); b.setTitle("Continue", for:.normal); b.titleLabel?.font = .boldSystemFont(ofSize:18); b.backgroundColor = .systemBlue; b.layer.cornerRadius = 20; b.clipsToBounds = true; b.heightAnchor.constraint(equalToConstant: 40).isActive = true; b.setTitleColor(.white, for:.normal); b.translatesAutoresizingMaskIntoConstraints = false; return b }()
    override init(frame:CGRect){ super.init(frame:frame); backgroundColor = UIColor(hex: "#E3F0FF") ?? .systemBackground; [titleLabel, subTitleLabel, emailField, continueBtn].forEach { addSubview($0); $0.translatesAutoresizingMaskIntoConstraints = false }; setupConstraints() }
    required init?(coder: NSCoder){ fatalError("init(coder:) not implemented") }
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 180),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emailField.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 24),
            emailField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            emailField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            continueBtn.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 28),
            continueBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            continueBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)
        ])
    }
}
