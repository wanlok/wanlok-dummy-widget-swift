//
//  LandingViewController.swift
//  dummyWidgetApp
//
//  Created by Robert Wan on 22/4/2025.
//

import UIKit

class LandingViewController: UIViewController {
    
    @IBOutlet weak var rateLabel: UILabel!

    let defaults = UserDefaults(suiteName: "com.wanlok.dummyWidgetApp")
    
    @IBAction func updateRate(_ sender: Any) {
        fetchAUDToUSDRate { rate in
            self.defaults?.set(rate, forKey: "rate")
            DispatchQueue.main.async {
                self.rateLabel.text = rate
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
