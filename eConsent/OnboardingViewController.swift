/*
Copyright (c) 2015, Apple Inc. All rights reserved.

Additions by Ricky Bloomfield
Copyright © 2016 Duke Health. All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1.  Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.

2.  Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation and/or
other materials provided with the distribution.

3.  Neither the name of the copyright holder(s) nor the names of any contributors
may be used to endorse or promote products derived from this software without
specific prior written permission. No license is granted to the trademarks of
the copyright holders even if such marks are included in this software.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import UIKit
import ResearchKit

class OnboardingViewController: UIViewController {
    // MARK: IB actions
    
    @IBAction func joinButtonTapped(sender: UIButton) {
        
        // Remove any consent documents if present (i.e., from prior uses of the app)
        let fileManager = NSFileManager.defaultManager()
        var docURL = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last
        docURL = docURL?.URLByAppendingPathComponent(CONSENT_FILENAME)
        
        var pdfDoc: CGPDFDocumentRef!
        pdfDoc = CGPDFDocumentCreateWithURL(docURL)
        
        if(pdfDoc != nil) { // Delete PDF when starting new consent process
            do {
                try fileManager.removeItemAtURL(docURL!)
                print("Deleted file at path: \(docURL)")
            } catch let error as NSError {
                print("Failed to delete file: \(error.localizedDescription)")
            }
        }
        
        let consentDocument = ConsentDocument()
        let consentStep = ORKVisualConsentStep(identifier: "VisualConsentStep", document: consentDocument)
        
        let signature = consentDocument.signatures!.first!
        
        let reviewConsentStep = ORKConsentReviewStep(identifier: "ConsentReviewStep", signature: signature, inDocument: consentDocument)
        
        reviewConsentStep.text = "Review the consent form."
        reviewConsentStep.reasonForConsent = "Consent to join the eConsent Study."
        
            
        let completionStep = ORKCompletionStep(identifier: "CompletionStep")
        completionStep.title = "Thank you!"
        completionStep.text = "We appreciate your time."
        
        let orderedTask = ORKOrderedTask(identifier: "Join", steps: [consentStep, reviewConsentStep, completionStep])
        let taskViewController = ORKTaskViewController(task: orderedTask, taskRunUUID: nil)
        taskViewController.delegate = self
        
        presentViewController(taskViewController, animated: true, completion: nil)

    }
}

extension OnboardingViewController : ORKTaskViewControllerDelegate {
    
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason: ORKTaskViewControllerFinishReason, error: NSError?) {
        switch reason {
            case .Completed:
                print("Task was completed.")
                
                var resultsDict = [String: String]()
                var stepCounter = 1 // Remove this later
                
                // Get name
                let signatureResult : ORKConsentSignatureResult = taskViewController.result.stepResultForStepIdentifier("ConsentReviewStep")?.firstResult as! ORKConsentSignatureResult
                
                if (signatureResult.consented == true) {
                    print("User consented.")
                    
                    let firstName : String = signatureResult.signature!.givenName!
                    let lastName : String = signatureResult.signature!.familyName!
                    
                    resultsDict["FirstName"] = firstName
                    resultsDict["LastName"] = lastName
                    
                    // Get detailed results data here
                    if let results = taskViewController.result.results as? [ORKStepResult] {
                        
                        for stepResult: ORKStepResult in results {
                            
                            print(stepCounter)
                            stepCounter+=1
                            
                            let dateFormatter = NSDateFormatter()
                            dateFormatter.dateFormat = "YYYY/MM/DD hh:mm:ss"
                            let startDateString = dateFormatter.stringFromDate(stepResult.startDate!)
                            let endDateString = dateFormatter.stringFromDate(stepResult.endDate!)
                            let duration = stepResult.endDate!.timeIntervalSinceDate((stepResult.startDate)!)
                            
                            resultsDict[stepResult.identifier + "StartDate"] = startDateString
                            resultsDict[stepResult.identifier + "EndDate"] = endDateString
                            resultsDict[stepResult.identifier + "Duration"] = String(duration)
                            
                            for result in stepResult.results! as [ORKResult] { // Can get more detailed data here if needed
                                
                                if let questionResult = result as? ORKQuestionResult {
                                    print("\(questionResult.identifier), \(questionResult.answer)")
                                }
                                else if let fileResult = result as? ORKFileResult {
                                    print("\(fileResult.identifier), \(fileResult.fileURL)")
                                }
                                else{
                                    print("No printable results.")
                                }
                            }
                        }
                    }
                    
                    print("Results dictionary is: \(resultsDict)")
                    
                    // Generate and write PDF to file
                    let document = ConsentDocument() as ORKConsentDocument
                    signatureResult.applyToDocument(document)
                    
                    document.makePDFWithCompletionHandler({ (pdfData:NSData?, error: NSError?) -> Void in
                        
                        var docURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last
                        docURL = docURL?.URLByAppendingPathComponent(CONSENT_FILENAME)
                        
                        // Write to the Documents Directory.
                        pdfData?.writeToURL(docURL!, atomically: true)
                        
                        print("PDF created and stored at \(docURL)")
                        
                    })
                    
                    // Generate and write *.csv to file
                    let headerArray = Array(resultsDict.keys) // Get array of dictionary keys to iterate over
                    var dataArray: [String] = []
                    for String in headerArray {
                        dataArray.append(resultsDict[String]!)
                    }
                    
                    let headerCSV: String = headerArray.joinWithSeparator(",") // Header row joined by commas
                    let dataCSV: String = dataArray.joinWithSeparator(",") // Data joined by commas
                    
                    let csvString = headerCSV + "\r" + dataCSV // Complete CSV string
                    
                    // Write *.csv to Documents Directory
                    let data = csvString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
                    if let data = data {
                        var csvURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last
                        csvURL = csvURL?.URLByAppendingPathComponent(CSV_FILENAME)
                        data.writeToURL(csvURL!, atomically: true)
                    }
                } else {
                    print("User did not consent.")
                }
                
                performSegueWithIdentifier("unwindToOnboarding", sender: nil)
            
            case .Discarded:
                print("Task was discarded.")
                dismissViewControllerAnimated(true, completion: nil)
            
            case .Failed:
                print("Task failed.")
                dismissViewControllerAnimated(true, completion: nil)
            
            case .Saved:
                print("Task was saved.")
                dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func taskViewController(taskViewController: ORKTaskViewController, viewControllerForStep step: ORKStep) -> ORKStepViewController? {
        /*if step is HealthDataStep {
            let healthStepViewController = HealthDataStepViewController(step: step)
            return healthStepViewController
        }*/
        
        return nil
    }
}
