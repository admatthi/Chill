//
//  TextViewController.swift
//  Cleanse
//
//  Created by Alek Matthiessen on 10/27/19.
//  Copyright © 2019 The Matthiessen Group, LLC. All rights reserved.
//

import UIKit

var selectedheadline = String()
var dateformat = String()

class TextViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bookcover: UIImageView!
    @IBOutlet weak var authorlabel: UILabel!
    @IBOutlet weak var titlelabel: UILabel!
    
    @IBAction func tapSave(_ sender: Any) {
        
          tapsave.alpha = 0
                
                var myname = " "
                
                
                
                if textView.text != "" {
                    
                    let submission = textView.text!
                    
                    if submission.contains(".")  {
                        
                        var token = submission.components(separatedBy: ".")
                        
                        myname = token[0]
                        
                        ref?.child("Entries").child(uid).child(selectedbookid).removeValue()
                        ref?.child("Entries").child(uid).childByAutoId().updateChildValues(["Author" : "You", "Name" : myname, "Headline1" : headlines[0], "Author Image" : selectedauthorimage, "Image" : "https://images.unsplash.com/photo-1571963977247-b7a0c50f0d93?ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=60", "Text\(counter)" : textView.text!, "Date" : dateformat])
                        
                        self.dismiss(animated: true, completion: nil)
                        
                    } else {
                        
                        if submission.contains("\n")  {
                            
                            var token = submission.components(separatedBy: ".")
                            
                            myname = token[0]
                            
                            ref?.child("Entries").child(uid).child(selectedbookid).removeValue()

                            
                            ref?.child("Entries").child(uid).childByAutoId().updateChildValues(["Author" : "You", "Name" : myname, "Headline1" : headlines[0], "Author Image" : selectedauthorimage, "Image" : "https://images.unsplash.com/photo-1571963977247-b7a0c50f0d93?ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=60", "Text\(counter)" : textView.text!, "Date" : dateformat, "IntDate" : myint])
                            
                            self.dismiss(animated: true, completion: nil)

                        } else {
                            
                            if submission.contains(" ")  {
                                    
                                    var token = submission.components(separatedBy: ".")
                                    
                                    myname = token[0]
                                    
                                    
                                ref?.child("Entries").child(uid).child(selectedbookid).removeValue()

                                    ref?.child("Entries").child(uid).childByAutoId().updateChildValues(["Author" : "You", "Name" : myname, "Headline1" : headlines[0], "Author Image" : selectedauthorimage, "Image" : "https://images.unsplash.com/photo-1571963977247-b7a0c50f0d93?ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=60", "Text\(counter)" : textView.text!, "Date" : dateformat, "IntDate" : myint])
                                
                                self.dismiss(animated: true, completion: nil)

                                    
                            } else {
                                
                                ref?.child("Entries").child(uid).child(selectedbookid).removeValue()

                                ref?.child("Entries").child(uid).childByAutoId().updateChildValues(["Author" : "You", "Name" : "Daily", "Headline1" : headlines[0], "Author Image" : selectedauthorimage, "Image" : selectedbackground, "Text\(counter)" : textView.text!, "Date" : dateformat, "IntDate" : myint])
                                
                                self.dismiss(animated: true, completion: nil)

                            }
                            
                        }
                        
                        
                    }
                    
                    
                }
                
        //        toplabel.alpha = 1
                textView.text = ""
    }
    @IBAction func tapDone(_ sender: Any) {
        
                self.textView.endEditing(true)
                tapdone.alpha = 0
                
                if textView.text != "" {
                           
                    tapsave.alpha = 1

                } else {
                    
        //            toplabel.alpha = 1
                }
    }
    @IBOutlet weak var tapdone: UIButton!
    @IBOutlet weak var tapsave: UIButton!
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        textView.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction(){
        textView.resignFirstResponder()
    }
    
    @IBAction func tapBack(_ sender: Any) {
        
        lastcount()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

             self.textView.endEditing(true)
      


         }
    
    var arrayCount = Int()
    
    @IBOutlet weak var headline: UILabel!
    @IBOutlet weak var text: UILabel!
    
    func nextcount() {
        
        textView.text = ""
          textView.textColor = UIColor.black
        
        if counter > headlines.count-2 {
            
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            
            

            
            self.dismiss(animated: true, completion: nil)
            
        } else {
            
            counter += 1
            
            
            
            showpropersummaries()
//            textView.slideInFromRight()
//            text.slideInFromRight()
        }
        
    }
//
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//         if(text == "\n") {
//             textView.resignFirstResponder()
//             return false
//         }
//         return true
//     }

     /* Older versions of Swift */
//     func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
//         if(text == "\n") {
//             textView.resignFirstResponder()
//             return false
//         }
//         return true
//     }
    
    @IBOutlet weak var authorftile: UILabel!
    @IBOutlet weak var titleoftile: UILabel!
    
    @IBOutlet weak var backimage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        counter = 0
        arrayCount = headlines.count
//        textView.returnKeyType = UIReturnKeyType.done
        
        progressView.layer.cornerRadius = 5.0
        progressView.clipsToBounds = true
        
        textView.layer.cornerRadius = 5.0
        textView.clipsToBounds = true
        
        var transform : CGAffineTransform = CGAffineTransform(scaleX: 1.0, y: 3.0)
        progressView.transform = transform
        
        textView.delegate = self
        
        textView.text = ""
        textView.textColor = UIColor.black
        
          textView.delegate = self
           textView.becomeFirstResponder()
           tapsave.alpha = 0
           tapdone.alpha = 1
        tapdone.layer.borderColor = myblue.cgColor
           tapdone.layer.borderWidth = 2.0
           tapdone.layer.cornerRadius = 5.0
           tapdone.clipsToBounds = true
           
        tapsave.layer.borderColor = myblue.cgColor
            tapsave.layer.borderWidth = 2.0
            tapsave.layer.cornerRadius = 5.0
            tapsave.clipsToBounds = true
        
        
        
        if headlines.count > 1 {
            
//            progressView.alpha = 1
            
            progressView.alpha = 0

            
            text.text = headlines[counter]
            
        } else {
            
            
            
            progressView.alpha = 0
            text.text = selectedheadline
            
        }
        
        let imageURLString = selectedbackground
        
        let  imageUrl = URL(string: imageURLString)
        
//        backimage.kf.setImage(with: imageUrl)
//        backimage.layer.cornerRadius = backimage.frame.size.width / 2
//        backimage.clipsToBounds = true
//        authorftile.text = selectedauthorname
//        titleoftile.text = selectedtitle
//
        if textone != "" {
            
            textView.text = textone
        } else {
            
            textView.text = ""

        }
        
        
        // Do any additional setup after loading the view.
    }
    
    func lastcount() {

         if counter == 0 {

            self.dismiss(animated: true, completion: nil)
            
         } else {

             counter -= 1
            showpropersummaries()
//
//             textView.slideInFromLeft()
//             text.slideInFromLeft()

         }


     }
    
    override func viewDidDisappear(_ animated: Bool) {
        
            textone = ""
            texttwo = ""
            textthree = ""
    }
    
    func showpropersummaries() {

        if counter == 0 {

            self.progressView.setProgress(0.0, animated: false)

        } else {
            let progress = (Float(counter)/Float(arrayCount-1))
            self.progressView.setProgress(Float(progress), animated: true)
        }

        if counter < headlines.count {
            
            if counter == 0 {
                
                if textone != "" {
                    
                    textView.text = textone
                } else {
                    
                    textView.text = ""

                }
            }
            
            if counter == 1 {
                
                if texttwo != "" {
                    
                    textView.text = texttwo
                } else {
                    
                    textView.text = ""

                }
            }
            
            if counter == 2 {
                
                if textthree != "" {
                    
                    textView.text = textthree
                } else {
                    
                    textView.text = ""

                }
            }

        text.text = headlines[counter]


        print(counter)

        }
    }
    
    @IBOutlet weak var progressView: UIProgressView!
    func textViewDidBeginEditing(_ textView: UITextView) {
        
          tapsave.alpha = 0
        tapdone.alpha = 1
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
      
    }
    
    func setDoneOnKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(TextViewController.dismissKeyboard))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        self.textView.inputAccessoryView = keyboardToolbar
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func tapContinue(_ sender: Any) {
        
        if textView.text != "" {
        
            if headlines.count == 1 {
                ref?.child("Entries").child(uid).childByAutoId().updateChildValues(["Author" : selectedauthorname, "Name" : selectedtitle, "Headline1" : headlines[0], "Author Image" : selectedauthorimage, "Image" : selectedbackground, "Text\(counter)" : textView.text!, "Date" : dateformat])
                
            }
            
            if headlines.count == 2 {
             ref?.child("Entries").child(uid).childByAutoId().updateChildValues(["Author" : selectedauthorname, "Name" : selectedtitle, "Headline1" : headlines[0], "Headline2" : headlines[1], "Author Image" : selectedauthorimage, "Image" : selectedbackground, "Text\(counter)" : textView.text!, "Date" : dateformat])
                 
             }
             
            
            if headlines.count == 3 {
             ref?.child("Entries").child(uid).childByAutoId().updateChildValues(["Author" : selectedauthorname, "Name" : selectedtitle, "Headline1" : headlines[0], "Headline2" : headlines[1], "Headline3" : headlines[2], "Author Image" : selectedauthorimage, "Image" : selectedbackground, "Text\(counter)" : textView.text!, "Date" : dateformat])
                 
             }
             
            
            
            
    
            
            nextcount()

        } else {
            
            nextcount()

        }
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Write here..."
            textView.textColor = UIColor.lightGray
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
