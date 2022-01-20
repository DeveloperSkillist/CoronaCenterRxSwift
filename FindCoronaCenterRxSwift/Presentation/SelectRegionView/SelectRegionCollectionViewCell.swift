//
//  SelectRegionCollectionViewCell.swift
//  FindCoronaCenterRxSwift
//
//  Created by skillist on 2022/01/19.
//

import UIKit

class SelectRegionCollectionViewCell: UICollectionViewCell {
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.textColor = .purple
        label.font = .systemFont(ofSize: 25)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var numberLabel: UILabel = {
        var label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [
            titleLabel,
            numberLabel
        ].forEach {
            addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.centerX.equalToSuperview()
        }
        
        numberLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview().inset(15)
            $0.centerX.equalToSuperview()
        }
        
        self.backgroundColor = .lightGray
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(title: String, number: String) {
        titleLabel.text = title
        numberLabel.text = number
    }
}
