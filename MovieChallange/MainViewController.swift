//
//  MainViewController.swift
//  MovieChallange
//
//  Created by Ulaş Sancak on 16.08.2024.
//

import UIKit

class MainViewController: UIViewController {
    let verticalVC = MovieTableViewController()
    let horizontalVC = HorizontalMovieCollectionViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        verticalVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(verticalVC.view)

        horizontalVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(horizontalVC.view)
        
        NSLayoutConstraint.activate([
            verticalVC.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            verticalVC.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            verticalVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            verticalVC.view.bottomAnchor.constraint(equalTo: horizontalVC.view.topAnchor),
            
            horizontalVC.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            horizontalVC.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            horizontalVC.view.heightAnchor.constraint(equalToConstant: 180), // Set the specific height
            horizontalVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
