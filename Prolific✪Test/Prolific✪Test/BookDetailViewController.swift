//
//  BookDetailViewController.swift
//  Prolific✪Test
//
//  Created by Guang on 5/2/16.
//  Copyright © 2016 Guang. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var lastCheckedOutLabel: UILabel!
    @IBOutlet weak var lastCheckedOutByLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
   
    var book = BookInfomation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        //authorLabel.text = "hello world"
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI() {
        titleLabel.text = book.title ?? "This book has no Title.😜"
        titleLabel.sizeToFit()
        authorLabel.text = book.author ?? "No Authoer😜"
        authorLabel.sizeToFit()
        categoryLabel.text = book.categories ?? "No Tag"
        authorLabel.sizeToFit()
        publisherLabel.text = book.publisher ?? "No Publisher 😜"
        authorLabel.sizeToFit()

        lastCheckedOutByLabel.text = book.lastCheckedOut ?? "No body checked it out yet, be the first one"
        authorLabel.sizeToFit()

        lastCheckedOutByLabel.text = book.lastCheckedOutBy ?? "No date"
        
//        
//        if let bookTitle = book.title {
//            titleLabel.text = bookTitle
//        } else { titleLabel.text = "No title😜" }
//        if let bookAuthor = book.author {
//            authorLabel.text = bookAuthor
//        } else {authorLabel.text = "No Author found"}
//        if let lastCheckedOut = book.lastCheckedOut {
//            lastCheckedOutByLabel.text = lastCheckedOut
//        } else { lastCheckedOutByLabel.text = "No body checked it out Yet"}
//        if let publisher = book.publisher{
//            publisherLabel.text = publisher
//        } else { publisherLabel.text = "no recoard of publisher"}
//        if let category = book.categories{
//            categoryLabel.text = category
//        }else { categoryLabel.text = "no Category Tagged" }
        
        let fullText = "Allo,This is book is published by \(book.publisher), last checkOut at \(book.lastCheckedOut), by this person \(book.lastCheckedOutBy). We think this place \(book.publisher) published it! Hope you enjoy it"
        print(fullText)
    }
 
    @IBAction func deleteButton(sender: AnyObject) {
        let bookDataStore : BookApiCall = BookApiCall.sharedInstance
        
        let bookId = book.id!
        bookDataStore.deleteBook(bookId) { (result) in
            // alertView
            print("book deleted\(result)")
        }
    }
}
