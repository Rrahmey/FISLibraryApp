//
//  BookDetailViewController.swift
//  LibraryApp
//
//  Created by Raquel Rahmey on 3/15/17.
//  Copyright © 2017 Raquel Rahmey. All rights reserved.
//

import UIKit
import Alamofire

class BookDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publisherDetails: UILabel!
    @IBOutlet weak var navigator: UINavigationItem!
    @IBOutlet weak var checkoutButton: UIButton!
    
    var bookDetails: Book!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigator.title = bookDetails.title
        setUpLabels()
    }

    @IBAction func doneButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func checkOutBook(_ sender: Any) {
        checkoutAlert()
    }

   

}

extension BookDetailViewController {
    func setUpLabels() {
        titleLabel.text = bookDetails.title
        authorLabel.text = "By: \(bookDetails.author)"
        publisherDetails.text = "Publisher: \(bookDetails.publisher)"
    }
    
    func buttonSetup() {
        checkoutButton.layer.borderColor = UIColor.black.cgColor
        checkoutButton.layer.borderWidth = 5
        checkoutButton.layer.cornerRadius = 1 
        
    }
    
    func checkoutAlert() {
        let checkOutAlert = UIAlertController(title: "Please Enter Name ⬇️ to Checkout 📘", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok 👍🏼", style: .default, handler: { textfield in
            guard let name = checkOutAlert.textFields?[0].text else {return}
            self.checkOutBookFromLibrary(name: name)
        self.dismiss(animated: true, completion: nil)})
        let cancelAction = UIAlertAction(title: "Cancel 👎🏼", style: .cancel, handler: nil)
       checkOutAlert.addTextField { (textfield) in
        textfield.placeholder = "Enter Name Here"
        }
        checkOutAlert.addAction(okAction)
        checkOutAlert.addAction(cancelAction)
        
        present(checkOutAlert, animated: true, completion: nil)
    }
    
    func getCurrentDate() -> String {
        let currentTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        return formatter.string(from: currentTime)
    }
    
    func checkOutBookFromLibrary (name: String) {
        let currentTime = getCurrentDate()
        let parameters: [String:Any] = ["lastcheckedoutby": "\(name) at \(currentTime)", "lastcheckedout" : true]
        Alamofire.request("\(libraryURL)/\(bookDetails.id)", method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate().responseData { (dataresponse) in
            guard let statusCode = dataresponse.response?.statusCode else {return}
            if statusCode == 200 {
                print("YASSS")
            } else {
                print("oh no")
            }
        }
        
        
        
    }
    
}
