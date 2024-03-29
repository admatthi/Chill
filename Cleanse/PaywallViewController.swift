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
import FBSDKCoreKit
var refer = String()

class PaywallViewController: UIViewController {
    
    @IBOutlet weak var termstext: UILabel!
    @IBOutlet weak var disclaimertext: UIButton!
    @IBOutlet weak var leadingtext: UILabel!
    var purchases = Purchases.configure(withAPIKey: "paCLaBYrGELMfdxuMQqbROxMfgDbcGGn", appUserID: nil)
    
    
    @IBAction func tapRestore(_ sender: Any) {
        
        
    }
    @IBAction func tapBack(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var backimage: UIImageView!
    @IBAction func tapContinue(_ sender: Any) {
        
        logTapSubscribeEvent(referrer : refer)
        
        purchases.entitlements { (entitlements, error) in
            guard let pro = entitlements?["subscriptions"] else { return }
            guard let monthly = pro.offerings["Yearly"] else { return }
            guard let product = monthly.activeProduct else { return }
            
            self.purchases.makePurchase(product, { (transaction, purchaserInfo, error, cancelled) in
                if let purchaserInfo = purchaserInfo {
                    
                    if purchaserInfo.activeEntitlements.contains("my_entitlement_identifier") {
                        // Unlock that great "pro" content
                        
                        self.logPurchaseSuccessEvent(referrer : refer)
                    ref?.child("Users").child(uid).updateChildValues(["Purchased" : "True"])
                        
                        didpurchase = true
                        
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        
                        
                        self.logPurchaseSuccessEvent(referrer : refer)
                        
                        ref?.child("Users").child(uid).updateChildValues(["Purchased" : "True"])
                        
                        didpurchase = true
                        self.dismiss(animated: true, completion: nil)
                        
                        
                    }
                    
                }
            })
            
        }
    }
    
    @IBAction func tapTerms(_ sender: Any) {
        
        if let url = NSURL(string: "https://getchillapp.weebly.com/privacy"
            ) {
            UIApplication.shared.openURL(url as URL)
        }
        
    }
    
    
    @IBOutlet weak var tapcontinue: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = backimage.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backimage.addSubview(blurEffectView)
        
        tapcontinue.layer.cornerRadius = 5.0
        
        tapcontinue.clipsToBounds = true
        
        logPaywallShownEvent(referrer : refer)
        
        if slimeybool {
            
            termstext.alpha = 0
            leadingtext.alpha = 0
            disclaimertext.alpha = 0
            tapcontinue.setTitle("Try Free", for: .normal)
            
        } else {
            
            termstext.alpha = 1
            leadingtext.alpha = 1
            disclaimertext.alpha = 1
            tapcontinue.setTitle("Continue", for: .normal)
        }
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
    
    func logPaywallShownEvent(referrer : String) {
        AppEvents.logEvent(AppEvents.Name(rawValue: "paywall shown"), parameters: ["referrer" : referrer])
    }
    
    func logTapSubscribeEvent(referrer : String) {
        AppEvents.logEvent(AppEvents.Name(rawValue: "tap subscribe"), parameters: ["referrer" : referrer])
    }
    
    func logPurchaseSuccessEvent(referrer : String) {
        AppEvents.logEvent(AppEvents.Name(rawValue: "purchase success"), parameters: ["referrer" : referrer])
    }
    
}
