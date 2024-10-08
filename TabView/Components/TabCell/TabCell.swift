//
//  TabCell.swift
//  TabView
//
//  Created by Hamit Seyrek on 16.09.2024.
//

import UIKit
class TabCell: UICollectionViewCell {
    private var tabSV: UIStackView!
    
    var tabTitle: UILabel!
    
    var tabIcon: UIImageView!
    
//    var indicatorView: UIView!
    private let indicatorView: UIView = {
        let view = UIView()
//        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    var indicatorColor: UIColor = UIColor(hexString: "490E6F")
    
    override var isSelected: Bool {
        didSet {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3) {
                    self.indicatorView.backgroundColor = self.isSelected ? self.indicatorColor : UIColor.clear
                    self.tabTitle.textColor = UIColor(hexString: "490E6F") // self.isSelected ? .white : .black
                    self.tabIcon.tintColor = self.isSelected ? .white : .black // İkon rengi
                    self.backgroundColor = self.isSelected ? UIColor(hexString: "F5EAFD") : .clear
                    self.layoutIfNeeded()
                }
            }
        }
    }
    
    var tabViewModel: Tab? {
        didSet {
            tabTitle.text = tabViewModel?.title
            tabIcon.image = tabViewModel?.icon
            
            // Remove stackView spacing if icon is nil
            (tabViewModel?.icon != nil) ? (tabSV.spacing = 10) : (tabSV.spacing = 0)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tabSV = UIStackView()
        tabSV.axis = .horizontal
        tabSV.distribution = .equalCentering
        tabSV.alignment = .center
        tabSV.spacing = 10.0
        addSubview(tabSV)
        
        // Tab Icon
        tabIcon = UIImageView()
        tabIcon.clipsToBounds = true
        self.tabSV.addArrangedSubview(tabIcon)
        
        // Tab Title
        tabTitle = UILabel()
        tabTitle.textAlignment = .center
        self.tabSV.addArrangedSubview(tabTitle)
        
        // TabIcon Constaints
        tabIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tabIcon.heightAnchor.constraint(equalToConstant: 18),
            self.tabIcon.widthAnchor.constraint(lessThanOrEqualToConstant: 18)
        ])
        
        // TabSv Constraints
        tabSV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tabSV.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            tabSV.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        setupIndicatorView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tabTitle.text = ""
        tabIcon.image = nil
    }
    
    func setupIndicatorView() {
//        indicatorView = UIView()
        addSubview(indicatorView)

        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            indicatorView.heightAnchor.constraint(equalToConstant: 3), // for animation for selected
            indicatorView.widthAnchor.constraint(equalTo: self.widthAnchor),
            indicatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
