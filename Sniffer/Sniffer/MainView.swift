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
    @Binding var currentUser: user1
    @Binding var currentProfile: user1
    @Binding var userUID: String?
    @State var refresh: Bool = false
    
    
    func nextCurr(){
        
        for nextCurr in obs.users {
            if !currentProfile.liked.contains(nextCurr.id) && !currentProfile.disliked.contains(nextCurr.id) {
                currentUser = nextCurr
            }
                break
            }
    }

        
    func refr(){
        refresh.toggle()
    }
    
    
    var body : some View {
        VStack {
            ZStack {
                    SwipeDetailsView(name: currentUser.name, breed: currentUser.breed, image: currentUser.image, height: 500)
                }
            .onAppear{
                nextCurr()
            }
            
            Spacer()
            
            HStack{
                
                Spacer()
                
                Button(action: {
                    
                        nextCurr()
                        refr()
                }) {
                    Image(systemName: "xmark.circle").resizable().frame(width: 30, height: 30).padding()
                }.foregroundColor(.pink)
                    .background(Color.white)
                    .shadow(radius: 25)
                    .clipShape(Circle())
                
                Spacer()
                
                Button(action: {
                    
                        nextCurr()

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
