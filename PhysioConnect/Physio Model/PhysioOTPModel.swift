//
//  PhysioOTPModel.swift
//  PhysioConnect
//
//  Created by admin4 on 13/11/25.
//

import Foundation

struct PhysioOTPModel {
    var code: String = ""
    
    func isValidCode() -> Bool {
        return code.count == 4
    }
}

