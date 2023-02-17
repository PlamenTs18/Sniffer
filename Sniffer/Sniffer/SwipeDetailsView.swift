//
//  SwipeDetailsView.swift
//  Sniffer
//
//  Created by Plamen on 17.01.23.
//

import SwiftUI
import SDWebImageSwiftUI
 
struct SwipeDetailsView: View {
     
    var name: String
    var breed: String
    var image: String
    var height: CGFloat
    
    @EnvironmentObject var obs: FirebaseObserver
    
    var body: some View {
        ZStack {
            AnimatedImage(url: URL(string: image)!).resizable().cornerRadius(20).padding(.horizontal, 15)
             
            VStack {
                 
                Spacer()
                 
                HStack {
                    VStack(alignment: .leading, content: {
                        Text(name).fontWeight(.heavy).font(.system(size: 25)).foregroundColor(.black)
                        Text(breed).foregroundColor(.black)
                    })
                    Spacer()
                }
            }.padding([.bottom, .leading], 35)
             
        }.frame(height:height)
    }
}
 
struct SwipeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeDetailsView(name: "rkfne", breed: "rfef", image: "https://cdn.pixabay.com/photo/2017/02/20/18/03/cat-2083492_1280.jpg", height: 100)
        
    }
}
