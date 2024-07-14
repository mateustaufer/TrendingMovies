//
//  MainViewController.swift
//  Movietrending
//
//  Created by Mateus Eduardo Taufer dos Santos on 12/07/24.
//

import UIKit
import SDWebImage

class MainViewController: UIViewController {
    
    //IBOutlets:
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //ViewModels:
    var mainViewModel: MainViewModel = MainViewModel()
    
    //Variables:
    var moviesDataSource: [MovieTableCellViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        bindMainViewModel()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        mainViewModel.getData()
    }
    
    func configView() {
        self.title = "Top Trending Movies"
        self.view.backgroundColor = UIColor.white
        
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainViewModel.getData()
    }
    
    func bindMainViewModel() {
        mainViewModel.isLoadingData.bind { [weak self] isLoading in
            guard let isLoading = isLoading else {
                return
            }
            
            DispatchQueue.main.async {
                if isLoading {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
        
        mainViewModel.movies.bind { [weak self] movies in
            guard let self = self,
                  let movies = movies else {
                return
            }
            
            self.moviesDataSource = movies
            self.reloadTableView()
        }
    }
    
    func openDetails(movieId: Int) {
        guard let movie = mainViewModel.retrieveMovie(with: movieId) else {
            return
        }
        
        DispatchQueue.main.async {
            let detailsViewModel = DetailsMovieViewModel(movie: movie)
            let detailsViewController = DetailsMovieViewController(viewModel: detailsViewModel)
            self.navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
    
}
