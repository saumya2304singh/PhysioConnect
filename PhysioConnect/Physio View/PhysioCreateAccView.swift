// PhysioCreateAccView.swift
import UIKit

class PhysioCreateAccView: UIView {
    let titleLabel: UILabel = { let l=UILabel(); l.text="Create Account"; l.font = .boldSystemFont(ofSize:24); l.textAlignment = .center; l.translatesAutoresizingMaskIntoConstraints=false; return l }()
    let subtitleLabel: UILabel = { let l=UILabel(); l.text="Where all your problems find solution"; l.font = .systemFont(ofSize:14); l.textColor = .darkGray; l.textAlignment = .center; l.translatesAutoresizingMaskIntoConstraints=false; return l }()
    private func createTextField(placeholder:String, icon:String) -> UITextField {
        let tf = UITextField(); tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.font: UIFont.systemFont(ofSize:13), .foregroundColor: UIColor.gray.withAlphaComponent(0.7)]); tf.layer.cornerRadius = 10; tf.layer.borderWidth = 1; tf.layer.borderColor = UIColor(hex: "#D4E3FE")?.cgColor; tf.backgroundColor = .white; tf.heightAnchor.constraint(equalToConstant:50).isActive = true; tf.translatesAutoresizingMaskIntoConstraints=false
        let vc = UIView(frame: CGRect(x:0,y:0,width:50,height:50)); let img = UIImageView(image: UIImage(systemName: icon)); img.tintColor = .gray; img.frame = CGRect(x:12,y:12,width:24,height:24); vc.addSubview(img); tf.leftView = vc; tf.leftViewMode = .always
        return tf
    }
    lazy var nameField = createTextField(placeholder: "Your Name", icon: "person")
    lazy var emailField = createTextField(placeholder: "Your Email", icon: "envelope")
    lazy var passwordField: UITextField = { let tf = createTextField(placeholder: "Password", icon: "lock"); tf.isSecureTextEntry = true; return tf }()
    let createButton: UIButton = { let b = UIButton(type:.system); b.setTitle("Create Account", for:.normal); b.backgroundColor = .systemBlue; b.setTitleColor(.white, for:.normal); b.layer.cornerRadius = 20; b.titleLabel?.font = .boldSystemFont(ofSize:16); b.heightAnchor.constraint(equalToConstant:44).isActive = true; b.translatesAutoresizingMaskIntoConstraints = false; return b }()
    let bottomLabel: UILabel = { let l=UILabel(); l.text="Do you have an account?"; l.font = .systemFont(ofSize:14); l.textColor = .gray; l.translatesAutoresizingMaskIntoConstraints=false; return l }()
    let signInButton: UIButton = { let b=UIButton(type:.system); b.setTitle("Log In", for:.normal); b.setTitleColor(.systemBlue, for:.normal); b.titleLabel?.font = .systemFont(ofSize:14, weight:.medium); b.translatesAutoresizingMaskIntoConstraints=false; return b }()
    override init(frame:CGRect){ super.init(frame:frame); backgroundColor = UIColor(hex: "#E3F0FF") ?? .systemBackground; setupLayout() }
    required init?(coder: NSCoder){ fatalError("init(coder:) not implemented") }
    private func setupLayout(){
        addSubview(titleLabel); addSubview(subtitleLabel)
        let stack = UIStackView(arrangedSubviews: [nameField, emailField, passwordField]); stack.axis = .vertical; stack.spacing = 12; stack.translatesAutoresizingMaskIntoConstraints=false; addSubview(stack)
        addSubview(createButton)
        let bottomStack = UIStackView(arrangedSubviews: [bottomLabel, signInButton]); bottomStack.axis = .horizontal; bottomStack.spacing = 6; bottomStack.translatesAutoresizingMaskIntoConstraints=false; addSubview(bottomStack)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 60),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 18),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            createButton.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 18),
            createButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            createButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            bottomStack.topAnchor.constraint(equalTo: createButton.bottomAnchor, constant: 18),
            bottomStack.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
