//
//  SettingsViewController.swift
//  MemoryCardGame
//
//  Created by Max on 11/03/2020.
//  Copyright © 2020 chulkov. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func resetRecord(_ sender: UIButton) {
        
        UserDefaults.standard.set(0.0, forKey: "bestTime")
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


