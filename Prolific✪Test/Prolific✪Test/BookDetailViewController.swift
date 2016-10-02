//
//  BookDetailViewController.swift
//  Prolific✪Test
//
//  Created by Guang on 5/2/16.
//  Copyright © 2016 Guang. All rights reserved.
//

import UIKit
import Social

internal final class BookDetailViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var lastCheckedOutLabel: UILabel!
    @IBOutlet weak var lastCheckedOutByLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var popUpView: UILabel!
    @IBOutlet weak var lineDivider: UILabel!

    internal var book = Book()
    lazy var networkController: NetworkController = librarySystem()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //FIXME: maybe make it into a potocol or extention?
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.currentDevice().orientation.isLandscape.boolValue {
            print("Landscape")
            lineDivider.hidden = true
        } else {
            lineDivider.hidden = false
            print("Portrait")
        }
    }
    
// MARK: UI
    func updateUI() {
        
       // if let title = book.title as? String  {
       //     titleLabel.text = title } else {titleLabel.text = "xo"}
        self.popUpView.alpha = 0
        let noContent = " "
       _ = book.title.flatMap { t in
        titleLabel.text = t as? String ?? "✍🏾 No Content"
        }
        _ = book.author.flatMap({ t in
            authorLabel.text = t as? String ?? noContent
        })
        _ = book.categories.flatMap({ t in
            categoryLabel.text = t as? String ?? noContent
        })
        _ = book.publisher.flatMap({ t in
            publisherLabel.text = t as? String ?? noContent
        })
        _ = book.lastCheckedOut.flatMap({ t in
            lastCheckedOutLabel.text = t as? String ?? noContent
        })
        _ = book.lastCheckedOutBy.flatMap({ t in
            lastCheckedOutByLabel.text = t as? String ?? noContent
        })

//        let deviceOrientation = UIDevice.currentDevice().orientation
//        if deviceOrientation.isLandscape {
//            lineDivider.hidden = true
//        } else {
//            lineDivider.hidden = false
//        }
/*
        let fullText = "Allo,This is book is published by \(book.publisher), last checkOut at \(book.lastCheckedOut), by this person \(book.lastCheckedOutBy). We think this place \(book.publisher) published it! Hope you enjoy it"
 */
    }
     // MARK: Actions
    @IBAction func deleteButtonAction(sender: AnyObject) {
        let alertController = UIAlertController(title: "You are about to delete this book", message: "\(self.book.title!)", preferredStyle: .Alert)
        // TODO: (action)?
        let OKAction = UIAlertAction(title: "OK", style: .Default){ (action) in
            let bookId = self.book.id.map{$0 as! Int}
            self.networkController.deleteBook(bookId!, completion: { (result) in
                dispatch_async(dispatch_get_main_queue(), {
                    print("book deleted\(result)")
                    })
                })
//            self.bookDataStore.deleteBook(bookId) { (result) in
//                print("book deleted\(result)")
//                }
            
            self.navigationController?.popViewControllerAnimated(true)
        }
        alertController.addAction(OKAction)
        let cancelAction = UIAlertAction(title: "Cancle", style: .Default, handler: nil)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
        }
    
    @IBAction func checkOutAction(sender: UIButton) {
        let todaysDate:NSDate = NSDate()
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyy-MM-dd HH:mm:ss zzz"
        let dateInFormat = dateFormatter.stringFromDate(todaysDate) as String
        print(dateInFormat)
        let deviceName = UIDevice.currentDevice().name
        print(deviceName)
        let param = ["lastCheckedOut" : dateInFormat,
                     "lastCheckedOutBy" : deviceName]
        if let bookId = self.book.id {
        //bookDataStore.editBook(bookId, param: param)
        }
        
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
                    }, completion: {
                        finished in
                        self.navigationController?.popViewControllerAnimated(true)
                })
        })
  }
    // MARK: out of app Actions
    @IBAction func goToWebAction(sender: AnyObject) {
        let xOcean = titleLabel.text ?? "cute dogs"
        let url : NSString = "http://www.google.com/search?q=\(xOcean)"
        let urlStr = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        if let searchURL = NSURL(string: urlStr as String) {
        let urlToapp = UIApplication.sharedApplication()
        urlToapp.openURL(searchURL)
        }
   }
    @IBAction func shareButtonAction(sender: UIButton) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter){
            let twitterActionSheet: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterActionSheet.setInitialText("I checked out\(titleLabel.text)")
            self.presentViewController(twitterActionSheet, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "", message: "You are not loged in on Twitter", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
}
