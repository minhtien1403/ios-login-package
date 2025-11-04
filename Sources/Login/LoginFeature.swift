//
//  File.swift
//  Login
//
//  Created by partnertientm2 on 3/11/25.
//

import UIKit
import Core
import Shared

public final class LoginFeature: LoginFeatureInterface {
    
    public init() {}
    
    public func makeLoginViewController() -> UIViewController {
        return LoginViewController(viewModel: LoginViewModel())
    }

    public func makeRegisterViewController() -> UIViewController {
        return UIViewController()
    }
}
