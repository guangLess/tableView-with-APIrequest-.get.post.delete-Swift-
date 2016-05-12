//
//  AddBookViewController.swift
//  Prolific✪Test
//
//  Created by Guang on 5/4/16.
//  Copyright © 2016 Guang. All rights reserved.
//

import UIKit

class AddBookViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var addTitle: UITextField!
    @IBOutlet weak var addAuthor: UITextField!
    @IBOutlet weak var addCatories: UITextField!
    @IBOutlet weak var addPublisher: UITextField!
    @IBOutlet weak var submitButtonOutlet: UIButton!
    
    var book = BookInfomation()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTitle.delegate = self
        addAuthor.delegate = self
        addCatories.delegate = self
        addPublisher.delegate = self
        submitButtonOutlet.enabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  // MARK : Submit    
    @IBAction func submitButtonAction(sender: AnyObject) {
        
        let submitString = "\(book.title!) by \(book.author!) is trying to add itself"
        let addBookalertVC = UIAlertController(title:nil, message: submitString, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Great💥let's submit", style: .Default) { (action) -> Void in
            let addBookDataStore = BookApiCall.sharedInstance
            //dispatch_async(dispatch_get_main_queue(), {
            addBookDataStore.postAbook(self.book.dictionary) { (result) in
                print("result = \(result) book added\(self.book.dictionary)")
            }
            //})
            self.dismissViewControllerAnimated(true, completion: nil);
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) -> Void in
            self.submitButtonOutlet.setTitle("Submit 📖 again", forState: .Normal)
        }
        addBookalertVC.addAction(cancelAction)
        addBookalertVC.addAction(okAction)
        presentViewController(addBookalertVC, animated: true, completion: nil)
    }
    
    // MARK: Button Action
    @IBAction func BackButtonAction(sender: AnyObject) { // add action to the name
        self.dismissViewControllerAnimated(true, completion: nil); // make the animation slower
    }
    @IBAction func titleInput(sender: UITextField) {
        if (checkTextField(sender) == false) {
            alertViewActive()
        }
        print ("title check")
        book.title = sender.text!
    }
    @IBAction func authorInput(sender: UITextField) {
        if (checkTextField(sender) == false) {
            alertViewActive()
        }
        print ("author  check")
        book.author = sender.text!
    }
    @IBAction func catagrpyInput(sender: UITextField) {
        if (checkTextField(sender) == false) {
            alertViewActive()
        }
        print ("catagory  check")
        book.categories = sender.text!
    }
    @IBAction func publisher(sender: UITextField) {
        if (checkTextField(sender) == false) {
            alertViewActive()
        } // checkk number date?
        print ("publisher checker")
        book.publisher = sender.text!
    }
    
   // MARK: TextField related
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if (textField == addTitle){
        addAuthor.enabled = true
            addAuthor.becomeFirstResponder()
            return true
        }
        if (textField == addAuthor) {
            addCatories.enabled = true
            addCatories.becomeFirstResponder()
            return true
        }
        if (textField == addCatories) {
            addPublisher.enabled = true
            addPublisher.becomeFirstResponder()
            return true
        }
        if (textField == addPublisher){
            submitButtonOutlet.enabled = true
            submitButtonOutlet.setTitle("📖 submit", forState: .Normal)
            print(book.dictionary)
            return true
        }
        return false
    }
    
    func checkTextField(text: UITextField) -> Bool {
        
        if (text.text?.characters.count == 0) {
            return false
        }
        return true
    }
 // MARK: TextFieldAlert
    func alertViewActive() {
        let alertController = UIAlertController(title: "Yo, a book shall have a title?", message: "", preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
        }
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true) {
        }
    }
}