import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var tabsView: TabsView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabs()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        // Configure collection view layout
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.sectionInset = .zero
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
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
    
    // UICollectionView DataSource Methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabsView.tabs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        // Clear previous content
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        let viewController = showViewController(indexPath.item)!
        self.addChild(viewController)
        viewController.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(viewController.view)
        viewController.didMove(toParent: self)
        
        return cell
    }
    
    // UICollectionViewDelegateFlowLayout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Make cell size equal to collection view's bounds size
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentIndex = indexPath.item
        tabsView.collectionView.selectItem(at: IndexPath(item: currentIndex, section: 0), animated: true, scrollPosition: .centeredVertically)
        collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            let offsetX = scrollView.contentOffset.x
            let pageWidth = scrollView.frame.size.width
            let pageIndex = round(offsetX / pageWidth)
            
            // Ensure index is within bounds
            let index = max(0, min(Int(pageIndex), tabsView.tabs.count - 1))
            
            if currentIndex != index {
                currentIndex = index
                tabsView.collectionView.selectItem(at: IndexPath(item: currentIndex, section: 0), animated: true, scrollPosition: .centeredVertically)
            }
        }
    }
    
    // Show ViewController for the current position
    func showViewController(_ index: Int) -> UIViewController? {
        if index >= tabsView.tabs.count {
            return nil
        }
        
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
        if position != currentIndex {
            currentIndex = position
            tabsView.collectionView.selectItem(at: IndexPath(item: currentIndex, section: 0), animated: true, scrollPosition: .centeredVertically)
            collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}
