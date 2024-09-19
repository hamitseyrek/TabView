//
//  V4ViewController.swift
//  TabView
//
//  Created by Hamit Seyrek on 18.09.2024.
//

import UIKit

class V4ViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = HomeViewController()
        
        addChild(homeVC)
        
        mainView.addSubview(homeVC.view)
        homeVC.view.frame = mainView.bounds
        homeVC.didMove(toParent: self)
    }
}
