//
//  ProductDescpViewController.m
//  eWallet
//
//  Created by Mummidi, Raja on 2/4/15.
//
//

#import "ProductDescpViewController.h"
#import "DisplayCartViewController.h"

@interface ProductDescpViewController ()

@end

@implementation ProductDescpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
-(IBAction)selectContinue:(id)sender
{
    DisplayCartViewController *objDisplayCartViewController=[[DisplayCartViewController alloc] initWithNibName:@"DisplayCartViewController" bundle:nil];
    [self presentViewController:objDisplayCartViewController animated:YES completion:nil];
    
}
@end
