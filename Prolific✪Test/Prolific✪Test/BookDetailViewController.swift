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
    @IBOutlet weak var popUpView: UILabel!
   
    let bookDataStore : BookApiCall = BookApiCall.sharedInstance
    var book = BookInfomation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  // MARK : UI
    func updateUI() {
        titleLabel.text = book.title ?? "This book has no Title.😜"
        authorLabel.text = book.author ?? "No Author😜"
        //➖💬🕛🕤✏︎✎
        categoryLabel.text = String(format:"⎣Category: %@⎦", book.categories ?? "Not Categorized")
        publisherLabel.text = String(format:"⎣Publisher: %@⎦", book.publisher ?? "No Publisher 😜")
        lastCheckedOutLabel.text = String(format:"⎜Checked out: %@ ⎜", book.lastCheckedOut ?? "be the first one to take the book!")
        lastCheckedOutByLabel.text = String(format:"⎜@ %@ ⎜", book.lastCheckedOutBy ?? "no time record")
        
        self.popUpView.alpha = 0

        let fullText = "Allo,This is book is published by \(book.publisher), last checkOut at \(book.lastCheckedOut), by this person \(book.lastCheckedOutBy). We think this place \(book.publisher) published it! Hope you enjoy it"
        print(fullText)
    }
 // MARK : delete Action
    @IBAction func deleteButtonAction(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "You are about to delete this book", message: "\(self.book.title!)", preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            let bookId = self.book.id!
            self.bookDataStore.deleteBook(bookId) { (result) in
                print("book deleted\(result)")
            }
            self.navigationController?.popViewControllerAnimated(true)
        }
        alertController.addAction(OKAction)
        let cancelAction = UIAlertAction(title: "Cancle", style: .Default, handler: nil)
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
        let deviceName = UIDevice.currentDevice().name
        print(deviceName)
        let param = ["lastCheckedOut" : dateInFormat,
                     "lastCheckedOutBy" : deviceName]
        bookDataStore.editBook(self.book.id!, param: param)
        
        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.popUpView.alpha = 0.0
            }, completion: {
                (finished: Bool) -> Void in
                //Once the label is completely invisible, set the text and fade it back in
                self.popUpView.hidden = false
                self.popUpView.text = "You checked out \n ✎\(self.book.title!)"
                
                UIView.animateWithDuration(2.0, delay:0.3, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                    self.popUpView.alpha = 1.0
                    }, completion: nil)
                UIView.animateWithDuration(0.7, delay: 1.5, options: .CurveEaseIn, animations: {
                     self.popUpView.alpha = 0.77
                    }, completion: { finished in
                        self.navigationController?.popViewControllerAnimated(true)
                })
        })
  }
    
    @IBAction func goToWebAction(sender: AnyObject) {
        /*
         NSString *chromeScheme = nil;
         if ([scheme isEqualToString:@"http"]) {
         chromeScheme = @"googlechrome";
         } else if ([scheme isEqualToString:@"https"]) {
         chromeScheme = @"googlechromes";
         }
         
         // Proceed only if a valid Google Chrome URI Scheme is available.
         if (chromeScheme) {
         NSString *absoluteString = [inputURL absoluteString];
         NSRange rangeForScheme = [absoluteString rangeOfString:@":"];
         NSString *urlNoScheme =
         [absoluteString substringFromIndex:rangeForScheme.location];
         NSString *chromeURLString =
         [chromeScheme stringByAppendingString:urlNoScheme];
         NSURL *chromeURL = [NSURL URLWithString:chromeURLString];
         
         // Open the URL with Chrome.
         [[UIApplication sharedApplication] openURL:chromeURL];
         */
    }
    
    
   let url = NSURL(string: "https://www.hackingwithswift.com") {
        UIApplication.sharedApplication().openURL(url)
    }
    
    
    UIApplication.sharedApplication().openURL(NSURL(string: "http://www.stackoverflow.com")!)

    
    
    
}
