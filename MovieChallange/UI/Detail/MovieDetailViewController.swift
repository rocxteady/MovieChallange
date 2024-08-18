//
//  MovieDetailViewController.swift
//  MovieChallange
//
//  Created by Ulaş Sancak on 17.08.2024.
//

import UIKit

class MovieDetailViewController: UIViewController {
    let viewModel: MovieDetailViewModel
    
    private let scrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let imageView = {
        let imageView = AsyncImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 24)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private let plotLabel = {
        let plotLabel = UILabel()
        plotLabel.numberOfLines = 0
        plotLabel.translatesAutoresizingMaskIntoConstraints = false
        return plotLabel
    }()
    
    private let directorLabel = {
        let directorLabel = UILabel()
        directorLabel.textColor = .gray
        directorLabel.textAlignment = .right
        directorLabel.translatesAutoresizingMaskIntoConstraints = false
        return directorLabel
    }()
    
    private lazy var stackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel, plotLabel, directorLabel])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let indicator = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private var statusSubscriptionIndex: Int? {
        didSet {
            if let oldValue {
                viewModel.statusSubscriber.unsubscribe(index: oldValue)
            }
        }
    }
    
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        subscribeToViewModel()
        viewModel.fetch()
    }
    
    private func subscribeToViewModel() {
        statusSubscriptionIndex = viewModel.statusSubscriber.subscribe { [weak self] status in
            guard let self else { return }
            switch status {
            case .loading:
                indicator.startAnimating()
            case .loaded:
                indicator.stopAnimating()
                loadMovieDetail()
            case .failed(let error):
                indicator.stopAnimating()
                showErrorAlert(message: error.localizedDescription) {
                    self.viewModel.resetError()
                }
            default:
                indicator.stopAnimating()
            }
        }
    }
    
    deinit {
        guard let statusSubscriptionIndex else { return }
        viewModel.statusSubscriber.unsubscribe(index: statusSubscriptionIndex)
    }
}

extension MovieDetailViewController {
    private func loadMovieDetail() {
        guard let movieDetail = viewModel.movieDetail else { return }
        if let url = URL(string: movieDetail.poster) {
            imageView.loadImage(from: url)
        }
        titleLabel.text = movieDetail.title
        plotLabel.text = movieDetail.plot
        directorLabel.text = movieDetail.director
    }
}

extension MovieDetailViewController {
    private func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        scrollView.addSubview(indicator)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            

            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -16),
            stackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -32),
            
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            indicator.centerXAnchor.constraint(equalTo: scrollView.contentLayoutGuide.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: scrollView.contentLayoutGuide.centerYAnchor)
        ])
    }
}
