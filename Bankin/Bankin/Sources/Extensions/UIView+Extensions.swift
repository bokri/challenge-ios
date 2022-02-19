//
//  UIView+Extensions.swift
//  Bankin
//
//  Created by Aymen Bokri on 19/02/2022.
//

import UIKit

extension UIView {
    public var allAnchors: NSLayoutAllAnchors {
        return NSLayoutAllAnchors(left: self.leftAnchor, right: self.rightAnchor, top: self.safeAreaLayoutGuide.topAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor)
    }
}

public struct NSLayoutAllAnchors {
    internal var left: NSLayoutXAxisAnchor
    internal var right: NSLayoutXAxisAnchor
    internal var top: NSLayoutYAxisAnchor
    internal var bottom: NSLayoutYAxisAnchor

    public func constraint(equalTo allAnchors: NSLayoutAllAnchors, constant: CGFloat = 0) -> [NSLayoutConstraint] {
        return [self.left.constraint(equalTo: allAnchors.left, constant: constant),
                self.right.constraint(equalTo: allAnchors.right, constant: -constant),
                self.top.constraint(equalTo: allAnchors.top, constant: constant),
                self.bottom.constraint(equalTo: allAnchors.bottom, constant: -constant)]
    }
}

extension Array where Element == NSLayoutConstraint {
    public var isActive: Bool {
        return !self.contains(where: { constraint -> Bool in
            return !constraint.isActive
        })
    }

    public func isActive(_ bool: Bool) {
        for constraint in self {
            constraint.isActive = bool
        }
    }
}

extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
}

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


extension NSObject {
    public class var className: String {
        return String(describing: self.classForCoder())
    }
}
