//
//  Constants.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/23.
//

import Firebase

let COLLECTION_USERS = Firestore.firestore().collection("users")
let COLLECTION_FOLLOWERS = Firestore.firestore().collection("followers")
let COLLECTION_FOLLOWING = Firestore.firestore().collection("following")
let COLLECTION_TWEETS = Firestore.firestore().collection("tweets")
let COLLECTION_MESSAGE = Firestore.firestore().collection("message")
