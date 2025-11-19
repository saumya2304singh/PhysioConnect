//
//  LandingHomeModels.swift
//  PhysioConnect
//
//  Created by user@8 on 12/11/25.
//

import Foundation

struct Video {
    let imageName: String
}

struct Article {
    let imageName: String
    let title: String
}

struct LandingHomeModel {
    let videos: [Video]
    let articles: [Article]
}
