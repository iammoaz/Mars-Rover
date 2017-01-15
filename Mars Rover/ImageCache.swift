//
//  ImageCache.swift
//  Mars Rover
//
//  Created by Muhammad Moaz on 1/15/17.
//  Copyright © 2017 Muhammad Moaz. All rights reserved.
//

import UIKit

class ImageCache {
    static let instance = ImageCache()
    
    private var imageCache = [String: UIImage]()
    private var queue = DispatchQueue(label: "com.moaz.mars-rover.imagecache")
    
    func add(with imageName: String, image: UIImage) {
        let workItem = DispatchWorkItem(qos: .default, flags: .barrier) { 
            self.imageCache[imageName] = image
        }
        queue.async(execute: workItem)
    }
    
    func get(with imageName: String) -> UIImage? {
        var image: UIImage? = nil
        queue.sync {
            image = imageCache[imageName]
        }
        return image
    }
    
    func removeAll() {
        imageCache = [:]
    }
}
