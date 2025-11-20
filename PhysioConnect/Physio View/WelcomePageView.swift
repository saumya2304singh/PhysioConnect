// WelcomePageView.swift
import UIKit

class WelcomePageView: UIView {

    let yogaImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Welcome")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 24
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    let welcomeLabel: UILabel = {
        let l = UILabel(); l.text = "Welcome to"; l.font = .systemFont(ofSize: 20); l.textAlignment = .center; l.translatesAutoresizingMaskIntoConstraints = false; return l
    }()
    let titleLabel: UILabel = {
        let l = UILabel(); l.text = "PhysioConnect"; l.font = .boldSystemFont(ofSize: 26); l.textAlignment = .center; l.translatesAutoresizingMaskIntoConstraints = false; return l
    }()
    let subtitleLabel: UILabel = {
        let l = UILabel(); l.text = "Find the perfect physiotherapist and\nresources to support your health journey."; l.numberOfLines = 2; l.font = .systemFont(ofSize: 15); l.textAlignment = .center; l.textColor = .darkGray; l.translatesAutoresizingMaskIntoConstraints = false; return l
    }()

    let patientButton: UIButton = {
        let b = UIButton(type: .system); b.setTitle("Patient", for: .normal); b.backgroundColor = UIColor.systemBlue; b.setTitleColor(.white, for: .normal); b.layer.cornerRadius = 24; b.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium); b.translatesAutoresizingMaskIntoConstraints = false; return b
    }()
    let physioButton: UIButton = {
        let b = UIButton(type: .system); b.setTitle("Physiotherapist", for: .normal); b.backgroundColor = UIColor.systemBlue; b.setTitleColor(.white, for: .normal); b.layer.cornerRadius = 24; b.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium); b.translatesAutoresizingMaskIntoConstraints = false; return b
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hex: "#E3F0FF") ?? .systemBackground
        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private func addSubviews() {
        addSubview(yogaImageView); addSubview(welcomeLabel); addSubview(titleLabel); addSubview(subtitleLabel); addSubview(patientButton); addSubview(physioButton)
    }

    private func setupConstraints() {
        let safe = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            yogaImageView.topAnchor.constraint(equalTo: safe.topAnchor, constant: 80),
            yogaImageView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 20),
            yogaImageView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -20),
            yogaImageView.heightAnchor.constraint(equalToConstant: 220),

            welcomeLabel.topAnchor.constraint(equalTo: yogaImageView.bottomAnchor, constant: 20),
            welcomeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            titleLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 6),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 40),
            subtitleLabel.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -40),

            patientButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 28),
            patientButton.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 40),
            patientButton.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -40),
            patientButton.heightAnchor.constraint(equalToConstant: 44),

            physioButton.topAnchor.constraint(equalTo: patientButton.bottomAnchor, constant: 12),
            physioButton.leadingAnchor.constraint(equalTo: patientButton.leadingAnchor),
            physioButton.trailingAnchor.constraint(equalTo: patientButton.trailingAnchor),
            physioButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
