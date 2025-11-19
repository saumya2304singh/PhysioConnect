//
//  PhysiotherapistDetailModel.swift
//  PhysioConnect
//

import Foundation

struct Review {
    let reviewerName: String
    let rating: Double
    let comment: String

    /// Optional local asset name for now
    let imageName: String?    // e.g. "profile1"
}

struct PhysiotherapistDetailModel {
    let id: UUID
    let name: String
    let specialization: String
    let experience: String
    let rating: Double
    let reviewsCount: Int
    let patientsCount: String
    let distance: String
    let consultationFee: String
    let description: String
    let imageURL: String
    let reviews: [Review]
}
