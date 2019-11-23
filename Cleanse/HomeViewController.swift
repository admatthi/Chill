//
//  HomeViewController.swift
//  Cleanse
//
//  Created by Alek Matthiessen on 10/31/19.
//  Copyright © 2019 The Matthiessen Group, LLC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseDatabase
import AudioToolbox
import AVFoundation

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextViewDelegate  {
    
    var counter = 0
    //
    var books: [Book] = [] {
        didSet {
            
            self.titleCollectionView.reloadData()
            
        }
    }
    
    
    
    
    @IBOutlet weak var titleCollectionView: UICollectionView!
    
    var swipecounter = Int()
    
    let swipeRightRec = UISwipeGestureRecognizer()
    let swipeLeftRec = UISwipeGestureRecognizer()
    let swipeUpRec = UISwipeGestureRecognizer()
    let swipeDownRec = UISwipeGestureRecognizer()
    
    
    
    
    var intdayofweek = Int()
    
    
    @IBOutlet var darklabel: UILabel!
    
    
    
    
    
    
    @IBOutlet weak var toplabel: UILabel!
    var mycolors = [UIColor]()
    
    @IBOutlet weak var tapdone: UIButton!
    @IBOutlet weak var tapsave: UIButton!
    @IBAction func tapSave(_ sender: Any) {
        
        tapsave.alpha = 0
        
        var myname = " "
        
        
        
        if textView.text != "" {
            
            let submission = textView.text!
            
            if submission.contains(".")  {
                
                var token = submission.components(separatedBy: ".")
                
                myname = token[0]
                
                
                ref?.child("Entries").child(uid).childByAutoId().updateChildValues(["Author" : "You", "Name" : myname, "Headline1" : " ", "Author Image" : selectedauthorimage, "Image" : "https://images.unsplash.com/photo-1571963977247-b7a0c50f0d93?ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=60", "Text\(counter)" : textView.text!, "Date" : dateformat])
                
            } else {
                
                if submission.contains("\n")  {
                    
                    var token = submission.components(separatedBy: ".")
                    
                    myname = token[0]
                    
                    
                    ref?.child("Entries").child(uid).childByAutoId().updateChildValues(["Author" : "You", "Name" : myname, "Headline1" : " ", "Author Image" : selectedauthorimage, "Image" : "https://images.unsplash.com/photo-1571963977247-b7a0c50f0d93?ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=60", "Text\(counter)" : textView.text!, "Date" : dateformat, "IntDate" : myint])
                    
                } else {
                    
                    if submission.contains(" ")  {
                            
                            var token = submission.components(separatedBy: ".")
                            
                            myname = token[0]
                            
                            
                            ref?.child("Entries").child(uid).childByAutoId().updateChildValues(["Author" : "You", "Name" : myname, "Headline1" : " ", "Author Image" : selectedauthorimage, "Image" : "https://images.unsplash.com/photo-1571963977247-b7a0c50f0d93?ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=60", "Text\(counter)" : textView.text!, "Date" : dateformat, "IntDate" : myint])
                            
                    } else {
                        
                        ref?.child("Entries").child(uid).childByAutoId().updateChildValues(["Author" : "You", "Name" : "Daily", "Headline1" : " ", "Author Image" : selectedauthorimage, "Image" : selectedbackground, "Text\(counter)" : textView.text!, "Date" : dateformat, "IntDate" : myint])
                    }
                    
                }
                
                
            }
            
            
        }
        
//        toplabel.alpha = 1
        textView.text = ""
        toplabel.alpha = 0

        
    }
    var time = String()
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        tapsave.alpha = 0
        tapdone.alpha = 1
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        if textView.text != "" {
            
            toplabel.alpha = 0
        }
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        queryforinfo()
        
        selectedgenre = "Chill"
        

        titleCollectionView.reloadData()
        
        textView.delegate = self
        textView.becomeFirstResponder()
        tapsave.alpha = 0
        tapdone.alpha = 1
        tapdone.layer.borderColor = UIColor.lightGray.cgColor
        tapdone.layer.borderWidth = 2.0
        tapdone.layer.cornerRadius = 5.0
        tapdone.clipsToBounds = true
        
        tapsave.layer.borderColor = UIColor.lightGray.cgColor
         tapsave.layer.borderWidth = 2.0
         tapsave.layer.cornerRadius = 5.0
         tapsave.clipsToBounds = true
        
        
        var screenSize = titleCollectionView.bounds
        var screenWidth = screenSize.width
        var screenHeight = screenSize.height
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth-30, height: 105)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        titleCollectionView!.collectionViewLayout = layout
        
        //        addstaticbooks()
        
        
        
        //        dayofmonth = "15"
        
        musictimer?.invalidate()
        
        updater?.invalidate()
        player?.pause()
        
        
        
        queryforids { () -> Void in
            
        }
        
        
        counter = 0
        
        let date = Date()
              let dateFormatter = DateFormatter()
              dateFormatter.dateFormat = "MMM d"
              let result = dateFormatter.string(from: date)

              dateformat = result
        
            let timeInterval = date.timeIntervalSince1970

        // convert to Integer
            myint = Int(timeInterval)
        
        
        toplabel.alpha = 0
        // Do any additional setup after loading the view.
    }
    
    
    
    var genreindex = Int()
    var text = String()
    
    
    func queryforids(completed: @escaping (() -> Void) ) {
        
        titleCollectionView.alpha = 0
        
        var functioncounter = 0
        
        
        
        ref?.child("AllBooks1").child(selectedgenre).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            print (value)
            
            if let snapDict = snapshot.value as? [String: AnyObject] {
                
                let genre = Genre(withJSON: snapDict)
                
                if let newbooks = genre.books {
                    
                    self.books = newbooks
                    
                    
                    if Int(self.time) ?? 11 < 12 {
                        
                        self.books = self.books.sorted(by: { $0.name ?? "Morning"  > $1.name ?? "Evening" })
                    } else {
                        
                        self.books = self.books.sorted(by: { $1.name ?? "Morning"  > $0.name ?? "Evening" })
                    }
                    
                    
                    
                }
                
                //                                for each in snapDict {
                //
                //                                    functioncounter += 1
                //
                //                                    let ids = each.key
                //
                //                                    seemoreids.append(ids)
                //
                //
                //                                    if functioncounter == snapDict.count {
                //
                //                                        self.updateaudiostructure()
                //
                //                                    }
                //                                }
                
            }
            
        })
    }
    
    
    
    var dayofmonth = String()
    
    func addstaticbooks() {
        
        selectedgenre = "Love"
        
        var counter2 = 7
        
        while counter2 < 12 {
            
            ref?.child("AllBooks1").child(selectedgenre).child("\(counter2)").updateChildValues(["Author": "Jordan B. Peterson", "BookID": "\(counter2)", "Description": "What does everyone in the modern world need to know? Renowned psychologist Jordan B. Peterson's answer to this most difficult of questions uniquely combines the hard-won truths of ancient tradition with the stunning revelations of cutting-edge scientific research.", "Genre": "\(selectedgenre)", "Image": "F\(counter2)", "Name": "12 Rules for Life", "Completed": "No", "Views": "x", "AmazonURL": "https://www.amazon.com/b?ie=UTF8&node=17025012011"])
            
            //    ref?.child("AllBooks2").child(selectedgenre).child("\(counter2)").updateChildValues([ "Views" : "\(nineviews[counter2])"])
            
            ref?.child("AllBooks1").child(selectedgenre).child("\(counter2)").child("Summary").child("Text").updateChildValues(["1": "x", "2": "x", "3": "x", "4": "x", "5": "x", "6": "x", "7": "x", "8": "x", "9": "x", "10": "x", "11": "x", "12": "x", "13": "x", "14": "x", "15": "x", "16": "x", "17": "x", "18": "x", "19": "x", "20": "x", "Title": "x"])
            
            counter2 += 1
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        refer = "On Tap Daily"
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
        
        if collectionView.tag == 1 {
            
            
            
        } else {
            
            if didpurchase {
                
                let book = self.book(atIndexPath: indexPath)
                
                
                
                headlines.removeAll()
                
                bookindex = indexPath.row
                selectedauthorname = book?.author ?? ""
                selectedtitle = book?.name ?? ""
                selectedurl = book?.audioURL ?? ""
                selectedbookid = book?.bookID ?? ""
                selectedgenre = book?.genre ?? ""
                selectedamazonurl = book?.amazonURL ?? ""
                selecteddescription = book?.description ?? ""
                selectedduration = book?.duration ?? 15
                selectedheadline = book?.headline1 ?? ""
                selectedprofession = book?.profession ?? ""
                selectedauthorimage = book?.authorImage ?? ""
                selectedbackground = book?.imageURL ?? ""
                
                headlines.append(book?.headline1 ?? "x")
                headlines.append(book?.headline2 ?? "x")
                headlines.append(book?.headline3 ?? "x")
                headlines.append(book?.headline4 ?? "x")
                headlines.append(book?.headline5 ?? "x")
                headlines.append(book?.headline6 ?? "x")
                headlines.append(book?.headline7 ?? "x")
                headlines.append(book?.headline8 ?? "x")
                
                headlines = headlines.filter{$0 != "x"}
                
                
                let alert = UIAlertController(title: "What would you like to do?", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Read", style: .default, handler: { action in
                    switch action.style{
                    case .default:
                        print("default")
                        
                        
                    case .cancel:
                        print("cancel")
                        
                    case .destructive:
                        print("destructive")
                        
                        
                    }}))
                alert.addAction(UIAlertAction(title: "Listen", style: .default, handler: { action in
                    switch action.style{
                    case .default:
                        print("default")
                        
                        self.performSegue(withIdentifier: "HomeToListen", sender: self)
                    case .cancel:
                        print("cancel")
                        
                    case .destructive:
                        print("destructive")
                        
                        
                    }}))
                
                
                self.performSegue(withIdentifier: "DailyToRead", sender: self)
                
                
            } else {
                
                self.performSegue(withIdentifier: "HomeToSale2", sender: self)
            }
            
            
            
        }
    }
    
    @IBAction func tapDiscount(_ sender: Any) {
        
        let alert = UIAlertController(title: "Please enter your discount code", message: "", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: configurationTextField)
        
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
                let textField = alert.textFields![0] // Force unwrapping because we know it exists.
                
                if textField.text != "" {
                    
                    if actualdiscount == textField.text! {
                        
                        didpurchase = true
                        
                        ref?.child("Users").child(uid).updateChildValues(["Purchased" : "True"])
                        
                    }
                    
                }
                
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    func configurationTextField(textField: UITextField!){
        textField?.placeholder = "Promo Code"
        
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        textone == ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        time = dateFormatter.string(from: NSDate() as Date)
        
        
        
        titleCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return books.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let book = self.book(atIndexPath: indexPath)
        titleCollectionView.alpha = 1
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Books", for: indexPath) as! TitleCollectionViewCell
        //
        //            if book?.bookID == "Title" {
        //
        //                return cell
        //
        //            } else {
        
        
        
        cell.backlabel.layer.cornerRadius = 15.0
        cell.backlabel.clipsToBounds = true
        
 
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        let result = dateFormatter.string(from: date)
        
        dateformat = result
        cell.datelabel.text = result
        
        let name = book?.name
        
        if (name?.contains(":"))! {
            
            var namestring = name?.components(separatedBy: ":")
            
            cell.titlelabel.text = namestring![0]
            
        } else {
            
            cell.titlelabel.text = name
            
        }
        
        
        
        
        
        
        if name == "Morning Pages"{
            
            cell.titleImage.image = UIImage(named: "Sun")
            
            
            if Int(time) ?? 11 > 12 {
                
                cell.alpha = 0
                
            }
            
        } else {
            
            if Int(time) ?? 11 <= 12 {
                
                cell.alpha = 0
            }
            
            cell.titleImage.image = UIImage(named: "Moon")
            
        }
        
        
        var randomint = Int.random(in: 100..<1000)
        
        
        cell.titleImage.layer.cornerRadius = cell.titleImage.frame.size.width/2
        cell.titleImage.clipsToBounds = true
        cell.titleImage.alpha = 1
        
        
        let isWished = Bool()
        
        if wishlistids.contains(book!.bookID) {
            
            
        } else {
            
        }
        
        cell.layer.cornerRadius = 5.0
        cell.layer.masksToBounds = true
        
        cell.titlelabel.alpha = 1
        cell.titlelabel.alpha = 1
        
        
        
        
        
        return cell
        
        
        
    }
    @IBAction func tapDone(_ sender: Any) {
        
        self.textView.endEditing(true)
        tapdone.alpha = 0
        
        if textView.text != "" {
                   
            tapsave.alpha = 1
            toplabel.alpha = 0

        } else {
            
//            toplabel.alpha = 1
            toplabel.alpha = 0


        }

    }
    
    @IBOutlet weak var textView: UITextView!
    func queryforinfo() {
        
        ref?.child("Users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            if let purchased = value?["Purchased"] as? String {
                
                if purchased == "True" {
                    
                    didpurchase = true
                    
                } else {
                    
                    didpurchase = false
                    self.performSegue(withIdentifier: "HomeToSale2", sender: self)
                    
                }
                
            } else {
                
                didpurchase = false
                self.performSegue(withIdentifier: "HomeToSale2", sender: self)
            }
            
        })
        
    }
    
    var selectedindex = Int()
    
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func tapShowDiscount(_ sender: Any) {
        
        
    }
    
    
    
    
    
    
    
}

var didpurchase = Bool()
       // MARK: - Helpers
extension HomeViewController {
    func book(atIndex index: Int) -> Book? {
        if index > books.count - 1 {
            return nil
        }
        
        return books[index]
    }
    
    func book(atIndexPath indexPath: IndexPath) -> Book? {
        return self.book(atIndex: indexPath.row)
    }
}


var slimeybool = Bool()
