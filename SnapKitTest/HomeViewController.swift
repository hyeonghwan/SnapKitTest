//
//  HomeViewController.swift
//  SnapKitTest
//
//  Created by 박형환 on 2022/05/05.
//

import UIKit
import SwiftUI
import SnapKit
class HomeViewController: UICollectionViewController {
    var list: [DataOfCollectionView] = []
    let cellID: String = "ContentCollectionViewCell"
    let headerID: String = "ContentCollectionViewHeader"
    let rankCellID: String = "CollectionViewRankCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint(128/255)
        self.navigationController
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.hidesBarsOnSwipe = true
        navigationItem.title = "Netflix"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "netflix_icon"), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style: .plain, target: nil, action: nil)
        list = self.getContent()
        
        collectionView.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: self.cellID)
        collectionView.register(ContentCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.headerID)
        collectionView.register(CollectionViewRankCell.self, forCellWithReuseIdentifier: self.rankCellID)
        collectionView.backgroundColor = .black
        collectionView.collectionViewLayout = layout()
        print(list)
    }
    //MARK: CollectionViewLayout Compositional
    fileprivate func getContent() -> [DataOfCollectionView]{
        
        let Path = Bundle.main.path(forResource: "Content", ofType: "plist")
        if let filePath = Path {
            guard let data = FileManager.default.contents(atPath: filePath) else {return []}
            list = try! PropertyListDecoder().decode([DataOfCollectionView].self, from: data)
            return list
        } else {return []}
    }
    private func layout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout{ [weak self] sectionNumber,environment -> NSCollectionLayoutSection? in
            
            guard let self = self else {return nil}
        
            switch self.list[sectionNumber].sectionType{
            case .basic:
                return self.createBasicTypeSection()
            case .rank:
                return self.createRankTypeSection()
            case .large:
                return self.createLargeTypeSection()
            default:
                return nil
            }
        }
        
    }

    
    private func headerLayout() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(23))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        return header
    }
    
    
    //collectionView Layout
    private func createBasicTypeSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                              heightDimension: .fractionalHeight(0.75))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10,
                                   leading: 5,
                                   bottom: 0,
                                   trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8),
                                               heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item,
                                                       count: 3)
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 5,
                                      leading: 5,
                                      bottom: 5,
                                      trailing: 5)
        let headerItem = self.headerLayout()
        section.boundarySupplementaryItems = [headerItem]
        return section
    }
    private func createLargeTypeSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4),
                                              heightDimension: .fractionalHeight(0.75))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10,
                                   leading: 5,
                                   bottom: 0,
                                   trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8),
                                               heightDimension: .estimated(400))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item,
                                                       count: 2)
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 5,
                                      leading: 5,
                                      bottom: 5,
                                      trailing: 5)
        let headerItem = self.headerLayout()
        section.boundarySupplementaryItems = [headerItem]
        return section
    }
    private func createRankTypeSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(0.75))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10,
                                   leading: 5,
                                   bottom: 0,
                                   trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item,
                                                       count: 3)
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 5,
                                      leading: 5,
                                      bottom: 5,
                                      trailing: 5)
        let headerItem = self.headerLayout()
        section.boundarySupplementaryItems = [headerItem]
        return section
    }
}
extension HomeViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       let sectionType = list[section].sectionType
        if sectionType == .basic || sectionType == .rank || sectionType == .large{
            switch section {
            case 0:
                return 1
            default:
                return list[section].contentItem.count
            }
        }
        return 0
        
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch list[indexPath.section].sectionType {
        case .basic,.large:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? ContentCollectionViewCell
            else {return UICollectionViewCell() }
                    cell.imageView.image = list[indexPath.section].contentItem[indexPath.row].image
            return cell
        case .rank:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: rankCellID, for: indexPath) as? CollectionViewRankCell else {return UICollectionViewCell()}
            cell.rankLabel.text = String(indexPath.row + 1)
            cell.imageView.image = list[indexPath.section].contentItem[indexPath.row].image
            return cell
        default:
            return UICollectionViewCell()
            
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return list.count
    }
    
    
    //헤더뷰 설정
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.headerID, for: indexPath) as? ContentCollectionViewHeader else { fatalError("not suport header in collectionVIew")}
            headerView.sectionNameLabel.text = list[indexPath.section].sectionName
            return headerView
        } else { return UICollectionReusableView()}
    }
    
}

struct HomeViewController_previews: PreviewProvider{
    
    static var previews: some View{
        Container().edgesIgnoringSafeArea(.all)
    }
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            let layout = UICollectionViewLayout()
            let homeViewController = HomeViewController(collectionViewLayout: layout)
            return UINavigationController(rootViewController: homeViewController)
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
        
        typealias UIViewControllerType = UIViewController
    }
}
