//
//  SnifferApp.swift
//  Sniffer
//
//  Created by Plamen on 15.01.23.
//

import SwiftUI

import Firebase


@main
struct DevSwiftUIApp: App {

   @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var obs = FirebaseObserver()
   var body: some Scene {
       WindowGroup {
           ContentView()
               .environmentObject(obs)
       }
   }
}

class AppDelegate: NSObject,UIApplicationDelegate{
    
   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
       FirebaseApp.configure()
       return true
   }
}

