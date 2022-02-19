//
//  NSObject+Extensions.swift
//  Bankin
//
//  Created by Aymen Bokri on 19/02/2022.
//

import Foundation

extension NSObject {
    public class var className: String {
        return String(describing: self.classForCoder())
    }
}
