//
//  SlowerViewModel.swift
//  Slowerr
//
//  Created by Brandon LeBlanc on 11/27/23.
//

import Foundation

final class SlowerViewModel: ObservableObject {
    private(set) var slower: Slower
    
    init(slower: Slower) {
        self.slower = slower
    }
}

struct Slower {
    let id = UUID()
    let title: String
    let duration: TimeInterval
    let track: String
    let image: String
    
    static let data = Slower(title: "Instrumental", duration: 70, track: "Instrumental", image: "trees")
}
