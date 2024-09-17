//
//  HomeViewController.swift
//  TabView
//
//  Created by Hamit Seyrek on 16.09.2024.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tabsView: TabsView!
    
    var currentIndex: Int = 0
    
    var pageController: UIPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabs()
        
        setupPageViewController()
    }
    
    func setupPageViewController() {
        // PageViewController
        self.pageController = UIPageViewController()
        
        self.addChild(self.pageController)
        self.view.addSubview(self.pageController.view)
        
        // Set PageViewController Delegate & DataSource
        pageController.delegate = self
        pageController.dataSource = self
        
        // Set the selected ViewController in the PageViewController when the app starts
        pageController.setViewControllers([showViewController(0)!], direction: .forward, animated: true, completion: nil)
        
        // PageViewController Constraints
        self.pageController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.pageController.view.topAnchor.constraint(equalTo: self.tabsView.bottomAnchor),
            self.pageController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.pageController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.pageController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        self.pageController.didMove(toParent: self)
    }
    
    func setupTabs() {
        // Add Tabs (Set 'icon'to nil if you don't want to have icons)
        tabsView.tabs = [
            Tab(icon: UIImage(named: "music"), title: "Music"),
            Tab(icon: UIImage(named: "movies"), title: "Movies"),
            Tab(icon: UIImage(named: "books"), title: "Books")
        ]
        
        // Set TabMode to '.fixed' for stretched tabs in full width of screen or '.scrollable' for scrolling to see all tabs
        tabsView.tabMode = .fixed
        
        // TabView Customization
        // TabView Customization
        tabsView.titleColor = .white
        tabsView.iconColor = .white
        tabsView.indicatorColor = .white
        tabsView.titleFont = UIFont.systemFont(ofSize: 20, weight: .semibold)
        tabsView.collectionView.backgroundColor = .cyan
        
        // Set TabsView Delegate
        tabsView.delegate = self
        
        // Set the selected Tab when the app starts
        tabsView.collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .centeredVertically)
    }
    // Show ViewController for the current position
    func showViewController(_ index: Int) -> UIViewController? {
        if (self.tabsView.tabs.count == 0) || (index >= self.tabsView.tabs.count) {
            return nil
        }
        
        currentIndex = index
        
        if index == 0 {
            let contentVC = Demo1ViewController()
            contentVC.pageIndex = index
            return contentVC
        } else if index == 1 {
            let contentVC = Demo2ViewController()
            contentVC.pageIndex = index
            return contentVC
        } else {
            let contentVC = Demo3ViewController()
            contentVC.pageIndex = index
            return contentVC
        }
    }
}

extension HomeViewController: TabsDelegate {
    func tabsViewDidSelectItemAt(position: Int) {
        // Check if the selected tab cell position is the same with the current position in pageController, if not, then go forward or backward
        if position != currentIndex {
            if position > currentIndex {
                self.pageController.setViewControllers([showViewController(position)!], direction: .forward, animated: false, completion: nil)
            } else {
                self.pageController.setViewControllers([showViewController(position)!], direction: .reverse, animated: false, completion: nil)
            }
            tabsView.collectionView.scrollToItem(at: IndexPath(item: position, section: 0), at: .centeredHorizontally, animated: false)
        }
    }
}

extension HomeViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    // return ViewController when go forward
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let vc = pageViewController.viewControllers?.first
        var index: Int
        index = getVCPageIndex(vc)
        // Don't do anything when viewpager reach the number of tabs
        if index == tabsView.tabs.count {
            return nil
        } else {
            index += 1
            return self.showViewController(index)
        }
    }
    
    // return ViewController when go backward
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let vc = pageViewController.viewControllers?.first
        var index: Int
        index = getVCPageIndex(vc)
        
        if index == 0 {
            return nil
        } else {
            index -= 1
            return self.showViewController(index)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if finished {
            if completed {
                guard let vc = pageViewController.viewControllers?.first else { return }
                let index: Int
                
                index = getVCPageIndex(vc)
                
                tabsView.collectionView.selectItem(at: IndexPath(item: index, section: 0), animated: true, scrollPosition: .centeredVertically)
                // Animate the tab in the TabsView to be centered when you are scrolling using .scrollable
                tabsView.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
            }
        }
    }
    
    // Return the current position that is saved in the UIViewControllers we have in the UIPageViewController
    func getVCPageIndex(_ viewController: UIViewController?) -> Int {
        switch viewController {
        case is Demo1ViewController:
            let vc = viewController as! Demo1ViewController
            return vc.pageIndex
        case is Demo2ViewController:
            let vc = viewController as! Demo2ViewController
            return vc.pageIndex
        case is Demo3ViewController:
            let vc = viewController as! Demo3ViewController
            return vc.pageIndex
        default:
            let vc = viewController as! Demo1ViewController
            return vc.pageIndex
        }
    }
}
