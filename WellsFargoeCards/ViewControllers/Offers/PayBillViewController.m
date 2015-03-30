//
//  PayBillViewController.m
//  eWallet
//
//  Created by Mummidi, Raja on 1/7/15.
//
//

#import "PayBillViewController.h"
#import "ServerCommunicator.h"
#import "CarouselViewController.h"
#import "Constant.h"
#import "DatabaseQueryHandler.h"
@interface PayBillViewController ()<ServerCommunicatorDelegate>
{
    float availableBalance;
}
@property(nonatomic, weak) IBOutlet UILabel *lblAvailableBalance;
@property(nonatomic, weak) IBOutlet UILabel *lblTotalAmountTobePaid;
@property(nonatomic, weak) IBOutlet UILabel *lblCVV;
@property(nonatomic, strong) IBOutlet UIView *viewFlipContainer;
@property(nonatomic, strong) IBOutlet UIView *viewCollectionVCContainer;
@property (nonatomic, strong) CarouselViewController *objCarouselViewCtrl;
@end

@implementation PayBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"Payment";
    
    self.lblTotalAmountTobePaid.text=[NSString stringWithFormat:@"$ %.2f",self.amountTobePaid];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivePanNotification:)
                                                 name:@"panGestureNotificaiton"
                                               object:nil];
    
  UIBarButtonItem*  mailbutton =[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(sendmail)];
    self.navigationItem.rightBarButtonItem=mailbutton;
    arrCreditCards=[[NSMutableArray alloc] init];
    objCardDetails=[[BankCard alloc] init];
    objCustomerDetails=[Customer sharedCustomer];
    [self setUpView];
    [self getCardDetailsByCardType];
    // Do any additional setup after loading the view from its nib.
}
-(void)sendmail
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
-(void)setUpView{
    
    //  _viewFlipContainer.layer.cornerRadius = 10;
    // _viewFlipContainer.layer.masksToBounds = YES;
    
    view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _viewFlipContainer.frame.size.width, _viewFlipContainer.frame.size.height)];
    view1.backgroundColor = [UIColor lightTextColor];
    view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _viewFlipContainer.frame.size.width, _viewFlipContainer.frame.size.height)];
    // view1.backgroundColor = [UIColor blackColor];
    view2.backgroundColor = [UIColor lightTextColor];
    [_viewFlipContainer addSubview:view1];
    [_viewFlipContainer sendSubviewToBack:view1];
    flipped = NO;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [_viewFlipContainer addGestureRecognizer:tapGesture];
    
//    LoadingView *loadingView =
//    [LoadingView loadingViewInView:view1];
//    [loadingView performSelector:@selector(removeView)
//                      withObject:nil
//                      afterDelay:0];
    
}
-(void)handleTap:(UITapGestureRecognizer *)sender
{
    
}
-(void)getCardDetailsByCardType
{
    ServerCommunicator *objServerCommunicator=[[ServerCommunicator alloc] init];
    objServerCommunicator.delegate=self;
    NSString *queryString=[NSString stringWithFormat:@"%@&dbo_customerid=%@",kGetCardsList,[objCustomerDetails strCustomerID]];
    NSLog(@"%@",queryString);
    [objServerCommunicator requestWithQuery:queryString];
    
        NSArray *arrResponse=[DatabaseQueryHandler getCustomerCardDetails:[objCustomerDetails strCustomerID]];
       [self didDownloadComplete:arrResponse];
    
}
- (void)didDownloadComplete:(NSArray *)arrResponse
{
    arrCreditCards=[[NSMutableArray alloc] init];
    
    for(NSDictionary *dict in arrResponse)
    {
        if([[dict objectForKey:@"type"] isEqualToString:@"Credit card"]){
            [arrCreditCards addObject:dict];
        }
    }
    isStatusReady=1;
    self.objCarouselViewCtrl = [[CarouselViewController alloc] init];
    self.objCarouselViewCtrl.arrCardsList=arrCreditCards;
    self.objCarouselViewCtrl.view.frame=CGRectMake(0, 0, _viewFlipContainer.frame.size.width, _viewFlipContainer.frame.size.height);
    [_viewFlipContainer addSubview:self.objCarouselViewCtrl.view];
    
    //display card details on initla view
    if([arrCreditCards count]>0){
        NSDictionary *dict=[arrCreditCards objectAtIndex:0];
        self.lblAvailableBalance.text=[NSString stringWithFormat:@"$ %@",[dict objectForKey:@"available_balance"]];
        availableBalance=[[dict objectForKey:@"available_balance"] floatValue];
        self.lblCVV.text=[NSString stringWithFormat:@"%@",[dict objectForKey:@"ccv"]];
    }
    
    
}

-(IBAction)cancelThePayment:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)processThePayment:(id)sender
{
    if(availableBalance>self.amountTobePaid){
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Status" message:@"Payment done Successfully " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alertView.tag=0;
        alertView.delegate=self;
        [alertView show];
    }else{
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Failed" message:@"Payment failed due to insufficient funds" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alertView.tag=1;
        alertView.delegate=self;
        [alertView show];
    }
    
 
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==1){
    
    }else{
    [self dismissViewControllerAnimated:YES completion:nil];
    // Handling tap gesture to show QRCode
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"changeTabbar"
     object:self];}
}

- (void) receivePanNotification:(NSNotification *) notification
{
    NSDictionary *dict=[notification userInfo];
    indexValue=0;
    indexValue=(int)[[dict objectForKey:@"index_value"] integerValue];
    if(indexValue>=[arrCreditCards count]){
        indexValue=indexValue-1;
    }
    NSLog(@"Current index value is %d,%lu",indexValue,(unsigned long)[arrCreditCards count]);
    if(indexValue>=[arrCreditCards count])
        indexValue=[arrCreditCards count]-1;
    NSDictionary *cardDetails=[arrCreditCards objectAtIndex:indexValue];
    [objCardDetails setCardDetails:cardDetails];
    availableBalance=objCardDetails.availableBalance;
    self.lblAvailableBalance.text=[NSString stringWithFormat:@"$ %.2f",objCardDetails.availableBalance];
    self.lblCVV.text=objCardDetails.strCVV;
    

}



@end
