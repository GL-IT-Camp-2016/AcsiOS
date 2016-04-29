//
//  ViewController.swift
//  ACS
//
//  Created by Roman Hauptvogel on 29/04/16.
//  Copyright © 2016 GLACS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var distanceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.distanceLabel.text = "nejaký text"
        // Do any additional setup after loading the view, typically from a nib.=
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

