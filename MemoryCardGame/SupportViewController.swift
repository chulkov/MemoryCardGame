//
//  SupportViewController.swift
//  MemoryCardGame
//
//  Created by Max on 11/03/2020.
//  Copyright © 2020 chulkov. All rights reserved.
//

import UIKit
import MessageUI

class SupportViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func sendEmailButton(_ sender: UIButton) {
        sendEmail()
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["vopros973@gmail.com"])
            mail.setMessageBody("<p>Enter your problem</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            let alert = UIAlertController(title: "Error", message: "Your device have no ability to send emails", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
}
