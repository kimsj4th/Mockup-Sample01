//
//  MenuViewController.swift
//  Postype Sample
//
//  Created by QuetzalAndOrca on 28/07/2019.
//  Copyright © 2019 Kim_Sung-jin. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var helpLabel: UILabel!
    @IBOutlet weak var blogLabel: UILabel!
    @IBOutlet weak var guideLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var privacyLabel: UILabel!
    @IBOutlet weak var termsLabel: UILabel!
    @IBOutlet weak var adLabel: UILabel!
    
    // MARK: - IBAction
    @IBAction func backToHomeButton(_ sender: UIBarButtonItem) {
        self.tabBarController?.selectedIndex = 0
    }
    @IBAction func logOutButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "로그아웃", message: "로그아웃하시겠어요?", preferredStyle: .alert)
        alert.setMessage(font: UIFont.systemFont(ofSize: 16), color: .black )
        alert.setTint(color: UIColor(red:0.40, green:0.42, blue:0.98, alpha:1.0))
        
        let alertAction = UIAlertAction(title: "네", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        let alertCancle = UIAlertAction(title: "아니오", style: .default, handler: nil)
        alert.addAction(alertCancle)
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabel()
        makeLabelAction()
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
        navigationController?.isNavigationBarHidden = false
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.navigationController?.navigationBar.tintColor = UIColor(red:0.40, green:0.42, blue:0.98, alpha:1.0)
        let edgePanGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(self.popViewControllerOnScreenEdgeSwipe(recognizer:)))
        edgePanGesture.edges = .left
        view.addGestureRecognizer(edgePanGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - Custom Methods
    @objc func popViewControllerOnScreenEdgeSwipe(recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            print("Edge screen gesture recognized!!")
            self.tabBarController?.selectedIndex = 0
        }
    }
    
    func setLabel() {
        for label in [helpLabel,blogLabel,guideLabel,rightLabel,termsLabel,adLabel,privacyLabel]  {
            label?.layer.addBorder(edge: UIRectEdge.left, color:  UIColor(red:0.40, green:0.42, blue:0.98, alpha:1.0), thickness: 1.5)
            label?.isUserInteractionEnabled = true
        }
    }
    
    func makeLabelAction() {
        
        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(goToHelp))
        helpLabel.addGestureRecognizer(gesture1)
        
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(goToBlog))
        blogLabel.addGestureRecognizer(gesture2)
        
        let gesture3 = UITapGestureRecognizer(target: self, action: #selector(goToGuide))
        guideLabel.addGestureRecognizer(gesture3)
        
        let gesture4 = UITapGestureRecognizer(target: self, action: #selector(goToRightCenter))
        rightLabel.addGestureRecognizer(gesture4)
        
        let gesture5 = UITapGestureRecognizer(target: self, action: #selector(goToPrivacy))
        privacyLabel.addGestureRecognizer(gesture5)
        
        let gesture6 = UITapGestureRecognizer(target: self, action: #selector(goToTerms))
        termsLabel.addGestureRecognizer(gesture6)
        
        let gesture7 = UITapGestureRecognizer(target: self, action: #selector(goToAd))
        adLabel.addGestureRecognizer(gesture7)
    }
    
    @objc func goToHelp() {
        self.performSegue(withIdentifier: "moveInfo", sender: "key1")
    }
    @objc func goToBlog() {
        self.performSegue(withIdentifier: "moveInfo", sender: "key2")
    }
    @objc func goToGuide() {
        self.performSegue(withIdentifier: "moveInfo", sender: "key3")
    }
    @objc func goToRightCenter() {
        self.performSegue(withIdentifier: "moveInfo", sender: "key4")
    }
    @objc func goToPrivacy() {
        self.performSegue(withIdentifier: "moveInfo", sender: "key5")
    }
    @objc func goToTerms() {
        self.performSegue(withIdentifier: "moveInfo", sender: "key6")
    }
    @objc func goToAd() {
        self.performSegue(withIdentifier: "moveInfo", sender: "key7")
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveInfo" {
            guard let nextViewController: InfoViewController = segue.destination as? InfoViewController else { return }
            nextViewController.receiveString = sender as? String
        }
    }
}

// MARK: - Extension
extension UIColor {
    func as1ptImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 0.5, height: 0.5))
        setFill()
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 0.5, height: 0.5))
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
}

extension UIAlertController {
    func setMessage(font: UIFont?, color: UIColor?) {
        guard let message = self.message else { return }
        let attributeString = NSMutableAttributedString(string: message)
        if let messageFont = font {
            attributeString.addAttributes([NSAttributedString.Key.font : messageFont],
                                          range: NSMakeRange(0, message.count))
        }
        
        if let messageColorColor = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor : messageColorColor],
                                          range: NSMakeRange(0, message.count))
        }
        self.setValue(attributeString, forKey: "attributedMessage")
    }
    func setTitle(font: UIFont?, color: UIColor?) {
        guard let title = self.title else { return }
        let attributeString = NSMutableAttributedString(string: title)//1
        if let titleFont = font {
            attributeString.addAttributes([NSAttributedString.Key.font : titleFont],//2
                range: NSMakeRange(0, title.count))
        }
        
        if let titleColor = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor : titleColor],//3
                range: NSMakeRange(0, title.count))
        }
        self.setValue(attributeString, forKey: "attributedTitle")//4
    }
    func setTint(color: UIColor) {
        self.view.tintColor = color
    }
}

extension CALayer {
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: thickness)
            
        case UIRectEdge.bottom:
            border.frame = CGRect(x: 0, y: self.bounds.height - thickness,  width: self.bounds.width, height: thickness)
            
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0,  width: thickness, height: self.bounds.height)
            
        case UIRectEdge.right:
            border.frame = CGRect(x: self.bounds.width - thickness, y: 0,  width: thickness, height: self.bounds.height)
            
        default:
            break
        }
        border.backgroundColor = color.cgColor;
        self.addSublayer(border)
    }
}


