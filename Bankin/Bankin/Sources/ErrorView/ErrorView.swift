//
//  ErrorView.swift
//  Bankin
//
//  Created by Aymen Bokri on 19/02/2022.
//

import Foundation
import UIKit
import Lottie

final public class ErrorView: UIView {

    // MARK: - Properties

    private var titleLabel: UILabel
    private var animationView: AnimationView
    private var subtitleLabel: UILabel
    private var callToAction: UIButton

    private weak var delegate: ErrorViewDelegate?

    // MARK: - Constructors

    public init() {
        self.titleLabel = UILabel(frame: .zero)
        self.animationView = AnimationView(name: Files.errorJson.name)
        self.subtitleLabel = UILabel(frame: .zero)
        self.callToAction = UIButton()

        super.init(frame: .zero)

        self.setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    public func setupDelegate(delegate: ErrorViewDelegate?) {
        self.delegate = delegate
    }

    // MARK: - Private Methods

    private func setupViews() {
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.textColor = Assets.ColorAssets.black.color
        self.titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        self.titleLabel.numberOfLines = 0
        self.titleLabel.textAlignment = .center
        self.titleLabel.text = Strings.genericErrorTitle
        self.addSubview(self.titleLabel)
        
        self.animationView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.animationView)
        
        self.subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.subtitleLabel.textColor = Assets.ColorAssets.grey.color
        self.subtitleLabel.font = UIFont.systemFont(ofSize: 14)
        self.subtitleLabel.numberOfLines = 0
        self.subtitleLabel.textAlignment = .center
        self.subtitleLabel.text = Strings.genericErrorDescription
        self.addSubview(self.subtitleLabel)

        self.callToAction.translatesAutoresizingMaskIntoConstraints = false
        self.callToAction.setTitle(Strings.genericErrorAction, for: .normal)
        self.callToAction.layer.cornerRadius = 20
        self.callToAction.setBackgroundColor(color: Assets.ColorAssets.blue.color, forState: .normal)
        self.callToAction.setBackgroundColor(color: Assets.ColorAssets.lightBlue.color, forState: .highlighted)
        self.callToAction.setTitleColor(Assets.ColorAssets.itemColor.color, for: .normal)
        self.addSubview(self.callToAction)

        self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 24.0).isActive = true
        self.titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 24.0).isActive = true
        self.titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -24.0).isActive = true
        self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        self.animationView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 40.0).isActive = true
        self.animationView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.animationView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.animationView.heightAnchor.constraint(equalToConstant: 160.0).isActive = true

        self.subtitleLabel.topAnchor.constraint(equalTo: self.animationView.bottomAnchor, constant: 40.0).isActive = true
        self.subtitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 18.0).isActive = true
        self.subtitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -18.0).isActive = true

        self.callToAction.topAnchor.constraint(equalTo: self.subtitleLabel.bottomAnchor, constant: 48.0).isActive = true
        self.callToAction.leftAnchor.constraint(equalTo: self.subtitleLabel.leftAnchor).isActive = true
        self.callToAction.rightAnchor.constraint(equalTo: self.subtitleLabel.rightAnchor).isActive = true
        self.callToAction.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: 0).isActive = true
        self.callToAction.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.callToAction.addTarget(self, action: #selector(self.errorButtonTouchUp), for: .touchUpInside)

        self.animationView.loopMode = .loop
        self.animationView.play()
    }

    @objc private func errorButtonTouchUp() {
        self.delegate?.errorButtonTouchUp()
    }

    public func playAnimation() {
        self.animationView.play()
    }
}
