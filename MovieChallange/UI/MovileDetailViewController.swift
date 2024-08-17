//
//  MovileDetailViewController.swift
//  MovieChallange
//
//  Created by Ulaş Sancak on 17.08.2024.
//

import UIKit

class MovileDetailViewController: UIViewController {
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
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusSubscriptionIndex = viewModel.statusSubscriber.subscribe { status in
            print(status)
        }
    }
    
    deinit {
        guard let statusSubscriptionIndex else { return }
        viewModel.statusSubscriber.unsubscribe(index: statusSubscriptionIndex)
    }
}
