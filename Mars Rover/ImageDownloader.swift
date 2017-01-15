//
//  ImageDownloader.swift
//  Mars Rover
//
//  Created by Muhammad Moaz on 1/15/17.
//  Copyright © 2017 Muhammad Moaz. All rights reserved.
//

import UIKit

class ImageDownloader: Operation {
    let photo: Photo
    
    init(photo: Photo) {
        self.photo = photo
    }
    
    override func main() {
        if self.isCancelled {
            return
        }
        
        let imageData = try? Data(contentsOf: URL(string: photo.imageURL)!)
        
        if self.isCancelled {
            return
        }
        
        if let data = imageData, data.count > 0 {
            let image = UIImage(data: data)
            ImageCache.instance.add(with: photo.imageURL, image: image!)
        }
    }
}
