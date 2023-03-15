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
    @State var Ulocation = ""
    
    @Binding var currentProfile: user1?
    
    var body: some View {
        VStack{
            Spacer()
            Group{
                TextField("Name", text: $Uname)
                TextField("Breed", text: $Ubreed)
                TextField("Image (has to be an URL ending in .jpg, .png, etc.)", text: $Uimage)
                TextField("Locatiob (ex: Sofia, Plovdiv, etc.)", text: $Ulocation)
                
            }
            .padding(15)
            .background(Color.white)
            .cornerRadius(10)
            
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
                if(Ulocation != ""){
                    obs.changeInfo(profId: currentProfile!.id, newValue: Ulocation, typeInfo: "location")
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
