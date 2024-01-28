//
//  WardCell.swift
//  pomosh--2024
//
//  Created by Тимур Калимуллин on 23.01.2024.
//

import Foundation
import UIKit

class WardCell: UITableViewCell {
    static let identifier = "WardCell"

    private var wardPhotoView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    private var displayNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 35).isActive = true
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(wardPhotoView)
        addSubview(displayNameLabel)

        NSLayoutConstraint.activate([
            wardPhotoView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            wardPhotoView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            displayNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            displayNameLabel.leadingAnchor.constraint(equalTo: wardPhotoView.trailingAnchor, constant: 22)
        ])
    }

    public func configure(ward: Ward, image: UIImage) {
        displayNameLabel.text = ward.getDisplayName()
        wardPhotoView.image = image
    }
}
