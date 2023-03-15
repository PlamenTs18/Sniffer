//
//  SwipeDetailsView.swift
//  Sniffer
//
//  Created by Plamen on 17.01.23.
//

import SwiftUI
import SDWebImageSwiftUI

struct SwipeDetailsView: View {
    
    var currentUser: user1
    var height: CGFloat
    
    @EnvironmentObject var obs: FirebaseObserver
    
    var body: some View {
        VStack {
            AnimatedImage(url: URL(string: currentUser.image)!).resizable().cornerRadius(20).padding(.horizontal, 15).frame(height: height)
            VStack(alignment: .center, content: {
                Text(currentUser.name).fontWeight(.heavy).font(.system(size: 25)).foregroundColor(.black)
                Text(currentUser.breed).foregroundColor(.black)
            })
            Spacer()
        }
    }
}
