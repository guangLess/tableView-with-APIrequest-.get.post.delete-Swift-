Code✪Test

#1
Book model was rewritten based on https://talk.objc.io/episodes/S01E01-networking
-change variable types from Book model to conform to the data type from the server
-add optional initializer to better pass Book object for post, delete, edit
-Use generics to parse Json data.

SWAGViewController 
-Because of the changes in data model and the Networkcontroller changed, this main view controller is much neater. 

AddbookViewController
-func checkTextField has better way of checking the input values(not empty, not nil)
-weak self added in .postBook block to avoid retain cycle. 
#2
BookDetailController
- func checkOutAction added with AlertViewController that takes input text as an input for network.edit call. -func checkOutToNetwork is a helper method that takes the input text, added with NSDate for network.editBook call. 

-func shareButtonAction uses UIActivityViewController as app extensions for better share options.
#3
Minor changes on the UI
-Keyboard dismiss when adding books
-Correct the constrains for the table view vertical space to View.top
#4
PopupView is deleted because it was only used once for checkout, now is replaced by checkout alert. 
