//
//  MovieCellProtocol.swift
//  MovieChallange
//
//  Created by Ulaş Sancak on 17.08.2024.
//

import Foundation

protocol AsyncableImageView {
    var asyncableImageView: AsyncImageView { get }
}

extension AsyncableImageView {
    func loadImageWith(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        asyncableImageView.loadImage(from: url)
    }
    func cancelLoading() {
        asyncableImageView.cancelImageLoad()
    }
}

protocol MovieCellProtocol {
    func configure(with movie: OMDbMovie)
}
