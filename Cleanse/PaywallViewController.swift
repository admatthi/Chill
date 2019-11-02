//
//  PaywallViewController.swift
//  Cleanse
//
//  Created by Alek Matthiessen on 10/27/19.
//  Copyright © 2019 The Matthiessen Group, LLC. All rights reserved.
//

import UIKit
import Firebase
import Purchases

class PaywallViewController: UIViewController {

    var purchases = Purchases.configure(withAPIKey: "paCLaBYrGELMfdxuMQqbROxMfgDbcGGn", appUserID: nil)

    
    @IBAction func tapRestore(_ sender: Any) {
        
        
    }
    @IBAction func tapBack(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func tapContinue(_ sender: Any) {
        
        purchases.entitlements { (entitlements, error) in
            guard let pro = entitlements?["subscriptions"] else { return }
            guard let monthly = pro.offerings["com.aatech.chill6999"] else { return }
            guard let product = monthly.activeProduct else { return }
            
            self.purchases.makePurchase(product, { (transaction, purchaserInfo, error, cancelled) in
                if let purchaserInfo = purchaserInfo {
                    
                    if purchaserInfo.activeEntitlements.contains("my_entitlement_identifier") {
                        // Unlock that great "pro" content
                        
                        ref?.child("Users").child(uid).updateChildValues(["Purchased" : "True"])
                        
                        didpurchase = true

                        self.dismiss(animated: true, completion: nil)
                    }
                    
                }
            })
            
        }
    }
    
    @IBAction func tapTerms(_ sender: Any) {

         if let url = NSURL(string: "https://booknotesapp.com/privacy"
             ) {
             UIApplication.shared.openURL(url as URL)
         }

     }
    @IBOutlet weak var tapcontinue: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()

        tapcontinue.layer.cornerRadius = 5.0
        
        tapcontinue.clipsToBounds = true
        // Do any additional setup after loading the view.
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
