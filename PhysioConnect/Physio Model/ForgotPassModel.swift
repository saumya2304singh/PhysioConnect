//
//  ForgotPassModel.swift
//  PhysioConnect
//
//  Created by admin4 on 13/11/25.
//

//
//  ForgotPassModel.swift
//  YourApp
//

import Foundation

struct ForgotPassModel {
    
    var email: String = ""
    
    // MARK: - Validate Email
    func isValidEmail() -> Bool {
        let emailRegEx =
        "(?:[a-zA-Z0-9._%+-]+)@(?:[a-zA-Z0-9-]+)\\.(?:[a-zA-Z]{2,})"
        
        return NSPredicate(format: "SELF MATCHES %@", emailRegEx)
            .evaluate(with: email)
    }
    
    // MARK: - API request body
    func requestBody() -> [String: Any] {
        return ["email": email]
    }
}

