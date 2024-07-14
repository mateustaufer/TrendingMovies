//
//  MainViewController+TableView.swift
//  Movietrending
//
//  Created by Mateus Eduardo Taufer dos Santos on 12/07/24.
//

import Foundation
import UIKit

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .clear
        self.registerCells()
    }
    
    func registerCells() {
        tableView.register(MainMovieCell.register(), forCellReuseIdentifier: MainMovieCell.identifier)
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        mainViewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mainViewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainMovieCell.identifier, for: indexPath) as? MainMovieCell else {
            return UITableViewCell()
        }
        
        cell.setupCell(viewModel: moviesDataSource[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieId = moviesDataSource[indexPath.row].id
        self.openDetails(movieId: movieId)
    }
}
