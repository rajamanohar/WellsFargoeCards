//
//  DisplayCardDetails.m
//  eWallet
//
//  Created by Mummidi, Raja on 12/23/14.
//
//

#import "DisplayCardDetails.h"

@interface DisplayCardDetails ()
@property (nonatomic, strong) IBOutlet UILabel *lblCarNumber;
@property (nonatomic, strong) IBOutlet UILabel *lblCardValidFrom;
@property (nonatomic, strong) IBOutlet UILabel *lblCardValidThru;
@property (nonatomic, strong) IBOutlet UILabel *lblNameonCard;
@property (nonatomic, strong) IBOutlet UIView *viewCardDetails;
@end

@implementation DisplayCardDetails
@synthesize lblCarNumber,lblCardValidFrom,lblCardValidThru,lblNameonCard,objCardDetails;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])){
        objCardDetails=[[BankCard alloc] init];
    }
    return self;
}
- (id)init
{
    self = [super init];
    if (self != nil)
    {
         objCardDetails=[[BankCard alloc] init]; // Further initialization if needed
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    lblCarNumber.text=[NSString stringWithFormat:@"%@ xxxx xxxx %@",[objCardDetails.strNumber substringToIndex:4],
                                             [objCardDetails.strNumber  substringFromIndex:
                                              [objCardDetails.strNumber  length]-4]];
    
    lblNameonCard.text=[NSString stringWithFormat:@"%@",objCardDetails.strNameOnCard];
    lblCardValidFrom.text=[NSString stringWithFormat:@"%@",objCardDetails.strValidFrom];
    lblCardValidThru.text=[NSString stringWithFormat:@"%@",objCardDetails.strValidThru];
    
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
