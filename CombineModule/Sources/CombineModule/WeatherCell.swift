//
//  WeatherCell.swift
//  
//
//  Created by MEGA_Mac on 2024/03/21.
//

import UIKit

import Network

import SnapKit

final class WeatherCell: UICollectionViewCell {
    
    static let identifier = "WeatherCell"
    
    private let titleLabel = UILabel()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    
        self.setStyle()
        self.setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStyle() {
        contentView.backgroundColor = .blue
    }
    
    private func setLayout() {
        contentView.addSubview(titleLabel)

        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    public func convertDataToUI(from data: WeatherModel) {
        self.titleLabel.text = data.title
    }
}
