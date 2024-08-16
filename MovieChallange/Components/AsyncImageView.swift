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

    func loadImage(from url: URL, placeholder: UIImage? = nil) {
        imageLoader?.cancel()

        image = placeholder
        currentURL = url

        imageLoader = .init()
        imageLoader?.fetchImage(from: url, completion: { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let image):
                if url == self.currentURL {
                    DispatchQueue.main.async {
                        self.image = image
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
