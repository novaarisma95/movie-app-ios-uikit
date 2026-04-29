//
//  DetailViewController.swift
//  MovieAppUIKit
//
//  Created by Nova Arisma on 4/29/26.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewText: UITextView!

    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let movie = movie else { return }

        titleLabel.text = movie.title
        overviewText.text = movie.overview

        if let poster = movie.posterPath {
            let urlString = "https://image.tmdb.org/t/p/w500\(poster)"
            loadImage(urlString: urlString)
        }
    }

    func loadImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }
        }.resume()
    }
}
