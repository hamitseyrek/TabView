//
//  V2ViewController.swift
//  TabView
//
//  Created by Hamit Seyrek on 17.09.2024.
//

import UIKit

class V2ViewController: UIViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<TabBarSection, String>
        
        enum TabBarSection {
            case main
        }
        
    @IBOutlet weak var basicView: UIView!
    @IBOutlet weak var topTabBar: TabCollectionView!
//    private let topTabBar = TabCollectionView()
        private var dataSource: DataSource! = nil
        
        var currentIndexPath = IndexPath() {
            didSet {
                if currentIndexPath.row == 0 {
                    basicView.backgroundColor = .red
                } else if currentIndexPath.row == 1 {
                    basicView.backgroundColor = .blue
                } else if currentIndexPath.row == 2 {
                    basicView.backgroundColor = .yellow
                }
            }
        }
        
//        let basicView: UIView = {
//            let view = UIView()
//            view.translatesAutoresizingMaskIntoConstraints = false
//            
//            return view
//        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            topTabBar.collectionView.delegate = self
//            view.addSubview(topTabBar)
//            view.addSubview(basicView)
//            
//            NSLayoutConstraint.activate([
//                self.basicView.topAnchor.constraint(equalTo: topTabBar.bottomAnchor, constant: 5),
//                self.basicView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//                self.basicView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//                self.basicView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//            ])
//            
//            NSLayoutConstraint.activate([
//                self.topTabBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//                self.topTabBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//                self.topTabBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//                self.topTabBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05)
//            ])
            
            configureDataSource()
            
            var initalSnapshot = NSDiffableDataSourceSnapshot<TabBarSection, String>()
            initalSnapshot.appendSections([.main])
            initalSnapshot.appendItems(["Red", "Blue", "Yellow", "Green", "Pink"], toSection: .main)
            self.dataSource.apply(initalSnapshot)
            
            let startIndexPath = IndexPath(row: 0, section: 0)
            self.topTabBar.collectionView.selectItem(at: startIndexPath, animated: false, scrollPosition: .init())
            self.currentIndexPath = startIndexPath
        }
        
        func configureDataSource() {
            let cellRegistration = UICollectionView.CellRegistration<TabLabelCell, String> { cell, indexPath, itemIdentifier in
                cell.setTitle(itemIdentifier)
            }
            
            self.dataSource = DataSource(collectionView: topTabBar.collectionView) { collectionView, indexPath, itemIdentifier in
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            }
        }
    }

    extension V2ViewController: UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            self.currentIndexPath = indexPath
        }
    }
