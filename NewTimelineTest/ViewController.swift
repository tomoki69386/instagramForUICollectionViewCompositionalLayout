//
//  ViewController.swift
//  NewTimelineTest
//
//  Created by 築山朋紀 on 2019/09/17.
//  Copyright © 2019 tomoki_sun. All rights reserved.
//

import UIKit
import IBPCollectionViewCompositionalLayout

class ViewController: UIViewController {
    
    private var collectionView: UICollectionView! = nil
    static let gridSectionHeaderElementKind = "grid-section-header-element-kind"
    static let listSectionHeaderElementKind = "list-section-header-element-kind"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "ホーム"
        configureHierarchy()
    }
    
    enum Section: Int {
        case stories
        case timeline
    }
}

extension ViewController {
    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionNumber, env -> NSCollectionLayoutSection? in
            switch Section(rawValue: sectionNumber) {
            case .stories:
                return self.gridSection()
            case .timeline:
                return self.listSection()
            default:
                return nil
            }
        }
    }
    private func listSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 4)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .absolute(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: ViewController.listSectionHeaderElementKind, alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    private func gridSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.23),
                                               heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .absolute(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: ViewController.gridSectionHeaderElementKind, alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    private func configureHierarchy() {
        let layout = createLayout()
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.register(TextCell.self, forCellWithReuseIdentifier: TextCell.reuseIdentifier)
        collectionView.register(StoriesCell.self, forCellWithReuseIdentifier: StoriesCell.reuseIdentifier)
        collectionView.register(TitleSupplementaryView.self,
                                forSupplementaryViewOfKind: ViewController.gridSectionHeaderElementKind,
                                withReuseIdentifier: TitleSupplementaryView.reuseIdentifier)
        collectionView.register(TitleSupplementaryView.self,
                                forSupplementaryViewOfKind: ViewController.listSectionHeaderElementKind,
                                withReuseIdentifier: TitleSupplementaryView.reuseIdentifier)
        view.addSubview(collectionView)
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch ViewController.Section(rawValue: indexPath.section) {
        case .stories:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoriesCell.reuseIdentifier, for: indexPath) as? StoriesCell else {
                fatalError("Invalid cell")
            }
            cell.usernameLabel.text = "tomoki_sun"
            cell.imageView.layer.cornerRadius = cell.contentView.frame.width / 2
            return cell
        case .timeline:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextCell.reuseIdentifier, for: indexPath) as? TextCell else {
                fatalError("Invalid cell")
            }
            cell.label.text = "\(indexPath.section):\(indexPath.row)"
            cell.label.backgroundColor = .systemRed
            return cell
        default:
            fatalError("invalid case")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let suppolementaryView = collectionView.dequeueReusableSupplementaryView( ofKind: kind, withReuseIdentifier: TitleSupplementaryView.reuseIdentifier, for: indexPath) as? TitleSupplementaryView else {
                fatalError("Cannot create new supplementary")
        }
        let viewKind = kind == ViewController.gridSectionHeaderElementKind ? "ストーリーズ" : "タイムライン"
        suppolementaryView.label.text = viewKind
        return suppolementaryView
    }
}
