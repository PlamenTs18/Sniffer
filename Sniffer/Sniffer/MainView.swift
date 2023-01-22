//
//  mainView.swift
//  Sniffer
//
//  Created by Plamen on 16.01.23.
//

import SwiftUI
import SDWebImageSwiftUI
 
struct MainView: View {
     
    @ObservedObject var obs = observer()
     
    var body : some View{
        VStack {
            GeometryReader{geo in
                 
                ZStack{
                     
                    ForEach(self.obs.users){i in
 
                        SwipeDetailsView(name: i.name, breed: i.breed, image: i.image, height: geo.size.height - 100).gesture(DragGesture()
                         
                            .onChanged({ (value) in
                                if value.translation.width > 0{
                                    self.obs.update(id: i, value: value.translation.width, degree: 8)
                                }
                                else{
                                    self.obs.update(id: i, value: value.translation.width, degree: -8)
                                }
                            }).onEnded({ (value) in
                                if i.swipe > 0{
                                    if i.swipe > geo.size.width / 2 - 80{
                                        self.obs.update(id: i, value: 500, degree: 0)
                                    }
                                    else{
                                        self.obs.update(id: i, value: 0, degree: 0)
                                    }
                                }
                                else{
                                    if -i.swipe > geo.size.width / 2 - 80{
                                        self.obs.update(id: i, value: -500, degree: 0)
                                    }
                                    else{
                                        self.obs.update(id: i, value: 0, degree: 0)
                                    }
                                }
                            })
                        ).offset(x: i.swipe)
                        .rotationEffect(.init(degrees: i.degree))
                    }
                }
            }
            HStack{
                 
                Spacer()
                
                Button(action: {
                    if self.obs.last == -1{
                        self.obs.updateDB(id: self.obs.users[self.obs.users.count - 1], status: "dislike")
                    }
                    else{
                        self.obs.updateDB(id: self.obs.users[self.obs.last - 1], status: "dislike")
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
                        self.obs.updateDB(id: self.obs.users[self.obs.last - 1], status: "liked")
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
 
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
