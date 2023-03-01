//
//  data.swift
//  Sniffer
//
//  Created by Plamen on 15.01.23.
//

import Foundation
import SwiftUI

struct user1: Identifiable {
    
    var id: String
    var name: String
    var image: String
    var breed: String
    var swipe: CGFloat
    var degree: Double
    var owner: String
    var disliked = [String]()
    var liked = [String]()
}

struct user2: Identifiable {
    var id: String
    var name: String
    var breed: String
    var image: String
}
