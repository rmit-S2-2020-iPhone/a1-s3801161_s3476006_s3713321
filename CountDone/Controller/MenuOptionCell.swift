//
//  MenuOptionCell.swift
//  CountDone
//
//  Created by Changyu on 11/10/20.
//  Copyright © 2020 G33. All rights reserved.
//
// reference: https://www.youtube.com/watch?v=dB-vB9uDRCI

import UIKit

class MenuOptionCell: UITableViewCell {

    // MARK: -Properties
    
    let iconImageView: UIImageView = {
        let icon1 = UIImageView()
        icon1.contentMode = .scaleAspectFit
        icon1.clipsToBounds = true
//        icon1.backgroundColor = .white
        return icon1
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Sample"
        return label
    }()
    
    // MARK: -Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .darkGray
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        iconImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 12).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -Handlers

}
