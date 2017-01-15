//
//  Photo.swift
//  Mars Rover
//
//  Created by Muhammad Moaz on 1/15/17.
//  Copyright © 2017 Muhammad Moaz. All rights reserved.
//

import Foundation

struct Photo {
    public let imageURL: String
    
    private init(imageURL: String) {
        self.imageURL = imageURL
    }
}

extension Photo {
    init(dictionary: JSONDictionary) throws {
        guard let imageSRC = dictionary["img_src"] as? String else {
            throw SerializationError.missing("img_src")
        }
        
        self.imageURL = imageSRC.replacingOccurrences(of: "http", with: "https")
    }
}
