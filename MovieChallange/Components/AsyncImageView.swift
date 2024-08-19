//
//  AsyncImageView.swift
//  MovieChallange
//
//  Created by Ulaş Sancak on 16.08.2024.
//

import UIKit.UIImageView

class AsyncImageView: UIImageView {
    private var imageLoader: ImageLoader?
    private var currentURL: URL?

    func loadImage(from url: URL, placeholder: UIImage? = .movieclapper) {
        imageLoader?.cancel()

        image = placeholder
        currentURL = url

        imageLoader = .init()
        imageLoader?.fetchImage(from: url, completion: { [weak self] result in
            if url == self?.currentURL {
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        self?.image = placeholder
                    case .success(let image):
                        self?.image = image
                    }
                }
            }
        })
    }

    func cancelImageLoad() {
        imageLoader?.cancel()
        imageLoader = nil
        currentURL = nil
    }
}
