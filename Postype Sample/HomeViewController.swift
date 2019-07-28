//
//  HomeViewController.swift
//  Postype Sample
//
//  Created by QuetzalAndOrca on 28/07/2019.
//  Copyright © 2019 Kim_Sung-jin. All rights reserved.
//

import UIKit
import WebKit

class HomeViewController: UIViewController {
   
    // MARK: - Property & IBOutlet
    var isActivating: Bool = true
    var lastOffsetY: CGFloat = 0
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var webView: WKWebView!
    
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        let homeURL: URL?
        homeURL = URL(string: "https://www.postype.com")
        guard let pageURL: URL = homeURL else { return }
        let urlRequest = URLRequest(url: pageURL)
        self.webView.load(urlRequest)
        self.tabBarController?.delegate = self
        self.webView.scrollView.delegate = self
        self.webView.navigationDelegate = self
        self.webView.allowsBackForwardNavigationGestures = true
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        isActivating = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewDidAppear(_ animated: Bool) {
        isActivating = true
    }
}

// MARK: - Tab Bar Delegate
extension HomeViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if tabBarController.selectedViewController == self && isActivating {
            let homeURL: URL?
            homeURL = URL(string: "https://www.postype.com")
            guard let pageURL: URL = homeURL else { return }
            let urlRequest = URLRequest(url: pageURL)
            self.webView.load(urlRequest)
        }
    }
}

// MARK: - Scroll View Delegate
extension HomeViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lastOffsetY = scrollView.contentOffset.y
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        let hide = scrollView.contentOffset.y > self.lastOffsetY
        guard let tabBar = self.tabBarController?.tabBar else { return; }
        UIView.animate(withDuration: 0.9) {
            tabBar.isHidden = hide
        }
    }
}

// MARK: - WKNavigation Delegate 
extension HomeViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.indicator.isHidden = true
        self.indicator.stopAnimating()    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.indicator.isHidden = false
        self.indicator.startAnimating()
    }
}
