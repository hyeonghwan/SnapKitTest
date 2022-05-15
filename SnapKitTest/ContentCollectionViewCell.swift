//
//  ContentCollectionViewCell.swift
//  SnapKitTest
//
//  Created by 박형환 on 2022/05/05.
//

import UIKit
import SnapKit

class ContentCollectionViewCell: UICollectionViewCell {
    
    var imageView = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = .black
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        imageView.contentMode = .scaleToFill
        
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}
