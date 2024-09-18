//
//  TabLabelCell.swift
//  TabView
//
//  Created by Hamit Seyrek on 17.09.2024.
//

import UIKit

class TabLabelCell: UICollectionViewCell {
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // Cell Highlight를 위한 View 입니다.
    private let indicatorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                indicatorView.backgroundColor = .gray
            } else {
                indicatorView.backgroundColor = .white
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        contentView.addSubview(label)
        contentView.addSubview(indicatorView)
        
        NSLayoutConstraint.activate([
            self.label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            self.label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.indicatorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            self.indicatorView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),
            self.indicatorView.heightAnchor.constraint(equalToConstant: 3),
            self.indicatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setTitle(_ title: String) {
        self.label.text = title
    }
}
