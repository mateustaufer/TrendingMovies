//
//  MainViewModel.swift
//  Movietrending
//
//  Created by Mateus Eduardo Taufer dos Santos on 12/07/24.
//

import Foundation

class MainViewModel {
    
    var isLoadingData: Observable<Bool> = Observable(false)
    var dataSource: TrendingMovieModel?
    var movies: Observable<[MovieTableCellViewModel]> = Observable(nil)
    
    func numberOfSections() -> Int {
        1
    }
    
    func numberOfRows(in section: Int) -> Int {
        self.dataSource?.results.count ?? 0
    }
    
    func getData() {
        if isLoadingData.value ?? true {
            return
        }
        
        isLoadingData.value = true
        
        APICaller.getTrendingMovies { [weak self] result in
            self?.isLoadingData.value = false
            
            switch result {
            case .success(let trendingMovieData):
                self?.dataSource = trendingMovieData
                self?.mapMovieData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func mapMovieData() {
        movies.value = self.dataSource?.results.compactMap({MovieTableCellViewModel(movie: $0)})
    }
    
    func getMovieTitle(_ movie: Movie) -> String {
        movie.title ?? movie.name ?? ""
    }
    
    func retrieveMovie(with id: Int) -> Movie? {
        guard let movie = dataSource?.results.first(where: {$0.id == id}) else {
            return nil
        }
        
        return movie
    }
}
