//
//  DRKEligibleViewControllerViewController.m
//  OurChild
//
//  Created by Jamie Daniel on 5/18/15.
//  Copyright (c) 2015 Duke Health. All rights reserved.
//

#import "DRKEligibleViewController.h"
#import "DMConsentTaskViewController.h"
#import "AppDelegate.h"
#import "DMSignUpInfoViewController.h"


@interface DRKEligibleViewController ()
@property (nonatomic, strong) ORKConsentDocument *document;
@end

@implementation DRKEligibleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goBack) name:@"GoBack" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goCreateAccont) name:@"GoAccount" object:nil];
    
}

-(void)goBack
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(IBAction)goConsent:(id)sender
{
    DMConsentTaskViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DMConsentTaskViewController"];
    [self presentViewController:vc animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)goCreateAccont
{
    [self.navigationController popToViewController:self animated:YES];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DMSignUpInfoViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"DMSignUpInfoViewController"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
