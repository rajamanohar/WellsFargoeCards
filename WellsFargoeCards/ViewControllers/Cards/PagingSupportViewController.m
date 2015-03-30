//
//  PagingSupportViewController.m
//  eWallet
//
//  Created by Mummidi, Raja on 2/2/15.
//
//

#import "PagingSupportViewController.h"

@interface PagingSupportViewController ()

@end

@implementation PagingSupportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    self.imgCurrentBanner.image=[UIImage imageNamed:[NSString stringWithFormat:@"offer_banner%ld.jpg",(long)self.indexNumber]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
