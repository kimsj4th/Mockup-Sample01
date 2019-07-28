//
//  RecommendTableViewController.swift
//  Postype Sample
//
//  Created by QuetzalAndOrca on 28/07/2019.
//  Copyright © 2019 Kim_Sung-jin. All rights reserved.
//

import UIKit

class RecommendTableViewController: UITableViewController {
    // MARK: - Property & IBOutlet
    let cellIdentifier = "cell"
    var imageData: [String] = []
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callMovieAPI()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.tabBarController?.tabBar.isTranslucent = true
        
        tableView.backgroundColor = .white
        
        tableView.delegate = self
        self.tableView.register(CustomHeader.self, forHeaderFooterViewReuseIdentifier: CustomHeader.reuseIdentifer)
    }
    
    // MARK: - Custom Methods
    func callMovieAPI() {
        let url = "http://115.68.183.178:2029/hoppin/movies?version=1&page=1&count=20&genreId=&order=releasedateasc"
        let apiURL: URL! = URL(string: url)
        let apiData = try! Data(contentsOf: apiURL)
        do {
            let apiDictionary = try JSONSerialization.jsonObject(with: apiData, options: []) as! NSDictionary
            let hoppin = apiDictionary["hoppin"] as! NSDictionary
            let movies = hoppin["movies"] as! NSDictionary
            let movie = movies["movie"] as! NSArray
            
            for row in movie {
                
                let r = row as! NSDictionary
                guard let movieValueObject = r["thumbnailImage"] as? String else { return }
                self.imageData.append(movieValueObject)
            }
        }
        catch {
            print("Parse Erro!!")
        }
    }
    
    // MARK: - Table view data source & delegate
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return imageData.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell: RecommendTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! RecommendTableViewCell
        
        let text = "섹션\(indexPath.section + 1)의 \(indexPath.row + 1)번째 Post"
        cell.myTextLabel.text = text
        cell.movieImageView.kf.setImage(with: URL(string: imageData[indexPath.row]))
        return cell
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        print("headerview create")
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomHeader.reuseIdentifer) as? CustomHeader else {
            return nil
        }
        header.customLabel.text = "Section \(section + 1)"
        return header
    }
}


// MARK: - Table View Header View
class CustomHeader: UITableViewHeaderFooterView {
    static let reuseIdentifer = "CustomHeaderReuseIdentifier"
    let customLabel = UILabel.init()
    
    override public init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        customLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        
        customLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(customLabel)
        
        let margins = contentView.layoutMarginsGuide
        customLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        customLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        customLabel.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        customLabel.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

