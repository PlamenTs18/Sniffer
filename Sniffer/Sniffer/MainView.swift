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
    @Binding var currentUser: user1
    @State var refresh: Bool = false
    
    func refr(){
        refresh.toggle()
    }
    
    var body : some View {
        VStack {
            ZStack {
                    SwipeDetailsView(name: currentUser.name, breed: currentUser.breed, image: currentUser.image, height: 500)
                }
            HStack{
                
                Spacer()
                
                Button(action: {
                    currentUser.status = "dislike"
                    self.obs.updateDB(id: currentUser, status: currentUser.status) {
                        guard let nextUser = self.obs.users.first(where: { user in
                            user.status == ""
                        })else {return}
                        
                        self.currentUser = nextUser
                        refr()
                    }
                }) {
                    Image(systemName: "xmark.circle").resizable().frame(width: 30, height: 30).padding()
                }.foregroundColor(.pink)
                    .background(Color.white)
                    .shadow(radius: 25)
                    .clipShape(Circle())
                
                Spacer()
                
                Button(action: {
                    currentUser.status = "liked"
                    self.obs.updateDB(id: currentUser, status: currentUser.status){
                        guard let nextUser = self.obs.users.first(where: { user in
                            user.status == ""
                        })else {return}
                        
                        self.currentUser = nextUser
                        refr()
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
//        MainView()
//    }
//}
