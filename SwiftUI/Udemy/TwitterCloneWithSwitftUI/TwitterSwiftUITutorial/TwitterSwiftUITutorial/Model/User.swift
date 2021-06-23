//
//  User.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/23.
//

import Firebase
import FirebaseAuth

struct User: Identifiable {
    let id: String
    let username: String
    let profileImageUrl: String
    let fullname: String
    let email: String
    var isCurrnetUser: Bool { Auth.auth().currentUser?.uid == self.id }
    
    init(dictionary: [String: Any]) {
        self.id                 = dictionary["uid"]             as? String ?? ""
        self.username           = dictionary["username"]        as? String ?? ""
        self.profileImageUrl    = dictionary["profileImageUrl"] as? String ?? ""
        self.email              = dictionary["email"]           as? String ?? ""
        self.fullname           = dictionary["fullname"]        as? String ?? ""
    }
}

/*
 email
 "Batman@gmail.com"
 fullname
 "Bruce Waune"
 profileImageUrl
 "https://firebasestorage.googleapis.com:443/v0/b/swiftuitwitterclone-2772d.appspot.com/o/C070FA79-828E-4778-9E45-658E93105F5A?alt=media&token=782c0edb-4d72-4b0d-951a-22fa9d1d6659"
 uid
 "eKnoqmsqXXNI510PmBwgJv8LHZl1"
 username
 "batman"
 */
