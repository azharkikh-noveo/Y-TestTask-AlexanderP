//
//  ViewController.swift
//  MoviesTest
//
//  Created by Aleksandr Poliakov on 27.09.2022.
//

import UIKit
import SnapKit

final class MoviesListViewController: BaseViewController {
    var viewModel: MoviesListViewModel!
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.updateUI = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    override func loadView() {
        view = tableView
    }
}

extension MoviesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(viewModel.items[indexPath.row].item.id)
    }
}

extension MoviesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.items.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieCell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell else {
            fatalError("Cannot dequeue reusable cell with identifier MovieCell")
        }
        movieCell.viewModel = viewModel.items[indexPath.row]
        return movieCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        157
    }
}
