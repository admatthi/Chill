//
//  PaywallViewController.swift
//  Cleanse
//
//  Created by Alek Matthiessen on 10/27/19.
//  Copyright © 2019 The Matthiessen Group, LLC. All rights reserved.
//

import UIKit

class PaywallViewController: UIViewController {

    @IBAction func tapRestore(_ sender: Any) {
        
        
    }
    @IBAction func tapBack(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func tapContinue(_ sender: Any) {
    }
    @IBOutlet weak var tapcontinue: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

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