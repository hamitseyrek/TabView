import UIKit

class TabContentView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var tabsView: TabsView!
    private var collectionView: UICollectionView!
    private var currentIndex: Int = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        // TabsView setup
        tabsView = TabsView()
        tabsView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tabsView)
        
        // CollectionView setup
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.sectionInset = .zero
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        
        self.addSubview(collectionView)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            tabsView.topAnchor.constraint(equalTo: self.topAnchor),
            tabsView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tabsView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tabsView.heightAnchor.constraint(equalToConstant: 40), // Increased height for tabs
            
            collectionView.topAnchor.constraint(equalTo: tabsView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        // Configure TabsView
        tabsView.titleColor = .white
        tabsView.iconColor = .white
        tabsView.indicatorColor = .white
        tabsView.titleFont = UIFont.systemFont(ofSize: 18, weight: .semibold) // Adjust font size if needed
        tabsView.collectionView.backgroundColor = .cyan
        tabsView.delegate = self
        
        // Configure CollectionView
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        setupTabs()
        
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
    func configureTabs(tabs: [Tab]) {
        tabsView.tabs = tabs
        tabsView.collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .centeredVertically)
        collectionView.reloadData()
    }
    
    private func showViewController(_ index: Int) -> UIViewController? {
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
    
    // MARK: - UICollectionViewDataSource
    
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
        viewController.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(viewController.view)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    // MARK: - UIScrollViewDelegate
    
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
}

extension TabContentView: TabsDelegate {
    func tabsViewDidSelectItemAt(position: Int) {
        if position != currentIndex {
            currentIndex = position
            tabsView.collectionView.selectItem(at: IndexPath(item: currentIndex, section: 0), animated: true, scrollPosition: .centeredVertically)
            collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}
