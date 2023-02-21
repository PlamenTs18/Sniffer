//
//  LogSignView.swift
//  Sniffer
//
//  Created by Plamen on 17.02.23.
//

import SwiftUI
import Firebase

struct LogSignView: View {
    
    @State var isLoginMode = false
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing: 15){
                    Picker(selection: $isLoginMode, label: Text("Picker")){
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
                    }
                    .padding(15)
                    .background(Color.white)
                    .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle(isLoginMode ? "Log In": "Create Account")
            .background(Color(.sRGB, red: 0.7, green: 0.7, blue: 0.6).edgesIgnoringSafeArea(.all))
        }
    }
}

struct LogSignView_Previews: PreviewProvider {
    static var previews: some View {
        LogSignView()
    }
}
