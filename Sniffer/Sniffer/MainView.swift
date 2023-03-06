//
//  mainView.swift
//  Sniffer
//
//  Created by Plamen on 16.01.23.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase


struct MainView: View {
    
    @EnvironmentObject var obs: FirebaseObserver
    @Binding var currentUser: user1?
    @Binding var currentProfile: user1?
    @State var refresh: Bool = false
    
    func refr(){
        refresh.toggle()
    }
    
    var body : some View {
        VStack {
            ZStack {
                if let currentUser = currentUser {
                    SwipeDetailsView(currentUser: currentUser, height: 500)
                } else {
                    EmptyView()
                }
                
            }
            
            Spacer()
            
            HStack{
                
                Spacer()
                
                Button(action: {
                    if let currentUser = currentUser {
                        currentProfile?.disliked.append(currentUser.id)
                        obs.updateDB(currentProfile:currentProfile!, likedUser: currentUser.id, action: "dislike")
                    }
                    refr()
                }) {
                    Image(systemName: "xmark.circle").resizable().frame(width: 30, height: 30).padding()
                }.foregroundColor(.pink)
                    .background(Color.white)
                    .shadow(radius: 25)
                    .clipShape(Circle())
                
                Spacer()
                
                Button(action: {
                    if let currentUser = currentUser {
                        currentProfile?.liked.append(currentUser.id)
                        obs.updateDB(currentProfile:currentProfile!, likedUser: currentUser.id, action: "like")
                    }
                    refr()
                }) {
                    Image(systemName: "heart").resizable().frame(width: 35, height: 35).padding()
                }.foregroundColor(.blue)
                    .background(Color.white)
                    .shadow(radius: 25)
                    .clipShape(Circle())
                
                Spacer()
                
            }
        }
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
