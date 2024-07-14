//
//  DetailsMovieViewModel.swift
//  Movietrending
//
//  Created by Mateus Eduardo Taufer dos Santos on 13/07/24.
//

import Foundation

class DetailsMovieViewModel {
    var movieID: Int
    var movieImage: URL?
    var movieTitle: String
    var movieDescription: String
    var movie: Movie
    
    init(movie: Movie) {
        self.movieID = movie.id
        self.movieTitle = movie.title ?? movie.name ?? ""
        self.movieDescription = movie.overview ?? ""
        self.movie = movie
        self.movieImage = makeImageURL(movie.posterPath ?? "")
    }
    
    private func makeImageURL(_ imageCode: String) -> URL? {
        URL(string: "\(NetworkConstants.shared.imageServerAddress)\(imageCode)")
    }
}
