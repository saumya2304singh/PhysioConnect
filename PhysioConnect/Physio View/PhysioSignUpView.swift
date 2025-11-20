// PhysioSignUpView.swift
import UIKit

class PhysioSignUpView: UIView {
    let yogaImageView: UIImageView = {
        let iv = UIImageView(); iv.image = UIImage(named: "Welcome"); iv.contentMode = .scaleAspectFill; iv.layer.cornerRadius = 20; iv.clipsToBounds = true; iv.translatesAutoresizingMaskIntoConstraints = false; return iv
    }()
    let titleLabel: UILabel = { let l = UILabel(); l.text = "PhysioConnect"; l.font = .boldSystemFont(ofSize: 26); l.textAlignment = .center; l.translatesAutoresizingMaskIntoConstraints = false; return l }()
    let subtitleLabel: UILabel = { let l = UILabel(); l.text = "Find the perfect physiotherapist and\nresources to support your health journey."; l.numberOfLines = 2; l.font = .systemFont(ofSize: 15); l.textColor = .darkGray; l.textAlignment = .center; l.translatesAutoresizingMaskIntoConstraints = false; return l }()
    let signUpButton: UIButton = { let b = UIButton(type:.system); b.setTitle("Sign Up", for:.normal); b.backgroundColor = .systemBlue; b.setTitleColor(.white, for:.normal); b.layer.cornerRadius = 24; b.translatesAutoresizingMaskIntoConstraints = false; return b }()
    let loginButton: UIButton = { let b = UIButton(type:.system); b.setTitle("Login", for:.normal); b.setTitleColor(.systemBlue, for:.normal); b.backgroundColor = UIColor.white.withAlphaComponent(0.9); b.layer.cornerRadius = 24; b.translatesAutoresizingMaskIntoConstraints = false; return b }()
    let leftLine = UIView(); let rightLine = UIView()
    let separatorLabel: UILabel = { let l = UILabel(); l.text = "Or continue with"; l.textColor = .gray; l.font = .systemFont(ofSize:13); l.translatesAutoresizingMaskIntoConstraints = false; return l }()
    let googleButton: UIButton = { let b = UIButton(type:.system); b.setTitle("  Google", for:.normal); b.setImage(UIImage(named:"google"), for:.normal); b.tintColor = .black; b.backgroundColor = .white; b.layer.cornerRadius = 12; b.layer.borderWidth = 0.3; b.layer.borderColor = UIColor.lightGray.cgColor; b.setTitleColor(.black, for:.normal); b.translatesAutoresizingMaskIntoConstraints = false; return b }()
    let appleButton: UIButton = { let b = UIButton(type:.system); b.setTitle("  Apple", for:.normal); b.setImage(UIImage(systemName:"applelogo"), for:.normal); b.tintColor = .black; b.backgroundColor = .white; b.layer.cornerRadius = 12; b.layer.borderWidth = 0.3; b.layer.borderColor = UIColor.lightGray.cgColor; b.setTitleColor(.black, for:.normal); b.translatesAutoresizingMaskIntoConstraints = false; return b }()
    override init(frame:CGRect) {
        super.init(frame:frame)
        backgroundColor = UIColor(hex: "#E3F0FF") ?? .systemBackground
        leftLine.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        rightLine.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        [yogaImageView,titleLabel,subtitleLabel,signUpButton,loginButton,leftLine,separatorLabel,rightLine,googleButton,appleButton].forEach { addSubview($0); $0.translatesAutoresizingMaskIntoConstraints = false }
        setupConstraints()
    }
    required init?(coder: NSCoder) { fatalError() }
    private func setupConstraints(){
        let s = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            yogaImageView.topAnchor.constraint(equalTo: s.topAnchor, constant: 80),
            yogaImageView.leadingAnchor.constraint(equalTo: s.leadingAnchor, constant: 20),
            yogaImageView.trailingAnchor.constraint(equalTo: s.trailingAnchor, constant: -20),
            yogaImageView.heightAnchor.constraint(equalToConstant: 220),

            titleLabel.topAnchor.constraint(equalTo: yogaImageView.bottomAnchor, constant: 18),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: s.leadingAnchor, constant: 28),
            subtitleLabel.trailingAnchor.constraint(equalTo: s.trailingAnchor, constant: -28),

            signUpButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 28),
            signUpButton.leadingAnchor.constraint(equalTo: s.leadingAnchor, constant: 40),
            signUpButton.trailingAnchor.constraint(equalTo: s.trailingAnchor, constant: -40),
            signUpButton.heightAnchor.constraint(equalToConstant: 44),

            loginButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 12),
            loginButton.leadingAnchor.constraint(equalTo: signUpButton.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: signUpButton.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 44),

            separatorLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 28),
            separatorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            leftLine.centerYAnchor.constraint(equalTo: separatorLabel.centerYAnchor),
            leftLine.leadingAnchor.constraint(equalTo: s.leadingAnchor, constant: 40),
            leftLine.trailingAnchor.constraint(equalTo: separatorLabel.leadingAnchor, constant: -8),
            leftLine.heightAnchor.constraint(equalToConstant: 1),

            rightLine.centerYAnchor.constraint(equalTo: separatorLabel.centerYAnchor),
            rightLine.leadingAnchor.constraint(equalTo: separatorLabel.trailingAnchor, constant: 8),
            rightLine.trailingAnchor.constraint(equalTo: s.trailingAnchor, constant: -40),
            rightLine.heightAnchor.constraint(equalToConstant: 1),

            googleButton.topAnchor.constraint(equalTo: separatorLabel.bottomAnchor, constant: 20),
            googleButton.leadingAnchor.constraint(equalTo: s.leadingAnchor, constant: 40),
            googleButton.trailingAnchor.constraint(equalTo: s.centerXAnchor, constant: -10),
            googleButton.heightAnchor.constraint(equalToConstant: 40),

            appleButton.topAnchor.constraint(equalTo: separatorLabel.bottomAnchor, constant: 20),
            appleButton.leadingAnchor.constraint(equalTo: s.centerXAnchor, constant: 10),
            appleButton.trailingAnchor.constraint(equalTo: s.trailingAnchor, constant: -40),
            appleButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
