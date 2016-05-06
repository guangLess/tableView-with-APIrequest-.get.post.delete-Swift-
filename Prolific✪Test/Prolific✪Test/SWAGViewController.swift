//
//  SWAGViewController.swift
//  Prolific✪Test
//
//  Created by Guang on 4/29/16.
//  Copyright © 2016 Guang. All rights reserved.
//

import UIKit

class SWAGViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var bookTableView: UITableView!
    @IBOutlet weak var testLabel: UILabel!

    
    //var bookArray = [bookInfomation]()
    let bookDataUrl = "http://prolific-interview.herokuapp.com/5720c9b20574870009d73afc/books?" // make it static data
    let bookDataStore : BookApiCall = BookApiCall.sharedInstance
    
    private struct Storyboard {
        static let CellReuseIdentifier = "cell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // bookDataStore.getBookData{_ in
        bookDataStore.getBookData{_ in

        dispatch_async(dispatch_get_main_queue(), {
                print("block done to main Queue")
                self.bookTableView.reloadData()
            })
        }
        bookTableView.dataSource = self
        bookTableView.delegate = self
        testLabel.text = "This is a test!"
        
        //bookTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
//    func tableViewPostBookData() {
//        bookDataStore.postABook { _ in
//          self.bookTableView.reloadData()
//        }
//    }
    
    @IBAction func addBookAction(sender: AnyObject) {
//        bookDataStore.postABook { _ in
//            self.bookTableView.reloadData()
//        }
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

        //let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath) as! TableViewCell
        
        let bookCell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath) as! BookTableViewCell
        
        //let bookCell:BookTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as BookTableViewCell
      
        let eachBookCell = bookDataStore.bookArray[indexPath.row]
        print("author of the book \(eachBookCell.author) ---- title = \(eachBookCell.title)")
        //bookCell.textLabel?.text = eachBookCell.author

        bookCell.authorLabel.text = eachBookCell.author
        bookCell.titleLabel.text = eachBookCell.title
        
        return bookCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("cell selected")
        
        /*
         pageVC.imageObjects = self.hgImageDataStore.pictureArray
         pageVC.tappedCellIndex = indexPath.row
         
         self.navigationController?.pushViewController(pageVC, animated: true)
        */
        
        //let detailBook = BookDetailViewController()
        //detailBook.book = bookDataStore.bookArray[indexPath.row]
        //self.navigationController?.pushViewController(detailBook as! BookDetailViewController!, animated: true)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
       if let cell = sender as? BookTableViewCell {
            let i = bookTableView.indexPathForCell(cell)!.row
            if segue.identifier == "segueToBook" {
                let bookDetailVC = segue.destinationViewController as! BookDetailViewController
                bookDetailVC.book = bookDataStore.bookArray[i]
            }
        }
//    if segue.identifier == "addBook" {
//        let addBookVC = segue.destinationViewController as! AddBookViewController
//        addBookVC
//        
//    }
 }
}
