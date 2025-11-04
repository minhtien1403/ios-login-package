//
//  File.swift
//  LoginFeature
//
//  Created by partnertientm2 on 3/11/25.
//

import UIKit
import Core
import Combine

final class LoginViewController: BaseViewController<LoginViewModelType> {
    
    private let loginButton = UIButton(type: .system)
    private let usernameField = UITextField()
    private let passwordField = UITextField()
    
    override func setupView() {
        title = "Login"
        view.backgroundColor = .systemBackground
        
        usernameField.placeholder = "Username"
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        loginButton.setTitle("Login", for: .normal)
        loginButton.isEnabled = false
        
        let stack = UIStackView(arrangedSubviews: [usernameField, passwordField, loginButton])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }
    
    override func bindViewModel() {
        usernameField.textPublisher
            .sink(receiveValue: { [unowned self] value in
                viewModel.input.updateUsername(value ?? "")
            })
            .store(in: &cancellables)
        
        passwordField.textPublisher
            .sink(receiveValue: { [unowned self] value in
                viewModel.input.updatePassword(value ?? "")
            })
            .store(in: &cancellables)
        
        viewModel.output.isLoginEnablePublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: loginButton)
            .store(in: &cancellables)
    }
}
