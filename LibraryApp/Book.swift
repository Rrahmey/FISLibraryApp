//
//  Book.swift
//  LibraryApp
//
//  Created by Raquel Rahmey on 3/14/17.
//  Copyright © 2017 Raquel Rahmey. All rights reserved.
//

import Foundation

class Book {
    
    var author: String
    var id: Int
    var lastcheckedout: Bool
    var lastcheckedoutby: String
    var publisher: String
    var title: String
    var url: String
    
    init (dictionary: [String:Any]) {
        author = dictionary["author"] as? String ?? "No author available"
        id = dictionary["id"] as? Int ?? 99999
        lastcheckedout = dictionary["lastcheckout"] as? Bool ?? false
        lastcheckedoutby = dictionary["lastcheckedoutby"] as? String ?? "The book is has not been checked out"
        publisher = dictionary["publisher"] as? String ?? "No publisher"
        title = dictionary["title"] as? String ?? "No title"
        url = dictionary["url"] as? String ?? "no url available"
    }
}
