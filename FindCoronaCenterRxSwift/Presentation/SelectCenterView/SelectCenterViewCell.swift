//
//  SelectCenterViewCell.swift
//  FindCoronaCenterRxSwift
//
//  Created by skillist on 2022/01/20.
//

import Foundation
import UIKit

class SelectCenterViewCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    private lazy var typeLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .gray
        return label
    }()
    
    private lazy var titleStackView: UIStackView = {
        var HStackView = UIStackView()
        HStackView.axis = .horizontal
        HStackView.spacing = 5
        
        [
            titleLabel,
            typeLabel
        ].forEach {
            HStackView.addArrangedSubview($0)
        }
        
        return HStackView
    }()
    
    private lazy var addressLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    private lazy var phoneLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .link
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        var VStackView = UIStackView()
        VStackView.axis = .vertical
        VStackView.distribution = .equalSpacing
        VStackView.spacing = 5
        
        [
            titleStackView,
            addressLabel,
            phoneLabel
        ].forEach {
            VStackView.addArrangedSubview($0)
        }
        
        return VStackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(labelStackView)
        
        labelStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(center: Center) {
        titleLabel.text = center.facilityName
        typeLabel.text = center.centerType.rawValue
        addressLabel.text = center.address
        phoneLabel.text = center.phoneNumber
    }
    
}
