//
//  LoadingView.swift
//  Bankin
//
//  Created by Aymen Bokri on 19/02/2022.
//

import UIKit
import Lottie

public class LoadingView: UIView {

    // MARK: Properties

    private var animationView: AnimationView

    // MARK: Constructors

    public init() {
        self.animationView = AnimationView(name: Files.loadingJson.name)

        super.init(frame: .zero)
        
        self.animationView.translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = Assets.ColorAssets.white.color
        self.addSubview(self.animationView)
        
        self.animationView.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        self.animationView.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        self.animationView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.animationView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        self.animationView.loopMode = .loop
        self.animationView.play()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public Methods

    public func play() {
        self.animationView.play()
    }
}
