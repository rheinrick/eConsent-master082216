//
//  DRKInclusionCriteriaTableViewController.h
//  OurChild
//
//  Created by Jamie Daniel on 5/18/15.
//  Copyright (c) 2015 Duke Health. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APCSegmentedButton.h"
@class CountryPicker;

@interface DRKInclusionCriteriaTableViewController : UITableViewController <APCSegmentedButtonDelegate>

@property (weak, nonatomic) IBOutlet UILabel *question1Label;
@property (weak, nonatomic) IBOutlet UILabel *question2Label;
@property (weak, nonatomic) IBOutlet UILabel *question3Label;
@property (weak, nonatomic) IBOutlet UILabel *question4Label;
@property (weak, nonatomic) IBOutlet UILabel *question5Label;

@property (weak, nonatomic) IBOutlet UIButton *question10Option1;
@property (weak, nonatomic) IBOutlet UIButton *question10Option2;
@property (weak, nonatomic) IBOutlet UIButton *question20Option1;
@property (weak, nonatomic) IBOutlet UIButton *question20Option2;
@property (weak, nonatomic) IBOutlet UIButton *question30Option1;
@property (weak, nonatomic) IBOutlet UIButton *question30Option2;
@property (weak, nonatomic) IBOutlet UIButton *question40Option1;
@property (weak, nonatomic) IBOutlet UIButton *question40Option2;
@property (weak, nonatomic) IBOutlet UIButton *question50Option1;
@property (weak, nonatomic) IBOutlet UIButton *question50Option2;

@property (nonatomic, strong) NSArray *questions; // of APCSegmentedButtons

@property (weak, nonatomic) IBOutlet CountryPicker *countryPicker;

-(void)goOnboarding;


@end
