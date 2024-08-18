//
//  MainViewController.swift
//  MovieChallange
//
//  Created by Ulaş Sancak on 16.08.2024.
//

import UIKit

class MainViewController: UIViewController {
    private var statusSubscriptionIndexForTable: Int? {
        didSet {
            if let oldValue {
                tableViewModel.statusSubscriber.unsubscribe(index: oldValue)
            }
        }
    }
    private var statusSubscriptionIndexForHorizontal: Int? {
        didSet {
            if let oldValue {
                horizontalViewModel.statusSubscriber.unsubscribe(index: oldValue)
            }
        }
    }

    private lazy var tableViewModel = {
        let viewModel = MovieSearchViewModel(defaultSearchTerm: "Star", repo: RemoteOMDBSearchRepo())
        return viewModel
    }()
    
    private lazy var horizontalViewModel = {
        let viewModel = MovieSearchViewModel(defaultSearchTerm: "Comedy", repo: RemoteOMDBSearchRepo())
        return viewModel
    }()

    private lazy var movieTableViewController = {
        return MovieTableViewController(viewModel: tableViewModel)
    }()
    
    private lazy var movieCollectionViewController = {
        HorizontalMovieCollectionViewController(viewModel: horizontalViewModel)
    }()
    
    private lazy var indicator = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let searchController = UISearchController(searchResultsController: nil)
        searchController.delegate = movieTableViewController
        searchController.searchBar.delegate = movieTableViewController
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        title = "MovieChallange"
        arrangeLayout()
        subscribeToViewModels()
    }
    
    private func subscribeToViewModels() {
        statusSubscriptionIndexForTable = tableViewModel.statusSubscriber.subscribe { [weak self] status in
            guard let self else { return }
            handleStatuses(first: status, second: horizontalViewModel.statusSubscriber.value)
        }
        statusSubscriptionIndexForHorizontal = horizontalViewModel.statusSubscriber.subscribe { [weak self] status in
            guard let self else { return }
            handleStatuses(first: tableViewModel.statusSubscriber.value, second: status)
        }
    }
    
    private func handleStatuses(first: SearchStatus, second: SearchStatus) {
        if first == .loading && second == .loading {
            indicator.startAnimating()
        } else {
            indicator.stopAnimating()
        }
    }
    
    @objc func tableViewDidRefresh() {
        horizontalViewModel.fetch()
    }
    
    deinit {
        if let statusSubscriptionIndexForTable {
            tableViewModel.statusSubscriber.unsubscribe(index: statusSubscriptionIndexForTable)
        }
        if let statusSubscriptionIndexForHorizontal {
            horizontalViewModel.statusSubscriber.unsubscribe(index: statusSubscriptionIndexForHorizontal)
        }
    }
}

extension MainViewController {
    private func arrangeLayout() {
        view.backgroundColor = .white
        movieTableViewController.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(movieTableViewController)
        view.addSubview(movieTableViewController.view)
        movieTableViewController.didMove(toParent: self)

        movieCollectionViewController.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(movieCollectionViewController)
        view.addSubview(movieCollectionViewController.view)
        movieCollectionViewController.didMove(toParent: self)
        
        view.addSubview(indicator)

        NSLayoutConstraint.activate([
            movieTableViewController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            movieTableViewController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            movieTableViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieTableViewController.view.bottomAnchor.constraint(equalTo: movieCollectionViewController.view.topAnchor, constant: -16),
            
            movieCollectionViewController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            movieCollectionViewController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            movieCollectionViewController.view.heightAnchor.constraint(equalToConstant: 180), // Set the specific height
            movieCollectionViewController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
