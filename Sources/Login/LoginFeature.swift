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
    
    weak var output: LoginFeatureOutput?
    
    public init() {}
    
    public func makeLoginViewController() -> UIViewController {
        let vc = LoginViewController(viewModel: LoginViewModel())
        vc.output = output
        return vc
    }

    public func makeRegisterViewController() -> UIViewController {
        return UIViewController()
    }
}
