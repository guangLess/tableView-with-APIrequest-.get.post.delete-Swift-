//
//  AddBookViewController.swift
//  Prolific✪Test
//
//  Created by Guang on 5/4/16.
//  Copyright © 2016 Guang. All rights reserved.
//
import UIKit
internal final class AddBookViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var addTitle: UITextField!
    @IBOutlet weak var addAuthor: UITextField!
    @IBOutlet weak var addCatories: UITextField!
    @IBOutlet weak var addPublisher: UITextField!
    @IBOutlet weak var submitButtonOutlet: UIButton!
    //private var book = Book(dictionary: [:])!
    lazy var networkController = NetworkControllerO()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDelegates()
        submitButtonOutlet.enabled = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    private func addDelegates()  {
        addTitle.delegate = self
        addAuthor.delegate = self
        addCatories.delegate = self
        addPublisher.delegate = self
    }
    // MARK : Submit
    @IBAction func submitButtonAction(sender: AnyObject) {
       /*
        if let title = book.title {
            if let author = book.author {
                let submitString = "📖 \(title) by \(author) is about to be added"
                let addBookalertVC = UIAlertController(title:nil, message: submitString, preferredStyle: .Alert)
                let okAction = UIAlertAction(title: "Great💥submit", style: .Default){ _ in
                    self.networkController.postAbook(self.book) { result in
                        print("result = \(result) book added\(self.book.dictionary)")
                    }
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel){ _ in
                    self.submitButtonOutlet.setTitle("Submit 📖 again", forState: .Normal)
                }
                addBookalertVC.addAction(cancelAction)
                addBookalertVC.addAction(okAction)
                presentViewController(addBookalertVC, animated: true, completion: nil)
            }
        }
 */
    }
    @IBAction func BackButtonAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    @IBAction func titleInput(sender: UITextField) {
        checkTextField(sender)
        print ("title check")
       // book.title = sender.text!
    }
    @IBAction func authorInput(sender: UITextField) {
        checkTextField(sender)
        print ("author  check")
        //book.author = sender.text!
    }
    @IBAction func catagrpyInput(sender: UITextField) {
        checkTextField(sender)
        print ("catagory  check")
        //book.categories = sender.text!
        resignFirstResponder()
    }
    @IBAction func publisher(sender: UITextField) {
        checkTextField(sender)
        print ("publisher checker")
        //book.publisher = sender.text!
    }
    // MARK: TextField related
    private func textFieldShouldReturn(textField: UITextField) -> Bool {
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
            view.endEditing(true)
            submitButtonOutlet.setTitle("📖 submit", forState: .Normal)
           // print(book.dictionary)
            return true
        }
        return false
    }
    private func checkTextField(textField: UITextField) -> Bool {
        //FIXME: two returns
        let checkChar = textField.text?.isEmpty
        if (!checkChar) {
            alertViewActive(textField.placeholder!)
        }
        return checkChar
    }
    // MARK: TextFieldAlert
    private func alertViewActive(missingText : String) {
        let alertController = UIAlertController(title: "\(missingText)?", message: "", preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default){(action) in
        }
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true) {
        }
    }
}