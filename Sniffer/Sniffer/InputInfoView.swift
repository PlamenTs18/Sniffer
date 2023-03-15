//
//  InputInfoView.swift
//  Sniffer
//
//  Created by Plamen on 14.03.23.
//

import SwiftUI
import Firebase

struct InputInfoView: View {
    
    @EnvironmentObject var obs: FirebaseObserver
    @Environment(\.presentationMode) var presentationMode
    @State var Uname = ""
    @State var Ubreed = ""
    @State var Uimage = ""
    @Binding var currentProfile: user1?
    
    var body: some View {
        VStack{
            Spacer()
            Group{
                TextField("Name", text: $Uname)
                TextField("Breed", text: $Ubreed)
                TextField("Image", text: $Uimage)
            }
            .background(Color.white)
            .cornerRadius(10)
            .padding(10)
            
            Spacer()
            Button{
                if(Uname != ""){
                    obs.changeInfo(profId: currentProfile!.id, newValue: Uname, typeInfo: "name")
                }
                if(Ubreed != ""){
                    obs.changeInfo(profId: currentProfile!.id, newValue: Ubreed, typeInfo: "breed")
                }
                if(Uimage != ""){
                    obs.changeInfo(profId: currentProfile!.id, newValue: Uimage, typeInfo: "image")
                }
                obs.getUsers()
            } label:{
                HStack{
                    Spacer()
                    Text("Edit Info")
                        .foregroundColor(.black)
                        .padding(.vertical, 10)
                        .font(.system(size: 15, weight: .semibold))
                    Spacer()
                }.background(Color.gray)
            }.cornerRadius(10)
            Spacer()
        }
        .background(Color(.sRGB, red: 0.7, green: 0.7, blue: 0.6).edgesIgnoringSafeArea(.all))
    }
}
