//
//  LogSignView.swift
//  Sniffer
//
//  Created by Plamen on 17.02.23.
//

import SwiftUI
import Firebase

struct LogSignView: View {
    
    @EnvironmentObject var obs: FirebaseObserver
    @State var isLoginMode = false
    @State var email = ""
    @State var Uname = ""
    @State var Ubreed = ""
    @State var Uimage = ""
    @State var Ulocation = ""
    @State var password = ""
    @State var refresh: Bool = false
    @State var view = ""
    @State var loginStatusMessage: String?
    
    func refr(){
        refresh.toggle()
    }
    
    var body: some View {
        if view == "main"{
            ContentView()
        }
        NavigationView {
            ScrollView {
                VStack(spacing: 15) {
                    Picker(selection: $isLoginMode, label: Text("Picker")) {
                        Text("Login")
                            .tag(true)
                        Text("Create Account")
                            .tag(false)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    if !isLoginMode{
                        Button{
                            
                        } label: {
                            Image(systemName: "person.fill")
                                .font(.system(size: 60))
                                .padding()
                        }
                    }
                    
                    Group{
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        SecureField("Password", text: $password)
                        if(isLoginMode == false){
                            TextField("Name", text: $Uname)
                            TextField("Breed", text: $Ubreed)
                            TextField("Image", text: $Uimage)
                            TextField("Location", text: $Ulocation)
                        }
                    }
                    .padding(15)
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    Button{
                        handleAction()
                    }label:{
                        HStack{
                            Spacer()
                            Text(isLoginMode ? "Log In" : "Create Account")
                                .foregroundColor(.black)
                                .padding(.vertical, 10)
                                .font(.system(size: 15, weight: .semibold))
                            Spacer()
                        }.background(Color.gray)
                    }.cornerRadius(10)
                    
                    Text(self.loginStatusMessage ?? "")
                    
                }
                .padding()
            }
            .navigationTitle(isLoginMode ? "Log In": "Create Account")
            .background(Color(.sRGB, red: 0.7, green: 0.7, blue: 0.6).edgesIgnoringSafeArea(.all))
        }
        .onReceive(obs.$loginStatusMessage) { loginStatusMessage in
            self.loginStatusMessage = loginStatusMessage
        }
        
    }
    
    private func handleAction(){
        if isLoginMode {
            obs.loginUser(email: email, password: password)
            obs.completeLogSign()
            refr()
        } else {
            
            obs.createAcc(email: email, password: password){
                obs.addInfo(email: email, name: Uname, breed: Ubreed, image: Uimage, owner: obs.authUID ?? "err", password: password, location: Ulocation){
                    obs.completeLogSign()
                    refr()
                }
            }
        }
    }
}
