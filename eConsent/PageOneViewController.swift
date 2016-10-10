//
//  PageOneViewController.swift
//  eConsent
//
//  Created by Ricky Bloomfield on 1/14/16.
//  Copyright © 2016 Duke Health. All rights reserved.
//

import UIKit
import MessageUI
import vfrReader

class PageOneViewController: UIViewController, MFMailComposeViewControllerDelegate, ReaderViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: IBActions
    
    // Opens a URL to the Qualtrics survey for the eConsent (argument "Arm=A")
    @IBAction func WebLink(sender: AnyObject) {
        if let url = NSURL(string: "https://duke.qualtrics.com/SE/?SID=SV_dbTMhT82hiVFOmh&Arm=A") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func reviewConsent(sender: UIButton) {
        
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let docsDir = dirPaths[0] 
        let document:ReaderDocument? = ReaderDocument(filePath: docsDir + "/" + CONSENT_FILENAME, password: "")
        
        if(document != nil){
            let readerViewController:ReaderViewController  = ReaderViewController(readerDocument: document)
            readerViewController.delegate = self
            readerViewController.modalTransitionStyle = .CrossDissolve
            readerViewController.modalPresentationStyle = .FullScreen
            self.navigationController?.navigationBarHidden = true
            self.presentViewController(readerViewController, animated: true, completion: nil)
            readerViewController.navigationController?.navigationBarHidden = false
        }
        
        else {
            let alertController = UIAlertController(title: "Signed Consent Not Available", message: "Please sign the consent and then try again.", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            
            presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func emailConsent(sender: UIButton) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    // MARK: MFMailComposeViewController
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients([MAIL_TO])
        mailComposerVC.setSubject("eConsent Documents")
        mailComposerVC.setMessageBody("New Consent Data", isHTML: false)
        
        // Add consent PDF if available
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let docsDir = dirPaths[0]
        let pdfFileName: String = (docsDir + "/" + CONSENT_FILENAME)
        let pdfData = NSData(contentsOfFile: pdfFileName)
        
        if (pdfData != nil) {
            mailComposerVC.addAttachmentData(pdfData!, mimeType: "application/pdf", fileName: CONSENT_FILENAME)
        }
        
        // Add *.csv if available
        let csvFileName: String = (docsDir + "/" + CSV_FILENAME)
        let csvData = NSData(contentsOfFile: csvFileName)
        
        if (csvData != nil) {
            mailComposerVC.addAttachmentData(csvData!, mimeType: "text/csv", fileName: CSV_FILENAME)
        }
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let alertController = UIAlertController(title: "Could Not Send Email", message: "Your device could not send the email. Please check your configuration and try again.", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        switch result.rawValue {
        case MFMailComposeResultCancelled.rawValue:
            print("Mail cancelled")
        case MFMailComposeResultSaved.rawValue:
            print("Mail saved")
        case MFMailComposeResultSent.rawValue:
            print("Mail sent")
        case MFMailComposeResultFailed.rawValue:
            print("Mail sent failure: \(error!.localizedDescription)")
        default:
            break
        }
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: ReaderViewControllerDelegate Method
    func dismissReaderViewController(viewController: ReaderViewController!) {
        
        // Dismiss the current controller (you can do something in the completion block if you want)
        viewController.dismissViewControllerAnimated(true, completion: {})
    }
}
