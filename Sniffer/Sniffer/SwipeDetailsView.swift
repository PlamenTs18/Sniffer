//
//  SwipeDetailsView.swift
//  Sniffer
//
//  Created by Plamen on 17.01.23.
//

import SwiftUI
import SDWebImageSwiftUI
 
struct SwipeDetailsView: View {
     
    var name = ""
    var breed = ""
    var image = ""
    var height : CGFloat = 0
    var body: some View {
        ZStack {
            AnimatedImage(url: URL(string: image)!).resizable().cornerRadius(20).padding(.horizontal, 15)
             
            VStack {
                 
                Spacer()
                 
                HStack {
                    VStack(alignment: .leading, content: {
                        Text(name).fontWeight(.heavy).font(.system(size: 25)).foregroundColor(.white)
                        Text(breed).foregroundColor(.white)
                    })
                    Spacer()
                }
            }.padding([.bottom, .leading], 35)
             
        }.frame(height:height)
    }
}
 
struct SwipeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeDetailsView()
    }
}
