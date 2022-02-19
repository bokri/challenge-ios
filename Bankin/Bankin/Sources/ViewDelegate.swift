//
//  ViewDelegate.swift
//  Bankin
//
//  Created by Aymen Bokri on 19/02/2022.
//

import Foundation

public protocol ViewDelegate: AnyObject {
    func showError()
    func showLoading()
    func showSuccess()
    func reloadTableView()
}
