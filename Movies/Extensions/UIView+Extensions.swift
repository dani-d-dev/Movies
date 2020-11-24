//
//  UIView+Extensions.swift
//  PracticeBoard
//
//  Created by Daniel Daverio on 05/10/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Foundation
import UIKit

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }

    class var className: String {
        return String(describing: self)
    }

    var nib: UINib {
        return UINib(nibName: className, bundle: nil)
    }

    class var nib: UINib {
        return UINib(nibName: className, bundle: nil)
    }
}

extension UICollectionViewCell: ReusableCell {}

extension UICollectionView {
    func register(cellType: ReusableCell.Type) {
        register(cellType.self, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
}
