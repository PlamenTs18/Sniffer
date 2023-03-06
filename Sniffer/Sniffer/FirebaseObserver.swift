//
//  observer.swift
//  Sniffer
//
//  Created by Plamen on 15.01.23.
//

import Foundation
import SwiftUI
import Firebase


class FirebaseObserver: ObservableObject {
    
    let db = Firestore.firestore()
    // @Published userLoggedIn: Bool
    @Published var users = [user1]()
    @Published var last = -1
    
    // TODO: Add login logic here
    // func login
    // func createUser (email, pass, ....)
    // func logout
    
    
    
    func getUsers() {
        db.collection("users").getDocuments { (snap, err) in
            if err != nil{
                
                print((err?.localizedDescription)!)
                return
            }
            
            var usersArray = [user1]()
            for i in snap!.documents {
                let name = i.get("name") as! String
                let breed = i.get("breed") as! String
                let image = i.get("image") as! String
                let id = i.documentID
                let owner = i.get("owner") as! String
                let liked = i.get("liked") as! [String]
                let disliked = i.get("disliked") as! [String]
                
                usersArray.append(user1(id: id, name: name, image: image, breed: breed, swipe: 0, degree: 0, owner: owner, disliked: disliked, liked: liked))
            }
            
            self.users = usersArray
        }
    }
    
    func update(id : user1,value : CGFloat,degree : Double){
        print("update \(id.id)")
        for i in 0..<self.users.count{
            
            if self.users[i].id == id.id{
                
                self.users[i].swipe = value
                self.users[i].degree = degree
                self.last = i
            }
        }
    }
    
    
    func updateDB(currentProfile : user1, likedUser : String, action: String){
        let documentReference = db.collection("users").document(currentProfile.id)
        if(action == "like"){
            documentReference.updateData(["liked": FieldValue.arrayUnion([likedUser])
        ])
        }else{
            documentReference.updateData(["disliked": FieldValue.arrayUnion([likedUser])
        ])
        }
        
        getUsers()
    }}
