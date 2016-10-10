/*
Copyright (c) 2015, Apple Inc. All rights reserved.

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

import ResearchKit

class ConsentDocument: ORKConsentDocument {
    // MARK: Properties
    
    let ipsum = [
        "Vivamus laoreet erat sit amet tincidunt scelerisque. Maecenas odio sapien, molestie eu vulputate sodales, tincidunt at neque. Nunc venenatis velit et ligula dictum, eget accumsan felis consectetur. Donec scelerisque fermentum vestibulum. Nam molestie finibus mauris, id congue lectus ultrices eu. Nunc et odio vitae dui interdum dictum. Proin sagittis leo quam. Proin vulputate massa ac orci pulvinar, eget rhoncus urna congue. Sed ut vehicula tellus, eget scelerisque enim. Cras lobortis diam at faucibus scelerisque. Curabitur pharetra arcu erat, nec tincidunt mi eleifend ut. Nunc suscipit risus vitae consectetur sodales. Aenean vitae lectus odio. Phasellus diam orci, accumsan non elementum at, finibus condimentum mauris. Nullam est enim, rhoncus a rutrum sed, laoreet a magna.",
        "Duis euismod sollicitudin elementum. Interdum et malesuada fames ac ante ipsum primis in faucibus. Sed at pharetra sapien. Pellentesque cursus laoreet interdum. Nunc mi sapien, congue vel eleifend in, luctus sit amet massa. Nam tempus metus nec mauris bibendum, vel suscipit quam aliquet. Vestibulum sagittis mi et tempus iaculis. Integer varius eros non sagittis elementum. Proin dictum magna sit amet nulla volutpat posuere eget ac mi. Cras aliquam tristique velit nec porttitor. Integer nulla ligula, vestibulum a ullamcorper non, volutpat non nibh. Integer auctor ipsum id leo pharetra, vitae dapibus augue sagittis. Proin ut diam non orci vulputate rutrum a et nulla. Maecenas in varius augue, eu pretium metus. In auctor ornare augue ac sodales.",
        "Aenean in ligula quis arcu rhoncus tristique. Donec ut nisl suscipit augue ornare venenatis. Suspendisse commodo nibh dignissim, congue justo quis, ultrices sapien. Aliquam at lacinia ante. Sed venenatis quam eget dui lobortis, non ullamcorper tellus molestie. Quisque tempus fringilla velit, et viverra odio accumsan quis. Suspendisse potenti. Nullam ac dolor nunc. Pellentesque nec scelerisque risus. Interdum et malesuada fames ac ante ipsum primis in faucibus. Phasellus consectetur efficitur rutrum. Suspendisse in arcu id ex luctus aliquam quis at quam.",
        "Maecenas quis varius massa. Nam in dapibus turpis, ut varius eros. Proin a ex enim. Sed faucibus magna vel tincidunt facilisis. Donec id ligula vel mi suscipit sollicitudin. Nulla non magna blandit, semper augue vel, sagittis dui. Curabitur quis rutrum ex. Sed ipsum odio, mattis et dignissim sit amet, volutpat et turpis. Sed quis placerat orci. Duis vitae bibendum diam.",
        "Sed nec tortor sapien. Quisque tempor scelerisque vulputate. Nulla eget consequat urna. Aliquam tempus sagittis orci vel tempus. Mauris porta ante sed maximus iaculis. Etiam elit purus, pretium nec ipsum non, aliquam commodo erat. Aliquam sagittis, nibh at porta pellentesque, libero purus finibus nulla, sed consectetur tellus sem non nisl. Duis eu sollicitudin orci. Quisque tincidunt feugiat sapien ac accumsan. Nullam vitae fringilla quam.",
        "Integer tristique, nulla nec auctor consectetur, justo dolor sagittis erat, vel laoreet erat turpis vitae dui. Praesent purus tellus, eleifend faucibus sapien id, egestas mollis turpis. Fusce enim lorem, ornare quis ligula a, mattis feugiat diam. Praesent ullamcorper fringilla urna sollicitudin convallis. Curabitur eget dapibus ipsum, ac suscipit mauris. In hac habitasse platea dictumst. Vestibulum non hendrerit ex.",
        "Nulla convallis ligula ornare efficitur ullamcorper. Vivamus erat enim, malesuada sit amet dolor ac, tristique blandit felis. Praesent a ante ac nisi tempor elementum. Mauris ligula tellus, porttitor eu vehicula eget, condimentum sed nisi. Donec pharetra lacus tincidunt sapien dignissim iaculis. Duis id ultrices tortor, at congue dolor. Donec consequat fringilla leo, eu congue nulla suscipit non.",
        "Sed convallis, ligula vel egestas commodo, mauris nisl tincidunt arcu, id tristique est nunc sit amet felis. Curabitur tortor dolor, ullamcorper vitae pulvinar egestas, venenatis a sem. Cras sit amet maximus magna. Vivamus auctor nisi quis felis mattis, vel sagittis purus pulvinar. Nunc tristique nibh mauris, at eleifend arcu sodales nec. Curabitur rhoncus rutrum metus, ac pretium ante tempor sed. Sed vehicula placerat felis, nec interdum nisl fringilla eu. Nunc iaculis sit amet massa fringilla rhoncus. Maecenas consequat, risus eget commodo suscipit, lorem ex condimentum orci, et sollicitudin nisi eros sed lectus. Sed at erat nisl. Nunc venenatis mi tellus, vitae congue erat dictum a."
    ]
    
    // MARK: Initialization
    
    override init() {
        super.init()
        
        title = NSLocalizedString("eConsent Study Consent Form", comment: "")
        
        /*
        
        let sectionTypes: [ORKConsentSectionType] = [
            .Overview,
            .DataGathering,
            .Privacy,
            .DataUse,
            .TimeCommitment,
            .StudySurvey,
            .StudyTasks,
            .Withdrawing
        ]
        
        sections = zip(sectionTypes, ipsum).map { sectionType, ipsum in
            let section = ORKConsentSection(type: sectionType)
            
            let localizedIpsum = NSLocalizedString(ipsum, comment: "")
            let localizedSummary = localizedIpsum.componentsSeparatedByString(".")[0] + "."
            
            section.summary = localizedSummary
            section.content = localizedIpsum
            
            return section
        }

    */
        
        // MARK:  Custom Screens
        
        let consentDocument = ORKConsentDocument()
        consentDocument.title = "eConsent"
        
        let consentSection01 = ORKConsentSection(type: .Custom)
        consentSection01.title = "Welcome"
        consentSection01.summary = "This is a research study about health tracking apps. We do not know if they improve health. You may choose if you want to join the study or not."
        consentSection01.content = "You are being asked to participate in a research study to collect data on your activity level and nutritional habits. You will also be asked whether you use apps on mobile devices to track your health. Mobile apps are widely used to track nutrition and activity levels. Creators of these apps claim that they have health benefits. These claims require additional evidence of improvements in health for their users.  Research studies are a method of collecting evidence to see if the claims are accurate.\n\nResearch studies are voluntary and include only people who choose to take part. Please read this consent form carefully and take your time making your decision. We encourage you to talk with your family and friends before you decide to take part in this research study. The nature of the study, risks, inconveniences, discomforts, and other important information about the study are listed below. This study is being conducted by Richard Bloomfield, Jr., MD."
        
        let consentSection02 = ORKConsentSection(type: .Custom)
        consentSection02.title = "Purpose"
        consentSection02.summary = "Health tracking apps may affect what people choose to eat and how much people exercise. This study will try to figure out if they make a difference."
        consentSection02.content = "The purpose of this study is to compare activity levels and nutritional habits between adults who track these habits with mobile apps and those who do not to assess the impact of nutrition and activity trackers on health."
        
        let consentSection03 = ORKConsentSection(type: .Custom)
        consentSection03.title = "Size"
        consentSection03.summary = "Up to 120 people will be in the study."
        consentSection03.content = "Up to 120 people will participate in this study at Duke."
        
        let consentSection04 = ORKConsentSection(type: .Custom)
        consentSection04.title = "Study Survey"
        consentSection04.summary = "You will be asked to answer some questions. They may be about which apps you use, your exercise, your diet, and any chronic diseases you may have."
        consentSection04.content = "If you agree to be in this study, you will be asked to provide consent after reading through this document. You will then be asked to answer several questions about your use of health tracking apps, your level of activity, your nutritional habits, and your health history.\n\nThe survey given through this study will ask the following: 1) which nutrition or activity tracking apps you use or have used and how frequently you use them; 2) how much you exercise in a given week and what types of exercise you do; 3) what types of food you eat regularly and nutrition strategies that you use; and 4) whether you have any chronic health conditions. Following the survey you will be asked to provide your demographic information (such as your age, gender and education level) , as well as your name and date of birth.\n\nAfter reading and signing the consent form, participation in the survey should take you less than 5 minutes. You will not be told how you compare to other study participants. Following the survey you will be asked if you would like to provide your email address in order to receive updates about the study as well as links to resources for nutrition and exercise advice. This is completely voluntary and is not required for completion of the study. Your contact information will not be shared with other research studies or with third parties for promotional use. By providing your email address you may be contacted in two to four weeks to answer some follow-up questions to determine whether your health habits have changed.\n\nYou may also be asked questions regarding the consent process during the survey."
        
        let consentSection05 = ORKConsentSection(type: .Custom)
        consentSection05.title = "Time Commitment"
        consentSection05.summary = "This study will take 5 to 10 minutes. You may be asked follow-up questions in two to four weeks."
        consentSection05.content = "Your participation in this study will last approximately 10 minutes, including the consent process. If you choose to participate in a follow-up survey, we may re-contact you within 1 month via e-mail. You may choose to withdraw from the study at any time."
        
        let consentSection06 = ORKConsentSection(type: .Custom)
        consentSection06.title = "Risks"
        consentSection06.summary = "Your private data may be exposed in this study. We will do everything we can to prevent this."
        consentSection06.content = "There are no significant risks associated with this study. The main risk is to the confidentiality of your health responses (exposure of your information). You will be asked to complete a survey on your use of health tracking apps, level of activity, nutritional habits, health, and demographics. These data will be stored in a main study database available only to the study investigators. To personalize your experience, we are asking you to provide your name, date of birth, and zip code. In addition, to prevent the unintended exposure of your information, we will use a random code instead of your name for the analytic database (the one that will be used for research). We will only associate your date of birth, zip code, e-mail address, and time and date stamps of your consent and completing activities, with the random number generator. These data will be encrypted and stored on a secure, password-protected Duke Box account, and access is limited to the study team.. Your privacy is very important to us and the study will make every effort to protect your privacy and the confidentiality of your data, but that cannot be completely guaranteed. Your coded data (without your name) will be combined with data from other participants for analysis by Duke researchers.\n\nThe data collected by the survey will not be reviewed by a physician or advanced healthcare provider for medical evaluation. We are not asking you to make any health decisions based on this study. You should discuss health decisions directly with your healthcare provider. You and/or your health insurance must pay for any services, supplied, procedures, and care that you require during this study for routine medical care."
        
        let consentSection07 = ORKConsentSection(type: .Custom)
        consentSection07.title = "Benefits"
        consentSection07.summary = "This study may benefit patients in the future. Your info will not be used by your doctor."
        consentSection07.content = "We cannot and do not guarantee or promise that you will receive any benefits from this study.  Your participation may help others who are participating in future research."
        
        let consentSection08 = ORKConsentSection(type: .Custom)
        consentSection08.title = "Privacy"
        consentSection08.summary = "Your info will only be accessed by the study team. Your info will only be shared if required by law."
        consentSection08.content = "Study records that identify you will be kept confidential as required by law. Federal Privacy Regulations provide safeguards for privacy, security, and authorized access. Except when required by law or for your care, you will not be identified by name, social security number, address, telephone number, or any other direct personal identifier in study records disclosed outside of Duke University. For records disclosed outside of Duke University, you will be assigned a unique code number. The key to the code will be kept securely at DUHS.\n\nYour study records may be reviewed in order to meet federal or state regulations. Reviewers may include the Duke University Health System Institutional Review Board. If this information is disclosed to outside reviewers for audit purposes, it may be further disclosed by them and may not be covered by the federal privacy regulations.\n\nThe study results will be retained for at least six years after the study is completed. At that time information identifying you will be removed from such study results at Duke University.\n\nWhile the information and data resulting from this study may be presented at scientific meetings or published in a scientific journal, your identity will not be revealed."
        
        let consentSection09 = ORKConsentSection(type: .Custom)
        consentSection09.title = "Costs"
        consentSection09.summary = "There are no costs for being in the study."
        consentSection09.content = "There is no costs to you or your insurance for taking part in the study."
        
        let consentSection10 = ORKConsentSection(type: .Custom)
        consentSection10.title = "Compensation"
        consentSection10.summary = "You will be able to enter a raffle for a 16GB iPod Touch."
        consentSection10.content = "You will not be compensated for your participation in this study.  However, you will be eligible to enter a raffle for a 16GB iPod Touch by participating in this study."
        
        let consentSection11 = ORKConsentSection(type: .Custom)
        consentSection11.title = "Injuries"
        consentSection11.summary = "Duke will not reimburse you or give free care for any injuries."
        consentSection11.content = "Immediate necessary medical care is available at Duke University Medical Center in the event that you are injured as a result of your participation in this research study. However, there is no commitment by Duke University, Duke University Health System, Inc., or Duke physicians to provide monetary compensation or free medical care to you in the event of a study-related injury.\n\nFor questions about the study or research-related injury, contact Richard Bloomfield, Jr., MD at 919-636-5565."
        
        let consentSection12 = ORKConsentSection(type: .Custom)
        consentSection12.title = "Withdrawing"
        consentSection12.summary = "You may choose to withdraw from the study at any time."
        consentSection12.content = "You may choose not to be in the study, or, if you agree to be in the study, you may withdraw from the study at any time. If you withdraw from the study, no new data about you will be collected for study purposes other than data needed to keep track of your withdrawal.\n\nIn this study we may ask you questions that you do not want to answer or are uncomfortable answering and this may influence your or willingness to stay in this study. The principal investigator or regulatory agencies may stop this study at any time without your consent. If this occurs, you will be notified by email if you have provided your email address."
        
        let consentSection13 = ORKConsentSection(type: .OnlyInDocument)
        consentSection13.title = "Contact"
        consentSection13.summary = ""
        consentSection13.content = "For questions about the study or if you have problems, concerns, questions or suggestions about the research, contact Richard Bloomfield, Jr., MD at 919-636-5565 during regular business hours, after hours and on weekends and holidays or by sending an email to ricky.bloomfield@duke.edu.\n\nFor questions about your rights as a research participant, or to discuss problems, concerns or suggestions related to the research, or to obtain information or offer input about the research, contact the Duke University Health System Institutional Review Board (IRB) Office at (919) 668-5111."
        
        sections = [consentSection01, consentSection02, consentSection03, consentSection04, consentSection05, consentSection06, consentSection07, consentSection08, consentSection09, consentSection10, consentSection11, consentSection12, consentSection13]
        
        // END CUSTOM SCREENS

        let signature = ORKConsentSignature(forPersonWithTitle: "Participant", dateFormatString: nil, identifier: "ConsentDocumentParticipantSignature")
        addSignature(signature)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ORKConsentSectionType: CustomStringConvertible {

    public var description: String {
        switch self {
            case .Overview:
                return "Overview"
                
            case .DataGathering:
                return "DataGathering"
                
            case .Privacy:
                return "Privacy"
                
            case .DataUse:
                return "DataUse"
                
            case .TimeCommitment:
                return "TimeCommitment"
                
            case .StudySurvey:
                return "StudySurvey"
                
            case .StudyTasks:
                return "StudyTasks"
                
            case .Withdrawing:
                return "Withdrawing"
                
            case .Custom:
                return "Custom"
                
            case .OnlyInDocument:
                return "OnlyInDocument"
        }
    }
}