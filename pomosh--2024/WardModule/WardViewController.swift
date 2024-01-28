//
//  WardViewController.swift
//  pomosh--2024
//
//  Created by Тимур Калимуллин on 25.01.2024.
//

import UIKit

class WardViewController: UIViewController {
    let displayName: String
    let image: UIImage

    private lazy var displayNameLable : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 66).isActive = true
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    init(displayName: String, image: UIImage) {
        self.displayName = displayName
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9692493081, green: 0.9649491906, blue: 0.947283566, alpha: 1)
        setupView()
    }

    private func setupView() {
        displayNameLable.text = displayName
        imageView.image = image

        view.addSubview(displayNameLable)
        view.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 12),
            imageView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            displayNameLable.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            displayNameLable.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 30),
            displayNameLable.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }

}
