//
//  mainView.swift
//  Sniffer
//
//  Created by Plamen on 16.01.23.
//

import SwiftUI
import SDWebImageSwiftUI

struct MainView: View {
    
    @EnvironmentObject var obs: FirebaseObserver
    @Binding var currentUser: user1?
    
    var body : some View {
        VStack {
            ZStack {
                if let currentUser = currentUser {
                    SwipeDetailsView(name: currentUser.name, breed: currentUser.breed, image: currentUser.image, height: 100)
                } else {
                    EmptyView()
                }
                    
                
            }
            HStack{
                
                Spacer()
                
                Button(action: {
                    if self.obs.last == -1{
                        self.obs.updateDB(id: self.obs.users[self.obs.users.count - 1], status: "dislike")
                    }
                    else{
                        self.obs.updateDB(id: self.obs.users[self.obs.last], status: "dislike")
                    }
                }) {
                    Image(systemName: "xmark.circle").resizable().frame(width: 30, height: 30).padding()
                }.foregroundColor(.pink)
                    .background(Color.white)
                    .shadow(radius: 25)
                    .clipShape(Circle())
                
                Spacer()
                
                Button(action: {
                    if self.obs.last == -1{
                        self.obs.updateDB(id: self.obs.users[self.obs.users.count - 1], status: "liked")
                    }
                    else{
                        self.obs.updateDB(id: self.obs.users[self.obs.last], status: "liked")
                    }
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
//       MainView()
//    }
//}
