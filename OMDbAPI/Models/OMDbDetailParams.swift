//
//  OMDbDetailParams.swift
//  MovieChallange
//
//  Created by Ulaş Sancak on 15.08.2024.
//

import Foundation

enum PlotLength: String {
    case short
    case full
}

struct OMDbDetailParams {
    var id: String
    var plot: PlotLength
    
    init(id: String, plot: PlotLength = .full) {
        self.id = id
        self.plot = plot
    }
}

extension OMDbDetailParams: ConvertableToDictionary {
    var toDictionary: [String : Any] {
        [
            "i": id,
            "plot": plot.rawValue,
        ]
    }
}
