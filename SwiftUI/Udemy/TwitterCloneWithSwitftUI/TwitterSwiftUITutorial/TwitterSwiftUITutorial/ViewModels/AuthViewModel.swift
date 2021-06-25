//
//  AppAuthModel.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/23.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    // MARK: - Properties
    @Published var userSession: FirebaseAuth.User?
    @Published var isAuthenticating = false
    @Published var error: Error?
    @Published var user: User?
    
    static let shared = AuthViewModel()
    
    
    // MARK: - init
    private init() {
        userSession = Auth.auth().currentUser
        fetchUser()
    }

    // MARK: - Login
    func login(withEmail: String, password: String) {
        
        Auth.auth().signIn(withEmail: withEmail, password: password) { result, error in
            
            if let error = error {
                print("DEBUG: Failed to login Error \(error.localizedDescription)")
                return
            }
            
            self.userSession = result?.user
        }
        
    }
    
    // MARK: - Regiter User
    func regiterUser(email: String, password: String, username: String, fullname: String, profileImage: UIImage) {
        
        // Profile Image Save Logic
        guard let imageData = profileImage.jpegData(compressionQuality: 0.1) else { return }
        
        let filename = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child(filename)
        
        storageRef.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("DEBUG: Failed to upload image \(error.localizedDescription)")
                return
            }
            
            storageRef.downloadURL { url, _ in
                guard let profileImageUrl = url?.absoluteString else { return }
                
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    
                    if let error = error {
                        print("DEBUG: Error \(error.localizedDescription)")
                    }
                    
                    guard let user = result?.user else { return }
                    
                    let data = ["email": email,
                                "username": username.lowercased(),
                                "fullname": fullname,
                                "profileImageUrl": profileImageUrl,
                                "uid": user.uid]
                    
                    Firestore.firestore().collection("users").document(user.uid).setData(data) { _ in
                        self.userSession = user
                        self.fetchUser()
                    }
                } // Create User
            } // downloadURL
        } // putData
    } //: registerUser
    
    // MARK: - Sign out
    func signOut() {
        userSession = nil
        user = nil
        try? Auth.auth().signOut()
    }
    
    // MARK: - fetchUser
    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
            guard let data = snapshot?.data() else { return }
            self.user = User(dictionary: data)
        }
    }
    
    // MARK: - Selected NaviBartitle
    func getNaviTitle(forIndex index: Int) -> String {
        switch index {
        case 0:     return "Home"
        case 1:     return "Search"
        case 2:     return "Message"
        default:    return ""
        }
    }
}
