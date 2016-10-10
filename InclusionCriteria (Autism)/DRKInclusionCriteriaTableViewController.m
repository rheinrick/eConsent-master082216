//
//  DRKInclusionCriteriaTableViewController.m
//  OurChild
//
//  Created by Jamie Daniel on 5/18/15.
//  Copyright (c) 2015 Duke Health. All rights reserved.
//

#import "DRKInclusionCriteriaTableViewController.h"
#import "DRKEligibleViewController.h"
#import "DRKIneligibleViewController.h"
#import "UIColor+APCAppearance.h"
#import "UIFont+APCAppearance.h"
#import "DMAnalytics.h"
#import "CountryPicker.h"
#import "DMCountryStore.h"

@interface DRKInclusionCriteriaTableViewController () <APCSegmentedButtonDelegate>

@end

@implementation DRKInclusionCriteriaTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    UIBarButtonItem *next = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Next", nil) style:UIBarButtonItemStylePlain target:self action:@selector(next)];
    self.navigationItem.rightBarButtonItem = next;
    self.navigationItem.rightBarButtonItem.enabled = NO; // disable next until a question is answered

    UIColor *normalColor = [UIColor colorWithRed:0.822 green:0.822 blue:0.822 alpha:1.0]; // hairline color
    UIColor *highlightColor = DUKE_MEDICINE_BLUE;
    
    self.questions = @[
                   [[APCSegmentedButton alloc] initWithButtons:@[_question10Option1, _question10Option2] normalColor:normalColor highlightColor:highlightColor],
                   [[APCSegmentedButton alloc] initWithButtons:@[_question20Option1, _question20Option2] normalColor:normalColor highlightColor:highlightColor],
//                   [[APCSegmentedButton alloc] initWithButtons:@[_question30Option1, _question30Option2] normalColor:normalColor highlightColor:highlightColor],
                   [[APCSegmentedButton alloc] initWithButtons:@[_question40Option1, _question40Option2] normalColor:normalColor highlightColor:highlightColor],
                   [[APCSegmentedButton alloc] initWithButtons:@[_question50Option1, _question50Option2] normalColor:normalColor highlightColor:highlightColor]
                   ];
    [self.questions enumerateObjectsUsingBlock:^(APCSegmentedButton * obj, NSUInteger __unused idx, BOOL __unused *stop) {
        obj.delegate = self;
    }];

    
    [self setUpAppearance];
    self.countryPicker.selectedCountryCode = [[NSLocale currentLocale] objectForKey: NSLocaleCountryCode];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goOnboarding) name:@"goBack" object:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    // Resolves navigation bar disappearing with other integrated navigation controller actions
    [self.navigationController setNavigationBarHidden:NO];
}

-(BOOL)isEligible
{
    APCSegmentedButton *question1 = self.questions[0];
    APCSegmentedButton *question2 = self.questions[1];
//    APCSegmentedButton *question3 = self.questions[2];
    APCSegmentedButton *question4 = self.questions[2];
    APCSegmentedButton *question5 = self.questions[3];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self in %@", [DMCountryStore enrollingCountryCodes]];
    BOOL supportedCountry = [predicate evaluateWithObject:self.countryPicker.selectedCountryCode];
    
    return (question1.selectedIndex == 0) &&
       (question2.selectedIndex == 0) &&
//       (question3.selectedIndex == 0) &&
       (question4.selectedIndex == 0) &&
       supportedCountry &&
       (question5.selectedIndex == 0)
        ;
}

-(void)next
{
    [DMCountryStore setCountryCode:self.countryPicker.selectedCountryCode];
    
    if ([self isEligible]) {
        [DMAnalytics logEvent:kAnalyticsEventEligible withParameters:nil timed:NO];
        DRKEligibleViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DRKEligibleViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [DMAnalytics logEvent:kAnalyticsEventIneligible withParameters:nil timed:NO];
        DRKIneligibleViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DRKIneligibleViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void) setUpAppearance
{
    UIFont *labelFont = [UIFont appRegularFontWithSize:16.0f];
    UIFont *optionFont = [UIFont appQuestionOptionFont];

    {
        _question1Label.textColor = [UIColor appSecondaryColor1];
        _question1Label.font = labelFont;
        
        [self.question10Option1.titleLabel setFont:optionFont];
        [self.question10Option2.titleLabel setFont:optionFont];
    }
    
    {
        self.question2Label.textColor = [UIColor appSecondaryColor1];
        self.question2Label.font = labelFont;
        
        [self.question20Option1.titleLabel setFont:optionFont];
        [self.question20Option2.titleLabel setFont:optionFont];
    }
    
//    {
//        self.question3Label.textColor = [UIColor appSecondaryColor1];
//        self.question3Label.font = labelFont;
//        
//        [self.question30Option1.titleLabel setFont:optionFont];
//        [self.question30Option2.titleLabel setFont:optionFont];
//    }
    
    {
        self.question4Label.textColor = [UIColor appSecondaryColor1];
        self.question4Label.font = labelFont;
        
        [self.question40Option1.titleLabel setFont:optionFont];
        [self.question40Option2.titleLabel setFont:optionFont];
    }

    {
        self.question5Label.textColor = [UIColor appSecondaryColor1];
        self.question5Label.font = labelFont;
        
        [self.question50Option1.titleLabel setFont:optionFont];
        [self.question50Option2.titleLabel setFont:optionFont];
    }
}



-(void)goOnboarding
{
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}

- (BOOL)isContentValid
{
    __block BOOL retValue = YES;
    [self.questions enumerateObjectsUsingBlock:^(APCSegmentedButton* obj, NSUInteger __unused idx, BOOL *stop) {
        if (obj.selectedIndex == -1) {
            retValue = NO;
            *stop = YES;
        }
    }];
    
    return retValue;
}

#pragma mark - Segmented Button Delegate
/*********************************************************************************/
- (void)segmentedButtonPressed:(UIButton *)__unused button selectedIndex:(NSInteger)__unused selectedIndex
{
    self.navigationItem.rightBarButtonItem.enabled = [self isContentValid];
}


@end
