//
//  ValueSubscriber.swift
//  MovieChallange
//
//  Created by Ulaş Sancak on 17.08.2024.
//

import Foundation

class ValueSubscriber<T> {
    typealias Observer = (T) -> Void
    private(set) var value: T
    private var observers: [Observer] = []
    private var lastIndex: Int = 0
    
    init(value: T) {
        self.value = value
    }
    
    func setValue(_ value: T) {
        self.value = value
        observers.forEach { $0(value) }
    }
    
    func subscribe(_ observer: @escaping (T) -> Void) -> Int {
        defer {
            lastIndex += 1
        }
        observers.append(observer)
        observer(value)
        return lastIndex
    }
    
    func unsubscribe(index: Int) {
        defer {
            lastIndex -= 1
        }
        observers.remove(at: index)
    }
}
