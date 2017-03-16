//
//  ViewController.swift
//  LibraryApp
//
//  Created by Raquel Rahmey on 3/14/17.
//  Copyright © 2017 Raquel Rahmey. All rights reserved.
//

import UIKit


class BooksTableViewController: UITableViewController {

    let library = LibraryDataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        library.getBooks {
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return library.allLibraryBooks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "libraryBooks", for: indexPath)
        let libraryBookCell = library.allLibraryBooks[indexPath.row]
        cell.textLabel?.text = libraryBookCell.title
        cell.detailTextLabel?.text = "By: \(libraryBookCell.author)"
        return cell 
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addBook" {
            let destination = segue.destination as! AddBookViewController
        } else if segue.identifier == "detailSegue" {
            if let destination = segue.destination as? BookDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow {
                let bookArray = library.allLibraryBooks
                destination.bookDetails = bookArray[indexPath.row]
            }
        }
    }
    
}

