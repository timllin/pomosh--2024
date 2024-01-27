//
//  ViewController.swift
//  pomosh--2024
//
//  Created by Тимур Калимуллин on 23.01.2024.
//

import UIKit

class ViewController: UIViewController {
    let mainView = MainView()
    let viewModel = MainViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        setupView()
        loadInfoToView()
    }

    private func setupView() {
        mainView.tableView.register(WardCell.self, forCellReuseIdentifier: WardCell.identifier)
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }

    private func loadInfoToView() {
        viewModel.loadWards() {[weak self] state in
            if state { self?.mainView.tableView.reloadData() }
        }
    }
}

extension ViewController: UITableViewDelegate & UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WardCell.identifier, for: indexPath) as? WardCell else { fatalError() }
        let ward = viewModel.wardsByIds[indexPath.row]
        viewModel.getImageFor(ward: ward) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    cell.configure(ward: ward, image: image)
                }
            case .failure(let error):
                print(error)
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countWards()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mainView.tableView.deselectRow(at: indexPath, animated: true)
        let ward = viewModel.wardsByIds[indexPath.row]
        guard let image = viewModel.cachedImages[ward.getId()] else {return}
        let wardViewController = WardViewController(displayName: ward.getDisplayName(), image: image)
        self.navigationController?.present(wardViewController, animated: true)
    }
}

