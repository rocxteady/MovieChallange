//
//  StringDebouncer.swift
//  MovieChallange
//
//  Created by Ulaş Sancak on 17.08.2024.
//

import Foundation

class StringDebouncer {
    private var debounceTimer: Timer?
    
    func debounce(text: String, debounceInterval: TimeInterval, onDebounced: @escaping (String) -> Void) {
        debounceTimer?.invalidate()
        
        debounceTimer = Timer.scheduledTimer(withTimeInterval: debounceInterval, repeats: false) { _ in
            onDebounced(text)
        }
    }
}
