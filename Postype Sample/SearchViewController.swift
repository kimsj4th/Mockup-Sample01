//
//  SearchViewController.swift
//  Postype Sample
//
//  Created by QuetzalAndOrca on 28/07/2019.
//  Copyright © 2019 Kim_Sung-jin. All rights reserved.
//

import UIKit
import WebKit
import NVActivityIndicatorView


class SearchViewController: UIViewController {
    // MARK: - Property & IBOutlet

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let cellIdentifier = "searchCell"
    
    var searchKeyword: [String] = []
    var searchKey: String?
    var lastOffsetY: CGFloat = 0
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var savedSearchTable: UITableView!
    @IBOutlet weak var cancelButtonOutlet: UIButton!
    
    
    // MARK: - IBAction
    @IBAction func recordClearButton(_ sender: UIButton) {
        appDelegate.searchData = []
        savedSearchTable.reloadData()
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
            self.tabBarController?.selectedIndex = 0
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.viewDidLoad()
        savedSearchTable.dropShadow()
        self.webView.scrollView.delegate = self
        
        searchBar.delegate = self
        
        emptyView.isHidden = false
        searchBar.enablesReturnKeyAutomatically = true
        
        searchBar.placeholder = "포스트, 태그, 블로그 검색"
        searchBar.becomeFirstResponder()
        searchBar.isTranslucent = false
        self.savedSearchTable.delegate = self
        self.savedSearchTable.dataSource = self
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
        self.tabBarController?.tabBar.isTranslucent = true
        
        setCancelButtonLayer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        emptyView.isHidden = false
        searchBar.placeholder = "포스트, 태그, 블로그 검색"
        webView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.searchBar.isHidden = false
        cancelButtonOutlet.isHidden = false
        searchBar.becomeFirstResponder()
        savedSearchTable.reloadData()
    }
    
    // MARK: - Custom Method
    func setCancelButtonLayer() {
        cancelButtonOutlet.layer.addBorder(edge: UIRectEdge.bottom, color: .darkGray, thickness: 0.26)
    }
}



// MARK: - Table View Delegate & Data Source
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appDelegate.searchData.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
        print("DIDSelecteRowAt")
        
        guard let key: String = tableView.cellForRow(at: indexPath)?.textLabel?.text else {return}
        let urlAddress = "https://www.postype.com/search?keyword=\(key)"
        guard let encodedKey = urlAddress.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        let searchURL: URL?
        searchURL = URL(string: encodedKey)
        guard let pageURL: URL = searchURL else { return }
        let urlRequest = URLRequest(url: pageURL)
        self.webView.load(urlRequest)
        searchBar.isHidden = true
        emptyView.isHidden = true
        cancelButtonOutlet.isHidden = true
        
        startAnimating(CGSize(width: 30, height: 30), message: "Loading...", messageFont: UIFont.systemFont(ofSize: 15), type: NVActivityIndicatorType(rawValue: 32), color: UIColor(red:0.40, green:0.42, blue:0.98, alpha:1.0), backgroundColor: .clear ,textColor: UIColor(red:0.40, green:0.42, blue:0.98, alpha:1.0))
        
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.stopAnimating()
            self.webView.isHidden = false
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            appDelegate.searchData.remove(at: indexPath.row)
            savedSearchTable.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        let text = appDelegate.searchData[indexPath.row].keyword
        cell.textLabel?.text = text
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}

// MARK: - Scroll View Delegate
extension SearchViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lastOffsetY = scrollView.contentOffset.y
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        let hide = scrollView.contentOffset.y > self.lastOffsetY
        guard let tabBar = self.tabBarController?.tabBar else { return; }
        
        UIView.animate(withDuration: 0.9) {
            UIView.setAnimationCurve(.easeInOut)
            if self.searchBar.isHidden == true {
                tabBar.isHidden = hide
            }
        }
    }
}

// MARK: - Gesture Recognizer Delegate
extension SearchViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

// MARK: - Search Bar Delgate, NVActivityIndicatorView
extension SearchViewController: UISearchBarDelegate, NVActivityIndicatorViewable {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchKey = searchText
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        guard let key: String = searchKey else {return}
        let urlAddress = "https://www.postype.com/search?keyword=\(key)"
        guard let encodedKey = urlAddress.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let searchURL: URL?
        searchURL = URL(string: encodedKey)
        guard let pageURL: URL = searchURL else { return }
        let urlRequest = URLRequest(url: pageURL)
        self.webView.load(urlRequest)
        
        
        let searchData = SearchData()
        searchData.keyword = key
        searchData.keyAddressURL = searchURL
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        appDelegate.searchData.insert(searchData, at: 0)
        searchBar.text = nil
        searchBar.isHidden = true
        emptyView.isHidden = true
        cancelButtonOutlet.isHidden = true
        
        startAnimating(CGSize(width: 30, height: 30),
                       message: "Loading...",
                       messageFont: UIFont.systemFont(ofSize: 15),
                       type: NVActivityIndicatorType(rawValue: 32),
                       color: UIColor(red:0.40, green:0.42, blue:0.98, alpha:1.0),
                       backgroundColor: .clear,
                       textColor: UIColor(red:0.40, green:0.42, blue:0.98, alpha:1.0))
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.4) {
            self.stopAnimating()
            self.webView.isHidden = false
        }
    }
    
}

// MARK: - Extension
extension UIView {
    
    func dropShadow() {
        self.layer.cornerRadius = 5.0
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.borderWidth = 0.5
        self.layer.shadowOpacity = 0.5
    }
    
}
