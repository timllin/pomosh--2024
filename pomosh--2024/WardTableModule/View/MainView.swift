//
//  MainView.swift
//  pomosh--2024
//
//  Created by Тимур Калимуллин on 23.01.2024.
//

import Foundation
import UIKit

class MainView: UIView {
    lazy var tableView = UITableView(frame: .zero, style: .plain)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = #colorLiteral(red: 0.9692493081, green: 0.9649491906, blue: 0.947283566, alpha: 1)
        tableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tableView.layer.cornerRadius = 12
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 100
        
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
