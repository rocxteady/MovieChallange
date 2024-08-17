//
//  UIViewController+ShowError.swift
//  MovieChallange
//
//  Created by Ulaş Sancak on 17.08.2024.
//

import UIKit.UIViewController

extension UIViewController {
    func showErrorAlert(title: String = "Error", message: String, okAction: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            okAction?()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
