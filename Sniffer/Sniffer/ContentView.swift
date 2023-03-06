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
    @State private var showManage = false
    @State var refresh: Bool = false

    @State private var showLogIn = false {
        didSet {
            // TODO: Need to remove this and use FirebaseObserver'property userLoggedIn (@Pubished)
            if showLogIn == false {
                obs.getUsers()
            }
        }
    }
    
    @State var currentUser: user1?
    @State var currentProfile: user1?
    @State var userUID = Auth.auth().currentUser?.uid
    
    func refr() {
        refresh.toggle()
    }
    
    init() {}
    
    
    
    var body: some View {
        
        ZStack {
            Color(.sRGB, red: 0.7, green: 0.7, blue: 0.6).edgesIgnoringSafeArea(.all)
            if obs.users.isEmpty {
                Loader()
            }
            if(showLogIn == false){
            VStack {
                
                TopView(show: $showLiked, show2: $showManage)
                
                Spacer()
                
                MainView(currentUser: $currentUser, currentProfile: $currentProfile)
                
                Spacer()
            }
            } else {
                LogSignView(showLogIn: $showLogIn)
                //refr()
            }
        }
        .onAppear(perform: {
            showLogIn = Auth.auth().currentUser == nil
        })
        .onReceive(obs.$users ,perform: { users in
            guard users.isEmpty == false else {
                return
            }
            
            guard let currentProfile = users.first(where: { user in
                user.owner == userUID
            }) else {
                return
            }
            self.currentProfile = currentProfile
            
            self.currentUser = users.first { user in
                guard user.owner != currentProfile.owner else {
                    return false
                }
                guard currentProfile.liked.contains(user.id) == false else {
                    return false
                }
                guard currentProfile.disliked.contains(user.id) == false else {
                    return false
                }
                return true
            }
        })
        .sheet(isPresented: $showLiked) {
            LikedPeople(currentProfile: $currentProfile)
        }
        .sheet(isPresented: $showManage) {
            ManageProfileView(showLogIn: $showLogIn)
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//       // ContentView()
//    }
//}
