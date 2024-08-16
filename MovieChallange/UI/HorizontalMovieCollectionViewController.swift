//
//  HorizontalMovieCollectionViewController.swift
//  MovieChallange
//
//  Created by Ulaş Sancak on 16.08.2024.
//

import UIKit

private let reuseIdentifier = "Cell"

class HorizontalMovieCollectionViewController: UICollectionViewController {
    let movies: [OMDbMovie] = .preview + .preview + .preview
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(HorizontalMovieCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        guard let movieCell = cell as? HorizontalMovieCell else {
            return cell
        }
        let movie = movies[indexPath.row]
        movieCell.configure(with: movie)
        return movieCell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? HorizontalMovieCell else {
            return
        }
        cell.cancelLoading()
    }
}

extension HorizontalMovieCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 240, height: collectionView.bounds.size.height)
    }
}

#if IOS17_OR_LATER
#Preview {
    HorizontalMovieCollectionViewController()
}
#endif
