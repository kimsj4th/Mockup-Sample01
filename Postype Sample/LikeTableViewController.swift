//
//  LikeTableViewController.swift
//  Postype Sample
//
//  Created by QuetzalAndOrca on 28/07/2019.
//  Copyright © 2019 Kim_Sung-jin. All rights reserved.
//

import UIKit
import Kingfisher

class LikeTableViewController: UITableViewController {
    // MARK: - Property
    let cellIdentifier = "likeCell"
    
    var imageData: [String] = []
    var personMenImage: UIImage?
    var personWomenImage: UIImage?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        extractImageURL()
    }
    
    // MARK: - Custom Methods
    func extractImageURL() {
        for url in 1...10 {
            let baseURL1 = "https://randomuser.me/api/portraits/thumb/men/\(url).jpg"
            let baseURL2 = "https://randomuser.me/api/portraits/thumb/women/\(url).jpg"
            imageData.append(baseURL1)
            imageData.append(baseURL2)
        }
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageData.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LikeTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! LikeTableViewCell
        
        cell.personImage.kf.setImage(with: URL(string: imageData[indexPath.row]))
        return cell
    }
}
