//
//  observer.swift
//  Sniffer
//
//  Created by Plamen on 15.01.23.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth


class FirebaseObserver: ObservableObject {
    
    let db = Firestore.firestore()
    let auth = Auth.auth()
    @Published var users = [user1]()
    @Published var last = -1
    @Published var isLoggedIn = false
    @Published var loginStatusMessage: String?
    
    var authUID: String? {
        return auth.currentUser?.uid
    }
    
    
    func loginUser(email: String, password: String) {
        auth.signIn(withEmail: email, password: password){ result, err in
            if let err = err {
                print("Failed", err)
                self.loginStatusMessage = "Failed Login: \(err)"
                return
            }
        }
    }
    
    func createAcc(email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed", err)
                self.loginStatusMessage = "Failed to create: \(err)"
                return
            }
        }
    }
    
    func completeLogSign(){
        sleep(2)
        self.isLoggedIn = true
        print("Success")
    }
    
    func addInfo(email: String, name: String, breed: String, image: String, owner: String, password: String){
        sleep(2)
        loginUser(email: email, password: password)
        var ref: DocumentReference? = nil
        ref = db.collection("users").addDocument(data: [
            "name": name,
            "breed": breed,
            "email": email,
            "image": image,
            "owner": owner,
            "liked": [],
            "disliked": []
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    
    func logOut(){
        do {
            try auth.signOut()
            self.isLoggedIn = false
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError)")
        }
    }
    
    
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
                let email = i.get("email") as! String
                
                usersArray.append(user1(id: id, name: name, image: image, breed: breed, swipe: 0, degree: 0, owner: owner, disliked: disliked, liked: liked, email:email))
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
    }
    
    func changeInfo(profId: String, newValue: String, typeInfo: String){
        let userRef = db.collection("users").document(profId)
        
        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                userRef.updateData([typeInfo: newValue]) { (error) in
                    if let error = error {
                        print("Error updating document: \(error)")
                    } else {
                        print("Document updated")
                    }
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
}
