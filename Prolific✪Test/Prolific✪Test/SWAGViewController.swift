//
//  SWAGViewController.swift
//  Prolific✪Test
//
//  Created by Guang on 4/29/16.
//  Copyright © 2016 Guang. All rights reserved.

import UIKit

internal final class SWAGViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var bookTableView: UITableView!
    private struct Storyboard {
        static let CellReuseIdentifier = "cell"
    }
    lazy var networkController: NetworkController = librarySystem()
    var result = [Book]()

    override func viewDidLoad() {
        super.viewDidLoad()
        bookTableView.dataSource = self
        bookTableView.delegate = self
        refreshTableView()
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
                self.bookTableView.reloadData()
            })
        }
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
