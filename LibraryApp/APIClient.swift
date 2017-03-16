//
//  APIClient.swift
//  LibraryApp
//
//  Created by Raquel Rahmey on 3/14/17.
//  Copyright © 2017 Raquel Rahmey. All rights reserved.
//

import Foundation
import Alamofire

 let libraryURL = "https://flatironchallenge.herokuapp.com/books"


class LibraryAPIClient {
    
    class func getLibrary (completion: @escaping ([[String:Any]])-> ()) {
        Alamofire.request(libraryURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseJSON { (dataResponse) in
            guard let JSON = dataResponse.result.value as? [[String:Any]] else { [[:]]; return}
            completion(JSON)
        }
    }
    
    
}
