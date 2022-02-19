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
