//
//  LibraryDataStore.swift
//  LibraryApp
//
//  Created by Raquel Rahmey on 3/14/17.
//  Copyright © 2017 Raquel Rahmey. All rights reserved.
//

import Foundation

final class LibraryDataStore {
    static let sharedInstance = LibraryDataStore()
    private init () {}
    
    var allLibraryBooks = [Book]()
    
    func getBooks (with completion: @escaping () -> ()) {
        LibraryAPIClient.getLibrary { (libraryApi) in
            self.allLibraryBooks.removeAll()
            for eachBook in libraryApi {
                let books = Book.init(dictionary: eachBook)
                self.allLibraryBooks.append(books)
            }
            completion()
        }
        
        
        
    }
}
