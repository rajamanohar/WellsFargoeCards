//
//  OffersDescriptionViewController.m
//  WellsFargoeCards
//
//  Created by Mummidi, Raja on 2/19/15.
//  Copyright (c) 2015 Mummidi, Raja. All rights reserved.
//

#import "OffersDescriptionViewController.h"

@interface OffersDescriptionViewController ()

@end

@implementation OffersDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)closePresentViewController:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
