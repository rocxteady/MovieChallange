//
//  MovieTableViewCell.swift
//  MovieChallange
//
//  Created by Ulaş Sancak on 16.08.2024.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    private let thumbnailImageView: AsyncImageView = {
        let imageView = AsyncImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(labelsStackView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            labelsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            labelsStackView.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 8),
            labelsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            labelsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            thumbnailImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 120),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 80),
            thumbnailImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with movie: OMDbMovie) {
        titleLabel.text = movie.title
        subtitleLabel.text = movie.year
        if let url = URL(string: movie.poster) {
            thumbnailImageView.loadImage(from: url)
        } else {
            thumbnailImageView.image = nil
        }
    }
    
    func cancelLoading() {
        thumbnailImageView.cancelImageLoad()
    }
}
