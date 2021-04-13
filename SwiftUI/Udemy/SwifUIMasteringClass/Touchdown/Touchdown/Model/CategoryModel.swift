//
//  CategoryModel.swift
//  Touchdown
//
//  Created by 김광수 on 2021/04/13.
//

import Foundation

struct Category: Codable, Identifiable {
    let id: Int
    let name: String
    let image: String
}
/*
 {
   "id" : 1,
   "name" : "Helmet",
   "image" : "icon-helmet"
 },
 */
