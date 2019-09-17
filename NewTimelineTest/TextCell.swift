//
//  TextCell.swift
//  NewTimelineTest
//
//  Created by 築山朋紀 on 2019/09/17.
//  Copyright © 2019 tomoki_sun. All rights reserved.
//

import UIKit

final class TextCell: UICollectionViewCell {
    let label = UILabel()
    static let reuseIdentifier = "text-cell-reuse-identifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("not implemnted")
    }
    func configure() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        contentView.addSubview(label)
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0.0),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0.0),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0.0),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0.0)
            ])
    }
}
