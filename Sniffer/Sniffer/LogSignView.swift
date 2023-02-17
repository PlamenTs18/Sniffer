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
