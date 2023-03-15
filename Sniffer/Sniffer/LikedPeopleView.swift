//
//  likedPeople.swift
//  Sniffer
//
//  Created by Plamen on 17.01.23.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase



struct LikedPeopleView: View {
    @EnvironmentObject var obs: FirebaseObserver
    @Binding var currentProfile: user1?
    
    var likedPeople: [user2] {
        var people = [user2]()
        
        
        
        for i in obs.users {
            if(currentProfile!.liked.contains(i.id)){                people.append(user2(id: i.id, name: i.name, email: i.email, image: i.image))
            }
        }
        return people
    }
    
    var body: some View {
        VStack{
            if currentProfile!.liked.isEmpty{
                Text("No Liked Dogs")
            }
            else{
                NavigationView {
                    List {
                        ForEach(likedPeople, id: \.id) { i in
                            NavigationLink(destination : Details(userItem: i)) {cards(name: i.name, image: i.image)
                            }
                        }
                    }.navigationBarTitle("Liked Users")
                }
            }
        }
    }
}

struct cards : View {
    
    var name = ""
    var image = ""
    var email = ""
    var body : some View{
        
        HStack{
            AnimatedImage(url: URL(string: image)!).resizable().frame(width: 65, height: 65).clipShape(Circle())
            Text(name).fontWeight(.heavy)
        }
    }
}

