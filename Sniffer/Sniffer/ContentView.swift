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
    @State var currentUser: user1?
    @State var currentProfile: user1?
    
    func refr() {
        refresh.toggle()
    }
    
    init() {
    }
    
    var body: some View {
        ZStack {
            Color(.sRGB, red: 0.7, green: 0.7, blue: 0.6).edgesIgnoringSafeArea(.all)
            if obs.users.isEmpty {
                Loader()
            }
            if(obs.isLoggedIn) {
                VStack {
                    
                    TopView(show: $showLiked, show2: $showManage)
                    
                    Spacer()
                    
                    MainView(currentUser: $currentUser, currentProfile: $currentProfile)
                    
                    Spacer()
                }
            } else {
                LogSignView()
            }
        }
        .onAppear(perform: {
            obs.isLoggedIn = Auth.auth().currentUser != nil
        })
        .onReceive(obs.$isLoggedIn, perform: { isLoggedIn in
            if isLoggedIn {
                obs.getUsers()
            }
        })
        .onReceive(obs.$users ,perform: { users in
            guard users.isEmpty == false else {
                return
            }
            
            guard let currentProfile = users.first(where: { user in
                user.owner == obs.authUID
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
            LikedPeopleView(currentProfile: $currentProfile)
        }
        .sheet(isPresented: $showManage) {
            ManageProfileView(currentProfile: $currentProfile)
        }
    }
}
