//
//  MovieTableViewCell.swift
//  MovieChallange
//
//  Created by Ulaş Sancak on 16.08.2024.
//

import UIKit

class MovieTableViewCell: UITableViewCell, AsyncableImageView {
    let asyncableImageView: AsyncImageView = {
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
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieTableViewCell {
    private func setupLayout() {
        contentView.addSubview(asyncableImageView)
        contentView.addSubview(labelsStackView)

        NSLayoutConstraint.activate([
            labelsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            labelsStackView.leadingAnchor.constraint(equalTo: asyncableImageView.trailingAnchor, constant: 8),
            labelsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            labelsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            asyncableImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            asyncableImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            asyncableImageView.widthAnchor.constraint(equalToConstant: 120),
            asyncableImageView.heightAnchor.constraint(equalToConstant: 80),
            asyncableImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}

// MARK: Data
extension MovieTableViewCell: MovieCellProtocol {
    func configure(with movie: OMDbMovie) {
        titleLabel.text = movie.title
        subtitleLabel.text = movie.year
        loadImageWith(movie.poster)
    }
}
