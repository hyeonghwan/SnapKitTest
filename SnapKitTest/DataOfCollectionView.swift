//
//  DataOfCollectionView.swift
//  SnapKitTest
//
//  Created by 박형환 on 2022/05/14.
//

import Foundation
import UIKit

struct DataOfCollectionView: Decodable {
    var sectionType: SectionType
    var sectionName: String
    var contentItem: [Item]
    
    enum SectionType: String,Decodable{
        case main,basic,rank,large
    }

}
struct Item: Decodable{
    var description: String
    var imageName: String
    
    var image: UIImage {
        return UIImage(named: imageName) ?? UIImage()
    }
}
