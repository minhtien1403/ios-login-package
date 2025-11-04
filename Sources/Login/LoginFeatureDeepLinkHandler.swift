//
//  File.swift
//  LoginFeature
//
//  Created by partnertientm2 on 3/11/25.
//

import UIKit
import Shared

public final class LoginFeatureDeepLinkHandler: DeepLinkHandler {
    
    public init() {}
    
    public func canHandle(_ link: DeepLink) -> Bool {
        link.path.hasPrefix("/login")
    }
    
    public func viewController(for link: DeepLink) -> UIViewController? {
        switch link.path {
        case "/login":
            Log.context()
            return LoginViewController(viewModel: LoginViewModel())
        default:
            return nil
        }
    }
}
