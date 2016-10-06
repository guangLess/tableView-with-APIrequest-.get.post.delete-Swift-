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

    internal var bookDetail = Book(dictionary: [:])
    lazy var networkController = NetworkControllerO()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    private func updateUI() {
        self.popUpView.alpha = 0
        let noContent = "✍🏾"
        titleLabel.text = bookDetail?.title
        authorLabel.text = bookDetail?.author
        categoryLabel.text = bookDetail?.categories
        publisherLabel.text = bookDetail?.publisher
        lastCheckedOutLabel.text = String(bookDetail!.lastCheckedOut) ?? noContent
        lastCheckedOutByLabel.text = String(bookDetail!.lastCheckedOutBy) ?? noContent
    }
    // MARK: Actions
    @IBAction func deleteButtonAction(sender: AnyObject) {
        unowned let weakSelf = self
        let alertController = UIAlertController(title: "You are about to delete 📖", message: "\(bookDetail?.title)!", preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default){ (action) in
            let bookId = weakSelf.bookDetail!.id
                weakSelf.networkController.deleteBook(bookId) { (result) in
                print("-----delete----")
                weakSelf.navigationController?.popViewControllerAnimated(true)
            }
        }
        alertController.addAction(OKAction)
        let cancelAction = UIAlertAction(title: "Cancle", style: .Default, handler: nil)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func checkOutAction(sender: UIButton) {
        //FIXME: if the book already checkedout, enable the button/checkout with String Name
        unowned let weakSelf = self
        let checkOutText = "You just checked out book\n ✎\(bookDetail!.title), Please enter your name." // FIXME: funnier copy write
        let chekcoutAlertVC = UIAlertController(title: checkOutText, message:"", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        let checkOutAction = UIAlertAction(title:"Check Out", style: .Default){ action in
            let nameField = chekcoutAlertVC.textFields?.first
            print(nameField?.text)
            if let id = weakSelf.bookDetail?.id,
            let byName = nameField?.text{
                weakSelf.checkOutToNetwork(weakSelf.networkController, bookId:id, byName:byName)
            }
        }
        chekcoutAlertVC.addTextFieldWithConfigurationHandler{ input in
            input.placeholder = "your name"
        }
        chekcoutAlertVC.addAction(cancelAction)
        chekcoutAlertVC.addAction(checkOutAction)
        self.presentViewController(chekcoutAlertVC, animated: true, completion: nil)
    }
    private func checkOutToNetwork(network:NetworkControllerO, bookId:NSNumber, byName:String){
        let todaysDate:NSDate = NSDate()
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyy-MM-dd HH:mm:ss zzz"
        let dateInFormat = dateFormatter.stringFromDate(todaysDate) as String
        let param : JsonDictionary = ["lastCheckedOut" : dateInFormat,
                                      "lastCheckedOutBy" :byName]
        network.editBook(bookId, param: param)
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
    @IBAction func shareButtonAction(sender: UIButton) { //FIXME: App extention 
        let shareText =  String("I checked out📖\(bookDetail?.title) by \(bookDetail?.author)")
        let share = UIActivityViewController(activityItems:[shareText],applicationActivities: [])
        self.presentViewController(share, animated: true, completion: nil)
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
