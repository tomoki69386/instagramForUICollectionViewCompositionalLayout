//
//  DataSource.swift
//  NewTimelineTest
//
//  Created by 築山朋紀 on 2019/09/17.
//  Copyright © 2019 tomoki_sun. All rights reserved.
//

import UIKit

final class DataSource: NSObject, UICollectionViewDataSource {
    private var collectionView: UICollectionView!
    convenience init(with collectionView: UICollectionView) {
        self.init()
        collectionView.dataSource = self
    }
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
