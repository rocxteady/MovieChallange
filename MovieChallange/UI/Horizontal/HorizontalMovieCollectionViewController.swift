//
//  HorizontalMovieCollectionViewController.swift
//  MovieChallange
//
//  Created by Ulaş Sancak on 16.08.2024.
//

import UIKit

class HorizontalMovieCollectionViewController: UICollectionViewController {
    let viewModel: MovieSearchViewModel
    private var statusSubscriptionIndex: Int? {
        didSet {
            if let oldValue {
                viewModel.statusSubscriber.unsubscribe(index: oldValue)
            }
        }
    }

    init(viewModel: MovieSearchViewModel) {
        self.viewModel = viewModel
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 8, left: 8, bottom: 8, right: 8)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.collectionView.register(HorizontalMovieCell.self, forCellWithReuseIdentifier: String(describing: HorizontalMovieCell.self))
        subsctibeToViewModel()
        viewModel.fetch()
    }

    private func subsctibeToViewModel() {
        statusSubscriptionIndex = viewModel.statusSubscriber.subscribe { [weak self] status in
            guard let self else { return }
            switch status {
            case .loading:
                break
            case .failed(let error):
                showErrorAlert(message: error.localizedDescription) {
                    self.viewModel.resetError()
                }
            case .loaded(let shouldReload):
                if shouldReload {
                    collectionView.reloadData()
                }
            default:
                collectionView.reloadData()
            }
        }
    }
    
// MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HorizontalMovieCell.self), for: indexPath)
    
        guard let movieCell = cell as? HorizontalMovieCell else {
            return cell
        }
        let movie = viewModel.movies[indexPath.row]
        movieCell.configure(with: movie)
        return movieCell
    }

// MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.fetchIfLast(at: indexPath.item)
    }
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? AsyncableImageView else {
            return
        }
        cell.cancelLoading()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = viewModel.getMovie(at: indexPath.item)
        let detailViewController = MovieDetailViewController(viewModel: .init(movieId: movie.imdbID, repo: RemoteOMDbDetailRepo()))
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    deinit {
        guard let statusSubscriptionIndex else { return }
        viewModel.statusSubscriber.unsubscribe(index: statusSubscriptionIndex)
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension HorizontalMovieCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: HorizontalMovieCell.width, height: collectionView.bounds.size.height)
    }
}
