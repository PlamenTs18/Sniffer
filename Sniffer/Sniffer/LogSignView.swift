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
                    
                    Button{
                        
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
                    
                    Text(self.loginStatusMessage)
                    
                }
                .padding()
            }
            .navigationTitle(isLoginMode ? "Log In": "Create Account")
            .background(Color(.sRGB, red: 0.7, green: 0.7, blue: 0.6).edgesIgnoringSafeArea(.all))
        }
    }
    
    private func handleAction(){
        if isLoginMode{
            loginUser()
        }else{
            createAcc()
        }
    }
    
    private func loginUser(){
        Auth.auth().signIn(withEmail: email, password: password){ result, err in
            if let err = err {
                print("Failed", err)
                self.loginStatusMessage = "Failed Login: \(err)"
                return
            }
            print("Success")
        }
    }
    
    @State var loginStatusMessage = ""
    
    private func createAcc(){
        Auth.auth().createUser(withEmail: email, password: password){ result, err in
            if let err = err {
                print("Failed", err)
                self.loginStatusMessage = "Failed to create: \(err)"
                return
            }
            print("Success")
        }
    }
    
}

struct LogSignView_Previews: PreviewProvider {
    static var previews: some View {
        LogSignView()
    }
}
