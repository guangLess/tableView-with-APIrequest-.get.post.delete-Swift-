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
    
    private func updateUI() {
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
    }
    // MARK: Actions
    @IBAction func deleteButtonAction(sender: AnyObject) {
        let alertController = UIAlertController(title: "You are about to delete this book", message: "\(self.book.title!)", preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default){ (action) in
            let bookId = self.book.id.map{$0 as! Int}
            self.networkController.deleteBook(bookId!, completion: { (result) in
                dispatch_async(dispatch_get_main_queue(), {
                    print("book deleted\(result)")
                })
            })
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
        let param = ["lastCheckedOut" : dateInFormat,
                     "lastCheckedOutBy" : UIDevice.currentDevice().name]
        if let bookId = self.book.id as? Int {
            self.networkController.editBook(bookId, param: param)
        }
        let checkOutText = "You just checked out book\n ✎\(book.title!)"
        popUpView.popAnimation(checkOutText) { _ in
                self.navigationController?.popViewControllerAnimated(true)
                }
        
    }
    // MARK: APP extentions
    @IBAction func goToWebAction(sender: AnyObject) {
        let searchBook = titleLabel.text ?? "cute dogs"
        let url : NSString = "http://www.google.com/search?q=\(searchBook)"
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
    //FIXME: maybe make it into a potocol?
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.currentDevice().orientation.isLandscape.boolValue {
            print("Landscape")
            lineDivider.hidden = true
        } else {
            lineDivider.hidden = false
            print("Portrait")
        }
    }
}
