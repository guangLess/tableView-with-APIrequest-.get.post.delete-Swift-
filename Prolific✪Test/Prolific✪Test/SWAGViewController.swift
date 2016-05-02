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
    
    //var bookArray = [bookInfomation]()
    let bookDataUrl = "http://prolific-interview.herokuapp.com/5720c9b20574870009d73afc/books?"
    let bookDataStore : BookApiCall = BookApiCall.sharedInstance
    
    private struct Storyboard {
        static let CellReuseIdentifier = "cell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookDataStore.getBookData{_ in
            dispatch_async(dispatch_get_main_queue(), {
                print("block done to main Queue")
                self.bookTableView.reloadData()
            })
        }
        bookTableView.dataSource = self
        bookTableView.delegate = self
        
        //bookTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
    }
}
