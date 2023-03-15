//
//  TopView.swift
//  Sniffer
//
//  Created by Plamen on 15.01.23.
//

import SwiftUI

struct TopView: View {
    
    @Binding var show: Bool
    @Binding var show2: Bool
    
    var body: some View {
        HStack(alignment: .top) {
            Button(action: {
                self.show2.toggle()
            }) {
                Image("prof").resizable().frame(width: 35, height: 35)
            }.cornerRadius(20)
            
            Spacer()
            
            Image("logo")
                .resizable()
                .frame(width: 30, height: 35)
            
            Spacer()
            
            Button(action: {
                self.show.toggle()
            }) {
                Image(systemName: "message").resizable().frame(width: 35, height: 35)
            }
        }.padding()
    }
}
