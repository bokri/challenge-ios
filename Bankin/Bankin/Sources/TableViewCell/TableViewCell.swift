//
//  TableViewCell.swift
//  Bankin
//
//  Created by Aymen Bokri on 19/02/2022.
//

import Foundation
import UIKit
import Kingfisher

public class TableViewCell: UITableViewCell {
    
    // MARK: - Properties

    private var card: UICardView
    private var image: UIImageView
    private var name: UILabel
    
    // MARK: - Constructors

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.card = UICardView()
        self.image = UIImageView()
        self.name = UILabel()

        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.selectionStyle = .none

        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    public func setup(logoUrl: String, name: String) {
        self.name.text = name
        self.image.kf.setImage(with: URL(string: logoUrl),
                               placeholder: Assets.Assets.icBank.image)
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        self.card.translatesAutoresizingMaskIntoConstraints = false
        self.image.translatesAutoresizingMaskIntoConstraints = false
        self.name.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.card)
        self.card.addSubview(self.image)
        self.card.addSubview(self.name)
        
        self.image.contentMode = .scaleAspectFit
        self.image.heightAnchor.constraint(equalToConstant: 100).isActive = true
        self.image.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.image.centerYAnchor.constraint(equalTo: self.card.centerYAnchor).isActive = true
        self.image.leftAnchor.constraint(equalTo: self.card.leftAnchor, constant: 10).isActive = true
        
        self.name.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        self.name.numberOfLines = 2
        self.name.textAlignment = .center
        
        self.name.leftAnchor.constraint(equalTo: self.image.rightAnchor, constant: 10).isActive = true
        self.name.rightAnchor.constraint(equalTo: self.card.rightAnchor, constant: -10).isActive = true
        self.name.topAnchor.constraint(equalTo: self.card.topAnchor, constant: 10).isActive = true
        self.name.bottomAnchor.constraint(equalTo: self.card.bottomAnchor, constant: -10).isActive = true
        self.name.centerYAnchor.constraint(equalTo: self.card.centerYAnchor).isActive = true
        
        self.card.allAnchors.constraint(equalTo: self.allAnchors, constant: 5).isActive(true)
    }
}
