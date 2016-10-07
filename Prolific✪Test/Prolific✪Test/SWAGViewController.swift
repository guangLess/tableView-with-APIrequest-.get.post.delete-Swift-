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
    lazy var networkController = NetworkController()
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
        networkController.load(Book.all) { books in
            dispatch_async(dispatch_get_main_queue(), {
                print("----------------\(books?.count)")
                self.result = books.flatMap({$0})!
                print(self.result.last)
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
        bookCell.titleLabel.text = bookC.title
        bookCell.authorLabel.text = bookC.author
        bookCell.titleLabel.sizeToFit()
        bookCell.authorLabel.sizeToFit()
        return bookCell
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toDetail") {
            let destinationVC = segue.destinationViewController as? BookDetailViewController
            if let row = bookTableView.indexPathForSelectedRow?.row{
                destinationVC?.bookDetail = result[row] as Book
            }
        }
    }
}
