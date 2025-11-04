//
//  File.swift
//  LoginFeature
//
//  Created by partnertientm2 on 3/11/25.
//

import UIKit
import Combine
import Core

public protocol LoginViewModelInputType {
    
    func updateUsername(_ username: String)
    func updatePassword(_ password: String)
}

public protocol LoginViewModelOutputType {
    
    var isLoginEnablePublisher: AnyPublisher<Bool, Never> { get }
}

public protocol LoginViewModelType {
    
    var input: LoginViewModelInputType { get }
    var output: LoginViewModelOutputType { get }
}

final class LoginViewModel: BaseViewModel {
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoginEnabled: Bool = false

    override init() {
        super.init()
        setupBindings()
    }

    private func setupBindings() {
        Publishers.CombineLatest($username, $password)
            .map { !$0.isEmpty && !$1.isEmpty }
            .assign(to: \.isLoginEnabled, on: self)
            .store(in: &cancellables)
    }
}

extension LoginViewModel: LoginViewModelType {
    var input: any LoginViewModelInputType { self }
    var output: any LoginViewModelOutputType { self }
}

extension LoginViewModel: LoginViewModelInputType {
    
    func updateUsername(_ username: String) {
        self.username = username
    }
    
    func updatePassword(_ password: String) {
        self.password = password
    }
}

extension LoginViewModel: LoginViewModelOutputType {
    
    var isLoginEnablePublisher: AnyPublisher<Bool, Never> {
        $isLoginEnabled.eraseToAnyPublisher()
    }
}
