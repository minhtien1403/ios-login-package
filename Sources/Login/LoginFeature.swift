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

extension LoginFeature: DeepLinkHandler {
    
    public func canHandle(_ link: DeepLink) -> Bool {
        link.path.hasPrefix("/login")
    }
    
    public func viewController(for link: DeepLink) -> UIViewController? {
        switch link.path {
        case "/login":
            Log.context()
            let vc = LoginViewController(viewModel: LoginViewModel())
            vc.output = output
            return vc
        default:
            return nil
        }
    }
}
