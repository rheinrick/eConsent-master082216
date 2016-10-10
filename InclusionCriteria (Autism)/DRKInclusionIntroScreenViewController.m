//
//  DRKInclusionIntroScreenViewController.m
//  OurChild
//
//  Created by Duke  on 7/31/15.
//  Copyright (c) 2015 Duke Health. All rights reserved.
//

#import "DRKInclusionIntroScreenViewController.h"
#import "DRKInclusionCriteriaTableViewController.h"

@interface DRKInclusionIntroScreenViewController ()


@end

@implementation DRKInclusionIntroScreenViewController

- (void)viewDidLoad {
    [self.navigationController setNavigationBarHidden:NO];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goInclusionCriteria:(id)sender {
    DRKInclusionCriteriaTableViewController *tvc = [self.storyboard instantiateViewControllerWithIdentifier:@"DRKInclusionCriteriaTableViewController"];
    [self.navigationController pushViewController:tvc animated:YES];
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
