//
//  StoriesCell.swift
//  NewTimelineTest
//
//  Created by 築山朋紀 on 2019/09/17.
//  Copyright © 2019 tomoki_sun. All rights reserved.
//

import UIKit

final class StoriesCell: UICollectionViewCell {
    let imageView = UIImageView()
    let usernameLabel = UILabel()
    static let reuseIdentifier = "stories-cell-reuse-indentifier"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("not implemnted")
    }
    func configure() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemOrange
        contentView.addSubview(imageView)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.adjustsFontForContentSizeCategory = true
        usernameLabel.textAlignment = .center
        usernameLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        contentView.addSubview(usernameLabel)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0.0),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0.0),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0.0),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, constant: 0.0)
        ])
        NSLayoutConstraint.activate([
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0.0),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0.0),
            usernameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4.0),
            usernameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0.0)
        ])
    }
}
