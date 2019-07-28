//
//  InfoViewController.swift
//  Postype Sample
//
//  Created by QuetzalAndOrca on 28/07/2019.
//  Copyright © 2019 Kim_Sung-jin. All rights reserved.
//

import UIKit
import WebKit
import NVActivityIndicatorView

class InfoViewController: UIViewController, NVActivityIndicatorViewable {
    
    // MARK: - Property & IBOutlet
    var receiveString: String?
    var navigationTitle: String?
    var webViewKey: String?
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var infoNavigation: UINavigationItem!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        setKeyString()
        
        guard let urlKey = webViewKey else {return}
        setWebview(urlKey)
        guard let title = navigationTitle else {return}
        self.infoNavigation.title = title
    }
    
    // MARK: - Custom Methods
    func setKeyString() {
        switch receiveString {
        case "key1":
            navigationTitle = "도움센터"
            webViewKey = "https://help.postype.com/hc/ko?_ga=2.241109185.392884751.1564247133-1467673405.1563501593"
        case "key2":
            navigationTitle = "포스타입 블로그"
            webViewKey = "https://blog.postype.com/?_ga=2.132459724.392884751.1564247133-1467673405.1563501593"
        case "key3":
            navigationTitle = "작가 가이드"
            webViewKey = "https://www.postype.com/creatorsGuide"
        case "key4":
            navigationTitle = "권리침해 신고 센터"
            webViewKey = "https://right.postype.com/hc/ko"
        case "key5":
            navigationTitle = "개인정보 처리 방침"
            webViewKey = "https://www.postype.com/privacy"
        case "key6":
            navigationTitle = "이용약관"
            webViewKey = "https://www.postype.com/tos"
        case "key7":
            navigationTitle = "광고/제휴"
            webViewKey = "https://www.postype.com/ads"
        default:
            return
        }
    }
    
    func setWebview(_ key: String) {
        
        let homeURL: URL?
        homeURL = URL(string: key)
        guard let pageURL: URL = homeURL else { return }
        let urlRequest = URLRequest(url: pageURL)
        self.webView.load(urlRequest)
        
        startAnimating(CGSize(width: 30, height: 30), message: nil, messageFont: nil, type: NVActivityIndicatorType(rawValue: 17), color: UIColor(red:0.40, green:0.42, blue:0.98, alpha:1.0), backgroundColor: .clear)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.stopAnimating()
        }
    }
    
}
