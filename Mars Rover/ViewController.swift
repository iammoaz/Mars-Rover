//
//  ViewController.swift
//  Mars Rover
//
//  Created by Muhammad Moaz on 1/14/17.
//  Copyright © 2017 Muhammad Moaz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var photos: [Photo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        loadPhotos()
    }
    
    func loadPhotos() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) { 
            Photo.loadPhotosAsync { (photos) in
                self.photos = photos
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCell.reuseIdentifier, for: indexPath)
        guard let photos = self.photos else { return cell }
        
        let imageCell = cell as! PhotoCell
        imageCell.configure(with: photos[indexPath.row])
        return imageCell
    }
}

