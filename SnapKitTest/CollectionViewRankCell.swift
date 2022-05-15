//
//  CollectionViewRankCell.swift
//  SnapKitTest
//
//  Created by 박형환 on 2022/05/14.
//

import Foundation
import UIKit


class CollectionViewRankCell: UICollectionViewCell{
    var rankLabel = UILabel()
    var imageView = UIImageView()
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.backgroundColor = .black
        self.contentView.layer.cornerRadius = 5
    
        self.contentView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints{
            $0.top.trailing.bottom.equalToSuperview()
            $0.width.equalToSuperview()
        }
        rankLabel.textColor = .white
        rankLabel.font = .systemFont(ofSize: 100, weight: .black)
        contentView.addSubview(rankLabel)
        rankLabel.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().offset(24)
        }
    }
}
