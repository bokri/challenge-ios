//
//  UITableView+Extensions.swift
//  Bankin
//
//  Created by Aymen Bokri on 19/02/2022.
//

import UIKit

extension UITableView {
    public func register<T: UITableViewCell>(cellType: T.Type) {
        let className = cellType.className
        self.register(cellType, forCellReuseIdentifier: className)
    }

    public func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        let cell = self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
        cell.contentView.isUserInteractionEnabled = false
        return cell
    }
}
