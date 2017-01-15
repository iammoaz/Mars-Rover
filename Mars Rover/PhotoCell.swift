//
//  PhotoCell.swift
//  Mars Rover
//
//  Created by Muhammad Moaz on 1/15/17.
//  Copyright © 2017 Muhammad Moaz. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    static let reuseIdentifier = String(describing: PhotoCell.self)

    public func configure(with photo: Photo) {
        loadImage(from: photo.imageURL)
    }

    private func loadImage(from imageURL: String) {
        if let imageData = try? Data(contentsOf: URL(string: imageURL)!) {
            let image = UIImage(data: imageData)
            self.photoImageView.image = image
        }
    }
}
