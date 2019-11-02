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

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {

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

    

     


           var mycolors = [UIColor]()

           override func viewDidLoad() {
               super.viewDidLoad()

               ref = Database.database().reference()
            

               selectedgenre = "Chill"


               titleCollectionView.reloadData()
            
            var screenSize = titleCollectionView.bounds
                   var screenWidth = screenSize.width
                   var screenHeight = screenSize.height

                   let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                   layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 10, right: 0)
                   layout.itemSize = CGSize(width: screenWidth-20, height: 105)
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


                queryforinfo()
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

                           self.books = self.books.sorted(by: { $0.popularity ?? 0  > $1.popularity ?? 0 })

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

               let generator = UIImpactFeedbackGenerator(style: .heavy)
               generator.impactOccurred()
      

               if collectionView.tag == 1 {

     

               } else {

                if didpurchase {

                   let book = self.book(atIndexPath: indexPath)
                   
                   
                   
                   bookindex = indexPath.row
                   selectedauthor = book?.author ?? ""
                   selectedtitle = book?.name ?? ""
                   selectedurl = book?.audioURL ?? ""
                   selectedbookid = book?.bookID ?? ""
                   selectedgenre = book?.genre ?? ""
                   selectedamazonurl = book?.amazonURL ?? ""
                   selecteddescription = book?.description ?? ""
                   selectedduration = book?.duration ?? 15
                   selectedheadline = book?.headline1 ?? ""
                   
                        
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
                       
                       self.performSegue(withIdentifier: "HomeToSale", sender: self)

                   }



            }
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



                   if let imageURLString = book?.imageURL, let imageUrl = URL(string: imageURLString) {

                    
                    if name == "Morning Chill"{
                        
                        cell.titleImage.image = UIImage(named: "Sun")

                    } else {
                        
                        cell.titleImage.image = UIImage(named: "Moon")

                    }
                       
                       
                       var randomint = Int.random(in: 100..<1000)
                       

                    cell.titleImage.layer.cornerRadius = cell.titleImage.frame.size.width/2
                       cell.titleImage.clipsToBounds = true
                       cell.titleImage.alpha = 1

                   }

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
        
    func queryforinfo() {
                
        ref?.child("Users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            if let purchased = value?["Purchased"] as? String {
                
                if purchased == "True" {
                    
                    didpurchase = true
                    
                } else {
                                 
                    didpurchase = false
                    self.performSegue(withIdentifier: "HomeToSale", sender: self)
                    
                }
                
            } else {
                
                didpurchase = false
              self.performSegue(withIdentifier: "HomeToSale", sender: self)
            }
            
        })
        
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

