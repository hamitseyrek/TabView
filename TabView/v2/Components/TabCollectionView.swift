//
//  TabCollectionView.swift
//  TabView
//
//  Created by Hamit Seyrek on 17.09.2024.
//

import UIKit

class TabCollectionView: UIView {
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: setLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCollectionView()
    }

    private func setupCollectionView() {
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    

    
        private func setLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}
