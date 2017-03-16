//
//  AddBookViewController.swift
//  LibraryApp
//
//  Created by Raquel Rahmey on 3/14/17.
//  Copyright © 2017 Raquel Rahmey. All rights reserved.
//

import UIKit
import Alamofire

class AddBookViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var addTitleText: UITextField!
    @IBOutlet weak var addAuthorText: UITextField!
    @IBOutlet weak var addPublisherText: UITextField!
    @IBOutlet weak var addURLText: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    
    var titleCheck = false
    var authorCheck = false
    var publisherCheck = false
    var bookURLCheck = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addURLText.delegate = self
        addTitleText.delegate = self
        addAuthorText.delegate = self
        addPublisherText.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpBools()
        submitButton.layer.cornerRadius = 1 
    }
   
    
    @IBAction func submitButton(_ sender: Any) {
        checkTextFields()
        if checkTextFields() == false {
            showAlert()
        } else {
            guard let author = addAuthorText.text else {return}
            guard let title = addTitleText.text else {return}
            guard let publisher = addAuthorText.text else {return}
            guard let url = addURLText.text else {return}
            addBook(author: author, publisher: publisher, title: title, url: url, completion: { (worked) in
                if worked {
                    self.showAddBookAlert()
                } else {
                    print("fuck my fucking life")
                }
            })
        }
        
    }

    @IBAction func doneButton(_ sender: Any) {
        doneAlert()
    }
    
    func addBook (author: String, publisher: String, title: String, url: String, completion: @escaping (Bool) -> ()) {
        let parameters = ["author" : "\(author)", "publisher": "\(publisher)", "title": "\(publisher)", "url": "\(url)"]
        Alamofire.request(libraryURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate().responseJSON { (dataResponse) in
            guard let statusCode = dataResponse.response?.statusCode else {return}
            if statusCode == 200 || statusCode == 204 {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}


extension AddBookViewController {
    func checkTextFields() -> Bool {
        if addTitleText.text?.isEmpty != true {
            titleCheck = true
        }
        if addAuthorText.text?.isEmpty != true {
            authorCheck = true
        }
        if addPublisherText.text?.isEmpty != true {
            publisherCheck = true
        }
        if addURLText.text?.isEmpty != true {
            bookURLCheck = true
        }
        if titleCheck && authorCheck && publisherCheck && bookURLCheck {
            return true
        } else {
            return false
        }
    }
    
    
    func setUpBools () {
        titleCheck = false
        authorCheck = false
        publisherCheck = false
        bookURLCheck = false
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "❌ERROR❌", message: "Please fill out all fields to add a book 📕", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showAddBookAlert() {
        let alert = UIAlertController(title: "🎉Congratulations!🎉", message: "You have successfully added a new book to the library!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        present(alert, animated: true) {
        }
    }
    func doneAlert() {
        let alert = UIAlertController(title: "🗣Attention🗣", message: "Are 👏🏼 you 👏🏼 sure 👏🏼 you 👏🏼 want 👏🏼 to 👏🏼 exit? Your 👏🏼 information 👏🏼 will 👏🏼 not 👏🏼 be 👏🏼 saved!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true) {
        }
    }
}



