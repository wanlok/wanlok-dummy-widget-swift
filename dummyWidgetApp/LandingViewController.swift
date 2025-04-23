//
//  LandingViewController.swift
//  dummyWidgetApp
//
//  Created by Robert Wan on 22/4/2025.
//

import UIKit
import WidgetKit

class LandingViewController: UIViewController {
    
    @IBOutlet weak var rateLabel: UILabel!

    let defaults = UserDefaults(suiteName: "group.com.wanlok.dummyWidgetApp")
    
    @IBAction func updateRate(_ sender: Any) {
        fetchAUDToUSDRate { rate in
            self.defaults?.set(rate, forKey: "rate")
            DispatchQueue.main.async {
                self.rateLabel.text = rate
            }
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
    
    @IBAction func onClearButtonClick(_ sender: Any) {
        defaults?.removeObject(forKey: "rate")
        rateLabel.text = "-"
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let rate = defaults?.object(forKey: "rate") as? String {
            rateLabel.text = rate
        } else {
            rateLabel.text = "-"
        }
    }
}
