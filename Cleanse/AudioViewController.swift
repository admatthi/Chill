
//
//  AudioViewController.swift
//  Cleanse
//
//  Created by Alek Matthiessen on 10/27/19.
//  Copyright © 2019 The Matthiessen Group, LLC. All rights reserved.
//

import UIKit

class AudioViewController: UIViewController {
    @IBAction func tapRead(_ sender: Any) {
    }
    @IBAction func tapBack(_ sender: Any) {
    }
    @IBOutlet weak var headlinelabel: UILabel!
    
    @IBOutlet weak var durationlabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var timeelapsed: UILabel!
    @IBOutlet weak var notelabel: UILabel!
    @IBOutlet weak var authorlabel: UILabel!
    @IBOutlet weak var titlelabel: UILabel!
    @IBAction func tapPlayorPause(_ sender: Any) {
    }
    @IBOutlet weak var tapplayorpause: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

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
