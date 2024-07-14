//
//  NetworkContants.swift
//  Movietrending
//
//  Created by Mateus Eduardo Taufer dos Santos on 12/07/24.
//

import Foundation

class NetworkConstants {
    
    public static var shared: NetworkConstants = NetworkConstants()
    
    private init() {
        
    }
    
    public var apiKey: String {
        get {
            return "4a7018376d6a5239159d0bb9b44a54ad"
        }
    }
    
    public var serverAddress: String {
        get {
            return "https://api.themoviedb.org/3/"
        }
    }
    
    public var imageServerAddress: String {
        get {
            return "https://image.tmdb.org/t/p/w500/"
        }
    }
    
}
