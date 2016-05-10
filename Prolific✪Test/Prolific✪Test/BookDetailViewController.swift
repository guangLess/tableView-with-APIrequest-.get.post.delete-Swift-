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
   
    let bookDataStore : BookApiCall = BookApiCall.sharedInstance
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
  // MARK : UI
    func updateUI() {
        titleLabel.text = book.title ?? "This book has no Title.😜"
        //titleLabel.sizeToFit()
        authorLabel.text = book.author ?? "No Author😜"
        //authorLabel.sizeToFit()//➖💬🕛🕤✏︎✎
        categoryLabel.text = String(format:"⎣Category: %@⎦", book.categories ?? "Not Categorized")
        
        publisherLabel.text = String(format:"⎣Publisher: %@⎦", book.publisher ?? "No Publisher 😜")
        lastCheckedOutLabel.text = String(format:"⎜Checked out: %@ ⎜", book.lastCheckedOut ?? "be the first one to take the book!")
        lastCheckedOutByLabel.text = String(format:"⎜@ %@ ⎜", book.lastCheckedOutBy ?? "no time record")
      
        let fullText = "Allo,This is book is published by \(book.publisher), last checkOut at \(book.lastCheckedOut), by this person \(book.lastCheckedOutBy). We think this place \(book.publisher) published it! Hope you enjoy it"
        print(fullText)
    }
 // MARK : delete Action
    @IBAction func deleteButtonAction(sender: AnyObject) {
        
        // alertView
        let alertController = UIAlertController(title: "You are about to delete this book", message: "\(self.book.title!)", preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            let bookId = self.book.id!
            self.bookDataStore.deleteBook(bookId) { (result) in
                print("book deleted\(result)")
            }
            //self.dismissViewControllerAnimated(true, completion: nil);
            self.navigationController?.popViewControllerAnimated(true)
        }
        alertController.addAction(OKAction)
        
        let cancelAction = UIAlertAction(title: "Cancle", style: .Default) {(action) in
        }
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)

        }
    
    // MARK: Check Out
    
    @IBAction func checkOutAction(sender: UIButton) {
        
        let todaysDate:NSDate = NSDate()
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyy-MM-dd HH:mm:ss zzz"
        let dateInFormat:String = dateFormatter.stringFromDate(todaysDate)
        print(dateInFormat)
        //[[UIDevice currentDevice] name];
        let deviceName = UIDevice.currentDevice().name
        print(deviceName)
  
        let param = ["lastCheckedOut" : dateInFormat,
                     "lastCheckedOutBy" : deviceName]
        bookDataStore.editBook(self.book.id!, param: param)
    }
}
