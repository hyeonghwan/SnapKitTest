//
//  ContentCollectionViewHeader.swift
//  SnapKitTest
//
//  Created by 박형환 on 2022/05/05.
//

import Foundation
import UIKit
import SnapKit
class ContentCollectionViewHeader: UICollectionReusableView{
    let sectionNameLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("ContentCollectionViewHeader layoutSubviews Called")
        sectionNameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        sectionNameLabel.textColor = .white
        sectionNameLabel.sizeToFit()
        addSubview(sectionNameLabel)
        
        sectionNameLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.top.bottom.leading.equalToSuperview().offset(10)
            
        }
    }
}
