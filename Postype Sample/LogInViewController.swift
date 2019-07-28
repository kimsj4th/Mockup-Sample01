//
//  LogInViewController.swift
//  Postype Sample
//
//  Created by QuetzalAndOrca on 28/07/2019.
//  Copyright © 2019 Kim_Sung-jin. All rights reserved.
//

import UIKit
import WebKit
import NVActivityIndicatorView

class LogInViewController: UIViewController, NVActivityIndicatorViewable {
    
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeURL: URL?
        homeURL = URL(string: "https://www.postype.com/login")
        guard let pageURL: URL = homeURL else { return }
        let urlRequest = URLRequest(url: pageURL)
        self.webView.load(urlRequest)
        
        startAnimating(CGSize(width: 30, height: 30), message: nil, messageFont: nil, type: NVActivityIndicatorType(rawValue: 18), color: UIColor(red:0.40, green:0.42, blue:0.98, alpha:1.0), backgroundColor: .clear)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.stopAnimating()
        }
    }
}
