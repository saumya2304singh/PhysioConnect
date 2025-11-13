//
//  PhysiotherapistDetailModel.swift
//  PhysioConnect
//
//  Created by user@8 on 13/11/25.
//

import Foundation

struct Review {
    let reviewerName: String
    let rating: Double
    let comment: String
    let imageName: String
}

struct PhysiotherapistDetailModel {
    let name: String
    let specialization: String
    let experience: String
    let rating: Double
    let reviewsCount: Int
    let patientsCount: String
    let distance: String
    let consultationFee: String
    let description: String
    let imageName: String
    let reviews: [Review]
}
