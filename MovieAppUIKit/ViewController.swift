//
//  ViewController.swift
//  MovieAppUIKit
//
//  Created by Nova Arisma on 4/29/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var movies: [Movie] = []
    var cell: String = ""
    var detailIdentifier: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Movies"
        cell = "cell"
        detailIdentifier = "goToDetail"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        searchBar.delegate = self
        
        fetchData()
    }

    // MARK: - API
    func fetchData(query: String = "") {
        APIService.shared.fetchMovies(query: query) { movies in
            self.movies = movies
            self.tableView.reloadData()
        }
    }
}

// MARK: - TableView
extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: cell, for: indexPath)

        let movie = movies[indexPath.row]

        cell.textLabel?.text = movie.title
        cell.detailTextLabel?.text = movie.overview

        return cell
    }
}

// MARK: - Search
extension ViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        fetchData(query: searchText)
    }
}

extension ViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailIdentifier {
            let vc = segue.destination as! DetailViewController
            
            if let indexPath = tableView.indexPathForSelectedRow {
                vc.movie = movies[indexPath.row]
            }
        }
    }
}

