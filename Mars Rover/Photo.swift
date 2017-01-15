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

extension Photo {
    static var urlComponents: URLComponents = {
        var url = URLComponents(string: Constants.BASE_URL)!
        url.queryItems = [
            URLQueryItem(name: "sol", value: "1000"),
            URLQueryItem(name: "api_key", value: Constants.API_KEY)
        ]
        return url
    }()
    
    static func loadPhotosAsync(completion: @escaping ([Photo]) -> Void) {
        URLSession.shared.dataTask(with: urlComponents.url!) { (data, response, error) in
            var photos = [Photo]()
            
            if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary {
                for dictionary in (json?["photos"] as? [JSONDictionary])! {
                    if let photo = try? Photo(dictionary: dictionary) {
                        photos.append(photo)
                    }
                }
            }
            completion(photos)
        }.resume()
    }
}
