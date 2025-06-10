//
//  Extensions.swift
//  DogsList
//
//  Created by Juan Hernandez Galvan on 09/06/25.
//

import UIKit

// MARK: - UIImageView
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

// MARK: - String
extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
