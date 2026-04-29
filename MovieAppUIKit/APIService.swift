//
//  APIService.swift
//  MovieAppUIKit
//
//  Created by Nova Arisma on 4/29/26.
//

import Foundation

class APIService {
    
    static let shared = APIService()
    let apiKey = "98845a3f200e361f2f534106f6b61feb"
    
    func fetchMovies(query: String = "", completion: @escaping ([Movie]) -> Void) {
        
        var urlString: String
        
        if query.isEmpty {
            urlString = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)"
        } else {
            urlString = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(query)"
        }
        
        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            
            if let data = data {
                let result = try? JSONDecoder().decode(MovieResponse.self, from: data)
                
                DispatchQueue.main.async {
                    completion(result?.results ?? [])
                }
            }
            
        }.resume()
    }
}
