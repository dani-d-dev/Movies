//
//  ColumnFlowLayout.swift
//  Movies
//
//  Created by Daniel Daverio on 11/11/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import UIKit

class ColumnFlowLayout: UICollectionViewFlowLayout {

    let cellsPerRow: Int
    let estimatedHeightRatio: Double

    init(
        cellsPerRow: Int = 3,
        estimatedHeightRatio: Double = 1.5,
        minimumInteritemSpacing: CGFloat = 1,
        minimumLineSpacing: CGFloat = 1,
        sectionInset: UIEdgeInsets = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    ) {
        self.cellsPerRow = cellsPerRow
        self.estimatedHeightRatio = estimatedHeightRatio
        super.init()

        self.minimumInteritemSpacing = minimumInteritemSpacing
        self.minimumLineSpacing = minimumLineSpacing
        self.sectionInset = sectionInset
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepare() {
        super.prepare()

        guard let collectionView = collectionView else { return }
        let marginsAndInsets = sectionInset.left + sectionInset.right + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        let itemHeight = itemWidth * CGFloat(estimatedHeightRatio)
        
        itemSize = CGSize(width: itemWidth, height: itemHeight)
    }

    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        super.invalidationContext(forBoundsChange: newBounds)
        let context = super.invalidationContext(forBoundsChange: newBounds) as! UICollectionViewFlowLayoutInvalidationContext
        context.invalidateFlowLayoutDelegateMetrics = newBounds.size != collectionView?.bounds.size
        return context
    }

}
