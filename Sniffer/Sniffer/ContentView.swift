//
//  ContentView.swift
//  Sniffer
//
//  Created by Plamen on 11.01.23.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI
 
struct ContentView: View {
     
    @ObservedObject var obs = observer()
    @State var showLiked = false
     
    var body: some View {
        
        ZStack{
            Color(.sRGB, red: 0.7, green: 0.7, blue:0.6 ).edgesIgnoringSafeArea(.all)
            if obs.users.isEmpty{
                Loader()
            }
             
            VStack{
                TopView(show: $showLiked)
                MainView()
            }
        }
        .sheet(isPresented: $showLiked) {
            LikedPeople()
        }
    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
