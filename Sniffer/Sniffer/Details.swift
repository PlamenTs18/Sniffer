//
//  Details.swift
//  Sniffer
//
//  Created by Plamen on 16.01.23.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI
 
struct Details: View {
      
    let userItem : user2
    var body: some View {
        GeometryReader{geo in
            VStack {
                Text("Username : \(userItem.name)")
                    .font(.title2)
                   
                AnimatedImage(url: URL(string: userItem.image))
                    .resizable().frame(height: geo.size.height - 100)
                    .padding(.horizontal, 15)
                    .cornerRadius(20)
            }
        }
    }
}
