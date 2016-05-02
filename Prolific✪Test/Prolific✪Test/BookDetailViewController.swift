//
//  BookDetailViewController.swift
//  Prolific✪Test
//
//  Created by Guang on 5/2/16.
//  Copyright © 2016 Guang. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var authorLabel: UILabel!
//    @IBOutlet weak var categorieLabel: UILabel!
//    @IBOutlet weak var lastCheckedOutLabel: UILabel!
//    @IBOutlet weak var lastCheckedOutByLabel: UILabel!
//    @IBOutlet weak var publisherLabel: UILabel!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var lastCheckedOutLabel: UILabel!
    @IBOutlet weak var lastCheckedOutByLabel: UILabel!
    
    @IBOutlet weak var publisherLabel: UILabel!
   
    //var book = bookInfomation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //updateUI()
        authorLabel.text = "hello world"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    func updateUI() {
        if let bookTitle = book.title {
            titleLabel.text = bookTitle
        } else { titleLabel.text = "No title" }
        
        if let bookAuthor = book.author {
            authorLabel.text = bookAuthor
        } else {authorLabel.text = "No Author found"}
        
        if let lastCheckedOut = book.lastCheckedOut {
            lastCheckedOutByLabel.text = lastCheckedOut
        } else { lastCheckedOutByLabel.text = "No body checked it out Yet"}
        if let publisher = book.publisher{
            publisherLabel.text = publisher
        } else { publisherLabel.text = "no recoard of publisher"}
        if let category = book.categories{
            categoryLabel.text = category
        }else { categoryLabel.text = "no Category Tagged" }
    }
   */ 
}
