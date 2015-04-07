//
//  CardDetailsViewController.m
//  iCarouselExample
//
//  Created by Mummidi, Raja on 12/19/14.
//
//

#import "CardDetailsViewController.h"
#import "DatabaseQueryHandler.h"
#import "LoadingView.h"
#import "Constant.h"
#import "SpecialOffersViewController.h"
@interface CardDetailsViewController ()
{
    NSArray *arrBankCardServiceOfferings;
    NSArray *arrRewardCardServiceOfferings;
    NSArray *arrDiscountCardSericeOfferings;
}

@property(nonatomic, weak) IBOutlet UIImageView *imgQRCode;
@property(nonatomic, weak) IBOutlet UILabel *lblAvailableBalance;
@property(nonatomic, weak) IBOutlet UILabel *lblCVV;
@property(nonatomic, strong) IBOutlet UIView *viewFlipContainer;
@property(nonatomic, strong) IBOutlet UIView *viewCollectionVCContainer;
@property(nonatomic, strong) IBOutlet UIImageView *imgCard;

@property(nonatomic, strong) CarouselViewController *objCarouselViewCtrl;
@property(nonatomic,strong)   SupportViewController *objSupportViewCtrl;
@property(nonatomic,strong)   TransactionsViewController *objTransactionViewCtrl;
@property(nonatomic,strong)   AddCardViewController *objAddViewContrl;
@property(nonatomic,strong)   ManageCardViewController *objManageCardViewCtrl;
@property(nonatomic,strong)   SpecialOffersViewController *objSpecialOffersViewCtrl;
@end

@implementation CardDetailsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    index=0;
    arrBankCardServiceOfferings=@[@"Statements",@"Manage Card",@"Support",@"Add-on Card"];
    arrRewardCardServiceOfferings=@[@"Statements",@"Special Offers",@"Support",@"Redeem Points"];
    arrDiscountCardSericeOfferings=@[@"Statements",@"Special Offers",@"Support",@"Generate Gift Card"];
    
    objCardDetails=[[BankCard alloc] init];
    objCustomerDetails=[Customer sharedCustomer];
 
    
    self.navigationItem.title=self.strSelectedCardType;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:)
                                                 name:@"tapGestureNotificaiton"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivePanNotification:)
                                                 name:@"panGestureNotificaiton"
                                               object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{   //Fetch the card by card type
    isStatusReady=0;
    indexValue=0;
    [self getCardDetailsByCardType];
 
}

-(void)viewDidAppear:(BOOL)animated
{
       [self prepareFeaturesCollectionview];
      view1.frame = CGRectMake(0, 0, self.view.frame.size.width, _viewFlipContainer.frame.size.height);
       self.objCarouselViewCtrl.view.frame=CGRectMake(0, 0, self.view.frame.size.width, _viewFlipContainer.frame.size.height);
      view2.frame = CGRectMake(0, 0, self.view.frame.size.width, _viewFlipContainer.frame.size.height);
     [self setUpView];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpView{

    [view1 removeFromSuperview];
    [view2 removeFromSuperview];
    [self.objCarouselViewCtrl.view removeFromSuperview];
    
    
    view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, _viewFlipContainer.frame.size.height)];
    view1.backgroundColor = [UIColor lightTextColor];
    
    self.objCarouselViewCtrl = [[CarouselViewController alloc] init];
    self.objCarouselViewCtrl.arrCardsList=arrCreditCards;
    self.objCarouselViewCtrl.view.frame=CGRectMake(0, 0, self.view.frame.size.width, _viewFlipContainer.frame.size.height);
    [_viewFlipContainer addSubview:self.objCarouselViewCtrl.view];
    
    
    view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, _viewFlipContainer.frame.size.height)];
    // view1.backgroundColor = [UIColor blackColor];
    //view2.backgroundColor = [UIColor redColor];
    
    [_viewFlipContainer addSubview:view1];
    [_viewFlipContainer sendSubviewToBack:view1];
    flipped = NO;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [_viewFlipContainer addGestureRecognizer:tapGesture];
    
    LoadingView *loadingView =
    [LoadingView loadingViewInView:view1];
    [loadingView performSelector:@selector(removeView)
                                  withObject:nil
                                   afterDelay:0];
    
}
-(void)prepareFeaturesCollectionview
{
    /// Adding collection view to display card features
    UICollectionViewFlowLayout *aFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    // [aFlowLayout setItemSize:CGSizeMake(130, 130)];
    [aFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    aFlowLayout.sectionInset = UIEdgeInsetsMake(20.0f, 20.0f, 10.0f, 20.0f);
    aFlowLayout.itemSize = CGSizeMake(130.0f, 120.0f);
    aFlowLayout.minimumInteritemSpacing = 20.0f;
    
    objGenericCollectionVC =[[GenericCollectionViewController alloc] initWithCollectionViewLayout:aFlowLayout];
    objGenericCollectionVC.collectionVCDelegate=self;
    objGenericCollectionVC.strCustomerCellName=@"cvCell";
    if([self.strSelectedCardType isEqualToString:@"Rewards card"]){
        objGenericCollectionVC.arrServiceOfferings=arrRewardCardServiceOfferings;
    }
    else if([self.strSelectedCardType isEqualToString:@"Discount card"]){
        objGenericCollectionVC.arrServiceOfferings=arrDiscountCardSericeOfferings;
    }else{
        objGenericCollectionVC.arrServiceOfferings=arrBankCardServiceOfferings;
    }
    objGenericCollectionVC.collectionView.frame=CGRectMake(0,0,self.viewCollectionVCContainer.frame.size.width,self.viewCollectionVCContainer.frame.size.height);
    
    objGenericCollectionVC.collectionView.backgroundColor=[UIColor clearColor];
    objGenericCollectionVC.collectionView.scrollEnabled=YES;
    objGenericCollectionVC.collectionView.bounces = YES;
    self.viewCollectionVCContainer.backgroundColor=[UIColor clearColor];
    [self.viewCollectionVCContainer addSubview:objGenericCollectionVC.view];
}


-(void)getCardDetailsByCardType
{
    [arrCreditCards removeAllObjects];
    arrCreditCards=nil;
   arrCreditCards=[[NSMutableArray alloc] init];
    
    ServerCommunicator *objServerCommunicator=[[ServerCommunicator alloc] init];
    objServerCommunicator.delegate=self;
    NSString *queryString=[NSString stringWithFormat:@"%@&dbo_customerid=%@",kGetCardsList,[objCustomerDetails strCustomerID]];
    NSLog(@"%@",queryString);
    //[objServerCommunicator requestWithQuery:queryString];
    
       NSArray *arrResponse=[DatabaseQueryHandler getCustomerCardDetails:[objCustomerDetails strCustomerID]];
       [self didDownloadComplete:arrResponse];
    
}
- (void)didDownloadComplete:(NSArray *)arrResponse
{
      for(NSDictionary *dict in arrResponse){
          if([[dict objectForKey:@"type"] isEqualToString:self.strSelectedCardType]){
              [arrCreditCards addObject:dict];
          }
      }
    isStatusReady=1;
   
    
    //display card details on initla view
    if([arrCreditCards count]>0){
        NSDictionary *dict=[arrCreditCards objectAtIndex:0];
    self.lblAvailableBalance.text=[NSString stringWithFormat:@"$ %@",[dict objectForKey:@"available_balance"]];
    self.lblCVV.text=[NSString stringWithFormat:@"%@",[dict objectForKey:@"ccv"]];
    }
   
}


- (void) receiveTestNotification:(NSNotification *) notification
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    [UIView transitionWithView:_viewFlipContainer
                      duration:1
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        
                        if (!flipped) {
                            [self.objCarouselViewCtrl.view setHidden:YES];
                            //view2.backgroundColor = [UIColor orangeColor];
                            [_viewFlipContainer addSubview:view2];
                            flipped = YES;
                        } else {
                            [self.objCarouselViewCtrl.view setHidden:NO];
                            [view2 removeFromSuperview]; //or hide it.
                            flipped = NO;
                        }
                        
                    } completion:nil];
    
    if ([[notification name] isEqualToString:@"TestNotification"])
        NSLog (@"Successfully received the test notification!");
    
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
    
    self.lblAvailableBalance.text=[NSString stringWithFormat:@"$ %.2f",objCardDetails.availableBalance];
    self.lblCVV.text=objCardDetails.strCVV;
    
    
    NSString *qrCodeString = [NSString stringWithFormat:@"wf_scanner;%@;%@;%@;%@;%@;%@;%@;%@;%f;%@",[cardDetails objectForKey:@"number"],objCustomerDetails.strName,
                                                                                                                                                                                 objCustomerDetails.strDOB,objCustomerDetails.strEmail,objCustomerDetails.strPhone,
                                                                                                                                                                                objCardDetails.strNameOnCard,objCardDetails.strType,objCardDetails.strValidThru,
                                                                                                                                                                                objCardDetails.availableBalance,objCardDetails.strProvider];
    
    NSLog(@"%@",qrCodeString);
    CIImage *image = [self createQRForString:qrCodeString];
    UIImage *qrImage = [self createNonInterpolatedUIImageFromCIImage:image withScale:5*[[UIScreen mainScreen] scale]];
    UIImageView *qrCodeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(view2.frame.size.width/2-100, _viewFlipContainer.frame.size.height/2-70, 200, 150)];
    qrCodeImageView.image = qrImage;
    _imgQRCode.image=qrImage;
    //self.navigationItem.title=@"Back";
    [view2 addSubview:qrCodeImageView];
    
}


#pragma mark - QR Code Scanning Methods

- (CIImage *)createQRForString:(NSString *)qrString
{
    // Need to convert the string to a UTF-8 encoded NSData object
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    // Create the filter
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // Set the message content and error-correction level
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    // Send the image back
    return qrFilter.outputImage;
}

- (UIImage *)createNonInterpolatedUIImageFromCIImage:(CIImage *)image withScale:(CGFloat)scale
{
    // Render the CIImage into a CGImage
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:image fromRect:image.extent];
    
    // Now we'll rescale using CoreGraphics
    UIGraphicsBeginImageContext(CGSizeMake(image.extent.size.width * scale, image.extent.size.width * scale));
    CGContextRef context = UIGraphicsGetCurrentContext();
    // We don't want to interpolate (since we've got a pixel-correct image)
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    // Get the image out
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // Tidy up
    UIGraphicsEndImageContext();
    CGImageRelease(cgImage);
    return scaledImage;
}

- (void)handleTap:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        [UIView transitionWithView:_viewFlipContainer
                          duration:1
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        animations:^{
                            
                            if (!flipped) {
                                    [self.objCarouselViewCtrl.view setHidden:YES];
                                    view2.backgroundColor = [UIColor lightGrayColor];
                                    [_viewFlipContainer addSubview:view2];
                              
                                    flipped = YES;
                            } else {
                                    [self.objCarouselViewCtrl.view setHidden:NO];
                                    [view2 removeFromSuperview]; //or hide it.
                                    flipped = NO;
                            }
                            
                        } completion:nil];
    }
}

-(IBAction)OnClickStatements:(id)sender
{
    self.objTransactionViewCtrl=[self.storyboard instantiateViewControllerWithIdentifier:@"transactionsVC"];
    self.objTransactionViewCtrl.strCustomerID=objCustomerDetails.strCustomerID;
    [self.navigationController pushViewController:self.objTransactionViewCtrl animated:YES];
}


-(IBAction)OnClickShare:(id)sender
{
    self.objManageCardViewCtrl=[self.storyboard instantiateViewControllerWithIdentifier:@"manageCardVC"];
    self.objManageCardViewCtrl.strCustomerID=objCustomerDetails.strCustomerID;
    self.objManageCardViewCtrl.objCardDetails=objCardDetails;
    [self.navigationController pushViewController:self.objManageCardViewCtrl animated:YES];
}


-(IBAction)OnClickSupport:(id)sender
{
    self.objSupportViewCtrl=[self.storyboard instantiateViewControllerWithIdentifier:@"supportVC"];
    [self.navigationController pushViewController:self.objSupportViewCtrl animated:YES];
}


-(IBAction)OnClickAddCard:(id)sender
{
    self.objAddViewContrl=[self.storyboard instantiateViewControllerWithIdentifier:@"addCardVC"];
    self.objAddViewContrl.objBankCard=objCardDetails;
    [self.navigationController pushViewController:self.objAddViewContrl animated:YES];

}
-(IBAction)OnClickShowSpecialOffers:(id)sender
{
    self.objSpecialOffersViewCtrl=[self.storyboard instantiateViewControllerWithIdentifier:@"SpecialOffersVC"];
    //self.objSpecialOffersViewCtrl.objCardDetails=objCardDetails;
    [self.navigationController pushViewController:self.objSpecialOffersViewCtrl animated:YES];
    
}


-(IBAction)changeStyle:(id)sender
{
    self.objCarouselViewCtrl.carousel.type = index++;
   
    if(index>5)
        index=0;
}


-(void)requestTheService:(NSString *)serviceName
{
    if([serviceName isEqualToString:@"Statements"]){
        [self OnClickStatements:nil];
    }else if([serviceName isEqualToString:@"Support"]){
          [self OnClickSupport:nil];
    }else if([serviceName isEqualToString:@"Manage Card"]){
          [self OnClickShare:nil];
    }else if([serviceName isEqualToString:@"Add-on Card"]){
          [self OnClickAddCard:nil];
    }
    else if([serviceName isEqualToString:@"Special Offers"]){
        [self OnClickShowSpecialOffers:nil];
    }
}

@end
