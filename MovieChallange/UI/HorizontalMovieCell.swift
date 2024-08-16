//
//  HorizontalMovieCell.swift
//  MovieChallange
//
//  Created by Ulaş Sancak on 16.08.2024.
//

import UIKit

class HorizontalMovieCell: UICollectionViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Create the  view
    private let movieImageView: AsyncImageView = {
        let imageView = AsyncImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(movieImageView)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8)
        ])
        
        let movieImageViewHeightConstraint = movieImageView.heightAnchor.constraint(equalToConstant: 0)
        movieImageViewHeightConstraint.priority = .defaultLow
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            movieImageViewHeightConstraint
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImageView.cancelImageLoad()
        movieImageView.image = nil
    }
    
    func configure(with movie: OMDbMovie) {
        titleLabel.text = movie.title
        if let url = URL(string: movie.poster) {
            movieImageView.loadImage(from: url)
        } else {
            movieImageView.image = nil
        }
    }
    
    func cancelLoading() {
        movieImageView.cancelImageLoad()
    }
}
