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
        
        textView.text = "Write here..."
          textView.textColor = UIColor.lightGray
        
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
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
         if(text == "\n") {
             textView.resignFirstResponder()
             return false
         }
         return true
     }

     /* Older versions of Swift */
     func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
         if(text == "\n") {
             textView.resignFirstResponder()
             return false
         }
         return true
     }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        counter = 0
        arrayCount = headlines.count
        textView.returnKeyType = UIReturnKeyType.done
        
        progressView.layer.cornerRadius = 5.0
        progressView.clipsToBounds = true
        
        var transform : CGAffineTransform = CGAffineTransform(scaleX: 1.0, y: 3.0)
        progressView.transform = transform
        
        textView.delegate = self
        
        textView.text = "Write here..."
        textView.textColor = UIColor.lightGray
        
        tapsave.layer.cornerRadius = 25.0
        tapsave.clipsToBounds = true
        
        if headlines.count > 1 {
            
            progressView.alpha = 1
            
            text.text = headlines[counter]
            
        } else {
            
       
            
            progressView.alpha = 0
            text.text = selectedheadline

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
    
    func showpropersummaries() {

        if counter == 0 {

            self.progressView.setProgress(0.0, animated: false)

        } else {
            let progress = (Float(counter)/Float(arrayCount-1))
            self.progressView.setProgress(Float(progress), animated: true)
        }

        if counter < headlines.count {

        text.text = headlines[counter]


        print(counter)

        }
    }
    
    @IBOutlet weak var progressView: UIProgressView!
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        if textView.text != "" {
            
            tapsave.alpha = 1
        } else {
            
            tapsave.alpha = 0.5
        }
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
    
    @IBOutlet weak var tapsave: UIButton!
    @IBAction func tapContinue(_ sender: Any) {
        
        if textView.text != "" {
        
            ref?.child("Entries").child(uid).child(selectedbookid).child("\(counter)").childByAutoId().updateChildValues(["Text" : textView.text!, "Date" : dateformat])
            
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
