//
//  PhysioLoginView.swift
//  PhysioConnect
//
//  Created by admin4 on 12/11/25.
//

import UIKit

class PhysioLoginView: UIView {
    
    // MARK: - UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hi, Welcome Back!"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hope you're doing fine."
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    let emailField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Your Email"
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        return tf
    }()
    
    let passwordField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.borderStyle = .roundedRect
        tf.isSecureTextEntry = true
        tf.font = UIFont.systemFont(ofSize: 14)
        return tf
    }()
    
    let loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Log In", for: .normal)
        btn.backgroundColor = UIColor.systemBlue
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 20
        return btn
    }()
    
    // MARK: - Divider for OR
    private let leftLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#D4E3FE")
        return view
    }()
    
    private let rightLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#D4E3FE")
        return view
    }()
    
    private let orLabel: UILabel = {
        let label = UILabel()
        label.text = "or"
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    private lazy var orStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [leftLine, orLabel, rightLine])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 8
        return stack
    }()
    
    // MARK: - Social Buttons
    let googleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(" Continue with Google", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        if let googleImg = UIImage(named: "google") {
            button.setImage(googleImg, for: .normal)
        } else {
            button.setImage(UIImage(systemName: "globe"), for: .normal)
            button.tintColor = .red
        }
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 10)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(hex: "#D4E3FE")?.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let appleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(" Continue with Apple", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(systemName: "applelogo"), for: .normal)
        button.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 10)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(hex: "#D4E3FE")?.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let forgotPasswordButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Forgot password?", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        return btn
    }()
    
    // MARK: - Sign Up Section
    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Don’t have an account yet?"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let signUpButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Sign up", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return btn
    }()
    
    private lazy var signupStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [signUpLabel, signUpButton])
        stack.axis = .horizontal
        stack.spacing = 4
        stack.alignment = .center
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hex: "#E3F0FF")
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    private func setupLayout() {
        
        let mainStack = UIStackView(arrangedSubviews: [
            titleLabel, subtitleLabel,
            emailField, passwordField,
            loginButton,
            orStack,
            appleButton, googleButton,
            forgotPasswordButton,
            signupStack
        ])
        
        mainStack.axis = .vertical
        mainStack.spacing = 14
        mainStack.alignment = .fill
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(mainStack)
        
        // Heights
        [emailField, passwordField, loginButton, appleButton, googleButton].forEach {
            $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
        }
        
        // Divider line sizes
        leftLine.translatesAutoresizingMaskIntoConstraints = false
        rightLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftLine.heightAnchor.constraint(equalToConstant: 1),
            rightLine.heightAnchor.constraint(equalToConstant: 1),
            leftLine.widthAnchor.constraint(equalTo: orStack.widthAnchor, multiplier: 0.4),
            rightLine.widthAnchor.constraint(equalTo: orStack.widthAnchor, multiplier: 0.4)
        ])
        
        // Main layout
        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            mainStack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        // Center "Don't have an account? Sign up"
        NSLayoutConstraint.activate([
            signupStack.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
