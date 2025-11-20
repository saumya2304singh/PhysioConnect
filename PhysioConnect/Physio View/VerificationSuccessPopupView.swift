// VerificationSuccessPopupView.swift
import UIKit

class VerificationSuccessPopupView: UIView {

    private let container: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 20
        v.layer.shadowOpacity = 0.12
        v.layer.shadowRadius = 10
        v.layer.shadowOffset = CGSize(width: 0, height: 6)
        return v
    }()

    private let titleLabel: UILabel = {
        let l = UILabel()
        l.text = "Verification successful."
        l.font = .boldSystemFont(ofSize: 18)
        l.textAlignment = .center
        return l
    }()

    private let subtitleLabel: UILabel = {
        let l = UILabel()
        l.text = "Logging in to your account."
        l.font = .systemFont(ofSize: 13)
        l.textColor = .gray
        l.textAlignment = .center
        return l
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black.withAlphaComponent(0.35)
        alpha = 0
        addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(titleLabel)
        container.addSubview(subtitleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: centerXAnchor),
            container.centerYAnchor.constraint(equalTo: centerYAnchor),
            container.widthAnchor.constraint(equalToConstant: 300),
            container.heightAnchor.constraint(equalToConstant: 170),

            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 26),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subtitleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            subtitleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12)
        ])
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    func show(in parent: UIView) {
        parent.addSubview(self)
        frame = parent.bounds
        container.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.animate(withDuration: 0.22) {
            self.alpha = 1
            self.container.transform = .identity
        }
    }

    func dismiss(_ completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.18, animations: { self.alpha = 0 }) { _ in
            self.removeFromSuperview()
            completion?()
        }
    }
}
