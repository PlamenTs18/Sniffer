//
//  ManageProfileView.swift
//  Sniffer
//
//  Created by Plamen on 1.03.23.
//

import SwiftUI
import Firebase

struct ManageProfileView: View {
    
    @EnvironmentObject var obs: FirebaseObserver
    @Environment(\.presentationMode) var presentationMode
    @State private var showInfo = false
    @Binding var currentProfile: user1?
    
    var body: some View {
        VStack{
            Spacer()
            Spacer()
            Button{
                self.showInfo.toggle()
            }label:{
                HStack{
                    Spacer()
                    Text("Edit Profile Info")
                        .foregroundColor(.black)
                        .padding(.vertical, 10)
                        .font(.system(size: 15, weight: .semibold))
                    Spacer()
                }.background(Color.gray)
            }.cornerRadius(10)
                .padding()
            Spacer()
            Button{
                obs.logOut()
                presentationMode.wrappedValue.dismiss()
            }label:{
                HStack{
                    Spacer()
                    Text("Log Out")
                        .foregroundColor(.black)
                        .padding(.vertical, 10)
                        .font(.system(size: 15, weight: .semibold))
                    Spacer()
                }.background(Color.gray)
            }.cornerRadius(10)
                .padding()
            Spacer()
            Spacer()
        }
        .background(Color(.sRGB, red: 0.7, green: 0.7, blue: 0.6).edgesIgnoringSafeArea(.all))
        .sheet(isPresented: $showInfo) {
            InputInfoView(currentProfile: $currentProfile)
        }
    }
}

