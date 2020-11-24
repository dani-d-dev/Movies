//
//  CollectionViewDataSource.swift
//  Movies
//
//  Created by Daniel Daverio on 09/11/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Convenience protocols to register and configure any kind of cells

protocol ReusableCell: class {
    static var reuseIdentifier: String { get }
}

extension ReusableCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

protocol ConfigurableCell: class {
    associatedtype DataType
    func configure(model: DataType)
}

protocol CellConfigurator {
    static var reuseId: String { get }
    func configure(cell: UIView)
    var dataType: Any { get }
}

// MARK: - Generic cell configurator wrapper implementing configurator protocol

final class CellConfiguratorHolder<CellType: ConfigurableCell & ReusableCell, DataType>: CellConfigurator where CellType.DataType == DataType {
    static var reuseId: String { return CellType.reuseIdentifier }

    internal var dataType: Any { return model }

    let model: DataType

    init(model: DataType) {
        self.model = model
    }

    func configure(cell: UIView) {
        guard let cellItem = cell as? CellType else { return }
        cellItem.configure(model: model)
    }
}

// MARK: - Wrapper conforming required uicollectionview's delegate & datasource protocols

class CollectionViewDataSource: NSObject {
    typealias DidSelectClosure = (Any, IndexPath) -> Void
    typealias DidScrollClosure = () -> Void

    var items: [CellConfigurator]
    var selectionClosure: DidSelectClosure?
    var didScrollClosure: DidScrollClosure?

    init(
        items: [CellConfigurator] = [],
        selectionClosure: DidSelectClosure? = nil,
        didScrollClosure: DidScrollClosure? = nil
    ) {
        self.items = items
        self.selectionClosure = selectionClosure
        self.didScrollClosure = didScrollClosure
    }
}

extension CollectionViewDataSource: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type(of: item).reuseId, for: indexPath)
        item.configure(cell: cell)
        return cell
    }
}

extension CollectionViewDataSource: UICollectionViewDelegate {
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        selectionClosure?(item.dataType, indexPath)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
        if (bottomEdge >= scrollView.contentSize.height) {
            didScrollClosure?()
        }
    }
}

