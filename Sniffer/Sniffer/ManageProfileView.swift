//
//  ManageProfileView.swift
//  Sniffer
//
//  Created by Plamen on 1.03.23.
//

import SwiftUI
import Firebase

struct ManageProfileView: View {
    
    @Binding var showLogIn: Bool
    
    private func LogOut(){
        do {
                    try Auth.auth().signOut()
                } catch let signOutError as NSError {
                    print("Error signing out: \(signOutError)")
                }
    }
    
    var body: some View {
        
        
        Button{
            LogOut()
            showLogIn = true
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
    }
}

//struct ManageProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ManageProfileView($showLogIn)
//    }
//}
