//
//  MovieTableViewController.swift
//  MovieChallange
//
//  Created by Ulaş Sancak on 16.08.2024.
//

import UIKit

class MovieTableViewController: UITableViewController {
    private let viewModel: MovieSearchViewModel
    private let stringDebouncer = StringDebouncer()
    private var statusSubscriptionIndex: Int? {
        didSet {
            if let oldValue {
                viewModel.statusSubscriber.unsubscribe(index: oldValue)
            }
        }
    }
    
    init(viewModel: MovieSearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrangeLayout()
        subsctibeToViewModel()
        fetch()
    }
    
    private func subsctibeToViewModel() {
        statusSubscriptionIndex = viewModel.statusSubscriber.subscribe { [weak self] status in
            guard let self else { return }
            switch status {
            case .loading:
                tableView.refreshControl?.beginRefreshing()
                break
            case .failed(let error):
                showErrorAlert(message: error.localizedDescription) {
                    self.viewModel.resetError()
                }
                tableView.refreshControl?.endRefreshing()
            default:
                tableView.reloadData()
                tableView.refreshControl?.endRefreshing()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieTableViewCell.self), for: indexPath)

        guard let movieCell = cell as? MovieTableViewCell else {
            return cell
        }
        
        let movie = viewModel.movies[indexPath.row]
        movieCell.configure(with: movie)
        return movieCell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let movie = viewModel.movies[indexPath.row]
        if movie == viewModel.movies.last {
            fetch(shouldReset: false)
        }
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? MovieTableViewCell else { return }
        cell.cancelLoading()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = MovileDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    deinit {
        guard let statusSubscriptionIndex else { return }
        viewModel.statusSubscriber.unsubscribe(index: statusSubscriptionIndex)
    }
}

extension MovieTableViewController {
    private func arrangeLayout() {
        view.backgroundColor = .white
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: String(describing: MovieTableViewCell.self))
    }
}

//MARK: API
extension MovieTableViewController {
    @objc func refresh() {
        fetch()
    }
    
    func fetch(shouldReset: Bool = true) {
        viewModel.fetch(shouldReset: shouldReset)
    }
}

extension MovieTableViewController: UISearchControllerDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        fetch(shouldReset: true)
    }
}

extension MovieTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        stringDebouncer.debounce(text: searchText, debounceInterval: 1) { [weak self] debouncedText in
            self?.viewModel.setSearchTerm(debouncedText)
            self?.fetch(shouldReset: true)
        }
    }
}
