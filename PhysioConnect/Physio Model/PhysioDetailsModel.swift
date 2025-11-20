//
//  PhysioDetailsModel.swift
//  PhysioConnect
//

import UIKit

struct PhysioDetailsModel {
    var specialization: String = ""
    var experience: String = ""
    var institution: String = ""
    var city: String = ""
    var gender: String = ""
    var qualification: String = ""
    var about: String = ""

    var qualificationProof: UIImage?
    var identityProof: UIImage?

    var isValid: Bool {
        return !specialization.isEmpty &&
               !experience.isEmpty &&
               !institution.isEmpty &&
               !city.isEmpty &&
               !gender.isEmpty &&
               !qualification.isEmpty &&
               !about.isEmpty &&
               qualificationProof != nil &&
               identityProof != nil
    }
}
