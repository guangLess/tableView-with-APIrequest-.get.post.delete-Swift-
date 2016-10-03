//
//  SWAGViewController.swift
//  Prolific✪Test
//
//  Created by Guang on 4/29/16.
//  Copyright © 2016 Guang. All rights reserved.

import UIKit

internal final class SWAGViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var bookTableView: UITableView!
    @IBOutlet weak var testLabel: UILabel!

    lazy var networkController: NetworkController = librarySystem()
    var result = [Book]()

    private struct Storyboard {
        static let CellReuseIdentifier = "cell"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bookTableView.dataSource = self
        bookTableView.delegate = self
        testLabel.text = "This is a test!"
        //refreshTableView()
        //FIXME: reload twice
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refreshTableView()
    }
    private func refreshTableView() {
        self.result.removeAll()
        networkController.getBookData { books in
            dispatch_async(dispatch_get_main_queue(), {
                self.result = books
                print("---------------shane is ass\n \(self.result.count)")
                self.bookTableView.reloadData()
            })
        }
    }
    @IBAction func addBookAction(sender: AnyObject) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   func tableView(tableView: UITableView,
                     numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let bookCell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath) as! BookTableViewCell
        let bookC = result[indexPath.row]
        //FIXME: add struct here for each cellContent
        print("author of the book \(bookC.author) ---- title = \(bookC.title)")
        _ = bookC.title.map { title in
            bookCell.titleLabel.text = title as? String
            bookCell.titleLabel.sizeToFit()
        }
        _ = bookC.author.map({ author in
            bookCell.authorLabel.text = author as? String
            bookCell.authorLabel.sizeToFit()
        })
        return bookCell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("cell selected")
        //self.performSegueWithIdentifier("toDetail", sender: indexPath)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toDetail") {
            let destinationVC = segue.destinationViewController as? BookDetailViewController
            if let row = bookTableView.indexPathForSelectedRow?.row{
            print(row)
            print (result[row])
            destinationVC?.book = result[row]
            }
        }
    }
}
