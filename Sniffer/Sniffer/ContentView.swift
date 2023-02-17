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
    
    @EnvironmentObject var obs: FirebaseObserver
    @State private var showLiked = false
    @State private var currentUser: user1?
    
    var body: some View {
        ZStack {
            Color(.sRGB, red: 0.7, green: 0.7, blue: 0.6).edgesIgnoringSafeArea(.all)
            if obs.users.isEmpty {
                Loader()
            }
            VStack {
                TopView(show: $showLiked)
                MainView(currentUser: $currentUser)
            }
        }
        .onReceive(obs.$users ,perform: { users in
            print(users)
            guard users.isEmpty == false else {
                return
            }
            guard let currentUser = users.first(where: { user in
                user.status == ""
            }) else {
                return
            }
            self.currentUser = currentUser
        })
        .sheet(isPresented: $showLiked) {
            LikedPeople()
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//       // ContentView()
//    }
//}
