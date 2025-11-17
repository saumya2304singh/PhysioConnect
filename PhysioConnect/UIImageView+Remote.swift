//
//  UIImageView+Remote.swift
//  PhysioConnect
//
//  Created by user@8 on 16/11/25.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {

    func loadImage(from urlString: String) {
        self.image = UIImage(named: "doctor_placeholder")

        // Check cache first
        if let cached = imageCache.object(forKey: NSString(string: urlString)) {
            self.image = cached
            return
        }

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let img = UIImage(data: data) else { return }

            // Cache it
            imageCache.setObject(img, forKey: NSString(string: urlString))

            DispatchQueue.main.async {
                self.image = img
            }
        }.resume()
    }
}
