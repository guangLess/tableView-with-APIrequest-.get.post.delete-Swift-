//
//  SWAGViewController.swift
//  Prolific✪Test
//
//  Created by Guang on 4/29/16.
//  Copyright © 2016 Guang. All rights reserved.

// TODO: size classes ! Testing.

import UIKit

//internal final
class SWAGViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var bookTableView: UITableView!
    @IBOutlet weak var testLabel: UILabel!
    let bookDataStore: BookApiCall = BookApiCall.sharedInstance
    
    private struct Storyboard {
        static let CellReuseIdentifier = "cell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookTableView.dataSource = self
        bookTableView.delegate = self
        testLabel.text = "This is a test!"
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refreshTableView()
    }
    
    private func refreshTableView() {
        bookDataStore.bookArray.removeAll()
        bookDataStore.getBookData{_ in
            dispatch_async(dispatch_get_main_queue(), {
                self.bookTableView.reloadData()
            })
        }
    }
    
    @IBAction func addBookAction(sender: AnyObject) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   func tableView(tableView: UITableView,
                     numberOfRowsInSection section: Int) -> Int {
        return bookDataStore.bookArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
   
        let bookCell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath) as! BookTableViewCell
        let eachBookCell = bookDataStore.bookArray[indexPath.row]
        print("author of the book \(eachBookCell.author) ---- title = \(eachBookCell.title)")
        bookCell.titleLabel.text = eachBookCell.title
        bookCell.titleLabel.sizeToFit()//✐
        bookCell.authorLabel.text = String(format:" ✎ %@",eachBookCell.author ?? "We don't know who wrote this book")
        bookCell.authorLabel.sizeToFit()//✐

        return bookCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("cell selected")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if let cell = sender as? BookTableViewCell {
            let i = bookTableView.indexPathForCell(cell)!.row
            if segue.identifier == "segueToBook" {
                let bookDetailVC = segue.destinationViewController as! BookDetailViewController
                bookDetailVC.book = bookDataStore.bookArray[i]
            }
        }
    }
}
