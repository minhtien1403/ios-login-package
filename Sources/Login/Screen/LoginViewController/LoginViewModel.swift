//
//  File.swift
//  LoginFeature
//
//  Created by partnertientm2 on 3/11/25.
//

import Foundation
import Combine
import Core

public protocol LoginViewModelInputType {
    
    func updateUsername(_ username: String)
    func updatePassword(_ password: String)
    func login()
}

public protocol LoginViewModelOutputType {
    
    var isLoginEnablePublisher: AnyPublisher<Bool, Never> { get }
    var loginResultPublisher: AnyPublisher<Result<Void, Error>, Never> { get }
}

public protocol LoginViewModelType {
    
    var input: LoginViewModelInputType { get }
    var output: LoginViewModelOutputType { get }
}

final class LoginViewModel: BaseViewModel {
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoginEnabled: Bool = false
    private let loginResultSubject = PassthroughSubject<Result<Void, Error>, Never>()

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
    
    func login() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            print("Logging in with username: \(self.username) and password: \(self.password)")
            self.loginResultSubject.send(.success(()))
        }
    }
}

extension LoginViewModel: LoginViewModelOutputType {
    
    var isLoginEnablePublisher: AnyPublisher<Bool, Never> {
        $isLoginEnabled.eraseToAnyPublisher()
    }
    
    var loginResultPublisher: AnyPublisher<Result<Void, any Error>, Never> {
        loginResultSubject.eraseToAnyPublisher()
    }
}
