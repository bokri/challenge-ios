//
//  UICardView.swift
//  Bankin
//
//  Created by Aymen Bokri on 19/02/2022.
//

import UIKit

public class UICardView: UIView {

    // MARK: Properties

    public static let shadowOpacity: Float = 0.2

    // MARK: Constructors

    public override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = Assets.ColorAssets.white.color
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.clear.cgColor

        self.layer.shadowOpacity = UICardView.shadowOpacity
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 5
        self.layer.shadowColor = Assets.ColorAssets.black.color.cgColor
        self.layer.masksToBounds = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
