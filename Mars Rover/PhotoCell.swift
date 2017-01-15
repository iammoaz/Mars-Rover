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
    
    var imageDownloader: ImageDownloader?
    
    override func prepareForReuse() {
        self.imageDownloader?.cancel()
        self.imageDownloader = nil
    }
    
    public func configure(with photo: Photo) {
        if let image = ImageCache.instance.get(with: photo.imageURL) {
            self.photoImageView.image = image
        } else {
            configureImageDownloader(for: photo)
        }
    }
    
    func configureImageDownloader(for photo: Photo) {
        let downloader = ImageDownloader(photo: photo)
        downloader.completionBlock = {
            if downloader.isCancelled {
                return
            }
            
            DispatchQueue.main.async {
                self.photoImageView.image = ImageCache.instance.get(with: photo.imageURL)
            }
        }
        
        self.imageDownloader = downloader
    }
}
