//
//  V3ViewController.swift
//  TabView
//
//  Created by Hamit Seyrek on 18.09.2024.
//

import UIKit

class V3ViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    private var tabContentView: TabContentView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupTabContentView()
        }
        
        private func setupTabContentView() {
            tabContentView = TabContentView(frame: view.bounds)
            
            contentView.addSubview(tabContentView)
            tabContentView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                tabContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
                tabContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                tabContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                tabContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
            
            // Initialize tabs
            let tabs = [
                Tab(icon: UIImage(named: "music"), title: "Aktif Puanlarınız"),
                Tab(icon: UIImage(named: "movies"), title: "Geçmiş Puanlarınız")
            ]
            
            tabContentView.configureTabs(tabs: tabs)
        }
    }
