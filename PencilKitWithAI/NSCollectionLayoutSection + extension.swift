//
//  NSCollectionLayoutSection + extension.swift
//  PencilKitWithAI
//
//  Created by dale on 2022/12/02.
//

import UIKit.UICollectionViewCompositionalLayout

extension NSCollectionLayoutSection {
    convenience init(itemWidth: NSCollectionLayoutDimension,
                     itemHeight: NSCollectionLayoutDimension,
                     groupWidth: NSCollectionLayoutDimension,
                     groupHeight: NSCollectionLayoutDimension,
                     contentInset: NSDirectionalEdgeInsets) {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: itemWidth,
            heightDimension: itemHeight
        )

        let item = NSCollectionLayoutItem(
            layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: groupWidth,
            heightDimension: groupHeight
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        group.contentInsets = contentInset

        self.init(group: group)
    }
}
