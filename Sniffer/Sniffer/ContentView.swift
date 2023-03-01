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
    @State private var ShowManage = false
    @State private var showLogIn = false {
        didSet {
            // TODO: Need to remove this and use FirebaseObserver'property userLoggedIn (@Pubished)
            if showLogIn == false {
                obs.getUsers()
            }
        }
    }
    
    @State var currentUser: user1
    
    init(){
        currentUser = user1(id: "ifhio", name: "", image: "https://www.google.com/search?q=ichigo&rlz=1C5CHFA_enBG1035BG1035&sxsrf=AJOqlzUs_iTHNoYdXSQHJbj295SXuP-zWg:1677012067952&source=lnms&tbm=isch&sa=X&ved=2ahUKEwieoeDkvKf9AhW7R_EDHQbdBzQQ_AUoAXoECAEQAw&biw=1200&bih=580&dpr=2#imgrc=wFOVaaqCssZMfM", breed: "", swipe: 2, degree: 2, owner: "")
    }
    
    var body: some View {

        ZStack {
            Color(.sRGB, red: 0.7, green: 0.7, blue: 0.6).edgesIgnoringSafeArea(.all)
            if obs.users.isEmpty {
                Loader()
            }
            VStack {
                
                TopView(show: $showLiked, show2: $showManage)
                
                Spacer()
                
                MainView(currentUser: $currentUser)
                
                Spacer()
            }
        }
        .onAppear(perform: {
            showLogIn = Auth.auth().currentUser == nil
        })
        .onReceive(obs.$users ,perform: { users in
            guard users.isEmpty == false else {
                return
            }
            guard let currentUser = users.first(where: { user in
                user.owner == ""
            }) else {
                return
            }
            self.currentUser = currentUser
        })
        .sheet(isPresented: $showLiked) {
            LikedPeople()
        }
        .sheet(isPresented: $showLiked) {
            ManageProfileView()
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//       // ContentView()
//    }
//}
