//
//  likedPeople.swift
//  Sniffer
//
//  Created by Plamen on 17.01.23.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase
 
struct LikedPeople: View {
   
  @ObservedObject var datas = observer1()
  var body: some View {
       
      VStack{
          if datas.data.isEmpty{
              Text("No Liked People")
          }
          else{
              NavigationView {
                  List(datas.data){i in
                      NavigationLink(destination : Details(userItem: i)) {
                          cards(name: i.name, image: i.image)
                      }
                  }.navigationBarTitle("Like Users")
              }
          }
      }
  }
}
 
struct cards : View {
   
  var name = ""
  var image = ""
  var body : some View{
       
      HStack{
          AnimatedImage(url: URL(string: image)!).resizable().frame(width: 65, height: 65).clipShape(Circle())
          Text(name).fontWeight(.heavy)
      }
  }
}
 
class observer1 : ObservableObject{
   
  @Published var data = [user2]()
   
  init() {
       
      let db = Firestore.firestore()
      db.collection("liked").getDocuments { (snap, err) in
           
          if err != nil{
               
              print((err?.localizedDescription)!)
              return
          }
           
          for i in snap!.documents{
               
              let name = i.get("name") as! String
              let breed = i.get("breed") as! String
              let image = i.get("image") as! String
               
              self.data.append(user2(id: UUID().uuidString, name: name, breed: breed, image: image))
          }
      }
  }
}
