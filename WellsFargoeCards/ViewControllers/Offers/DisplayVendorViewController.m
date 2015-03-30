//
//  DisplayVendorViewController.m
//  eWallet
//
//  Created by Mummidi, Raja on 2/9/15.
//
//

#import "DisplayVendorViewController.h"
#import  "GenericCollectionViewController.h"
#import "Utility.h"
@interface DisplayVendorViewController ()<GenericCollectionVCDelegate>
{
    BOOL flipped;
    NSArray *arrSpecialDays;
    GenericCollectionViewController *objGenericCollectionVC;
}

@property(nonatomic,strong) UIView *view1,*view2;
@property(nonatomic,strong) IBOutlet UIView *viewCollectionVCContainer;

@end

@implementation DisplayVendorViewController
@synthesize strSelectedVendorName;

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeTabbarProgramatically:)
                                                 name:@"changeTabbar"
                                               object:nil];
    
    
      _objDetailsOfferPriceViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"DetailsOfferPriceVC"];
    // Do any additional setup after loading the view from its nib.
    _objDetailsOfferPriceViewController.strVendorName=strSelectedVendorName;
    self.navigationItem.title=[NSString stringWithFormat:@"%@ Future Offers",self.strBackgroundImage];
    self.imgBackground.image=[UIImage imageNamed:
                                      [NSString stringWithFormat:@"%@_logo.jpeg",self.strBackgroundImage]];
   [self.imgBackground removeFromSuperview];
    arrSpecialDays=@[@"Special Offer",@"Boxing Day",@"Memorial Day",@"Thanksgiving Day",@"Veterans Day"];
   
  
    _objDetailsOfferPriceViewController.arrSpecialDays=arrSpecialDays;
}


- (void) changeTabbarProgramatically:(NSNotification *) notification
{
    [self.tabBarController setSelectedIndex:0];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.rightBarButtonItem=self.mailbutton;
    //[self.tbleOffers removeFromSuperview];
    [_view1 addSubview:self.tbleOffers];
    [Utility setTableViewBorderColor:self.tbleOffers];
     [self setUpView];
   
    self.txtDescription.text=[NSString stringWithFormat:@"%@ is offering prebooking sales. Customer can block the certain amount and get addinational 20%% of cash as benefit. ",self.strSelectedVendorName];
}
-(void)viewDidAppear:(BOOL)animated
{
     [self prepareFeaturesCollectionview];
}

-(void)prepareFeaturesCollectionview
{
    /// Adding collection view to display card features
    UICollectionViewFlowLayout *aFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    // [aFlowLayout setItemSize:CGSizeMake(130, 130)];
    [aFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    aFlowLayout.sectionInset = UIEdgeInsetsMake(5.0f, 5.0f, 10.0f, 5.0f);
    aFlowLayout.itemSize = CGSizeMake(145.0f, 150.0f);
    aFlowLayout.minimumInteritemSpacing = 20.0f;
    
    objGenericCollectionVC =[[GenericCollectionViewController alloc] initWithCollectionViewLayout:aFlowLayout];
    objGenericCollectionVC.collectionVCDelegate=self;
     objGenericCollectionVC.strCustomerCellName=@"OffersCVCell";
    objGenericCollectionVC.arrServiceOfferings=arrSpecialDays;
    objGenericCollectionVC.collectionView.frame=CGRectMake(0,0,self.viewCollectionVCContainer.frame.size.width,self.viewCollectionVCContainer.frame.size.height-60);
    objGenericCollectionVC.collectionView.backgroundColor=[UIColor clearColor];
    self.viewCollectionVCContainer.backgroundColor=[UIColor clearColor];
    [self.viewCollectionVCContainer addSubview:objGenericCollectionVC.view];
}

-(void)requestTheService:(NSString *)serviceName
{
    _objDetailsOfferPriceViewController.strOfferSelection=serviceName;
    [UIView transitionWithView:self.view
                      duration:1
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        
                        if (!flipped) {
                            [_view1 removeFromSuperview]; //or hide it.
                            [self.view addSubview:_view2];
                            flipped = YES;
                        } else {
                            //  [_view1 removeFromSuperview];
                            [_view2 removeFromSuperview]; //or hide it.
                            [self.view addSubview:_view1];
                            [objGenericCollectionVC.view removeFromSuperview];
                            [self.viewCollectionVCContainer addSubview:objGenericCollectionVC.view];
                            flipped = NO;
                        }
                        
                    } completion:nil];
}


-(void)setUpView{
    
    //  _viewFlipContainer.layer.cornerRadius = 10;
    // _viewFlipContainer.layer.masksToBounds = YES;
    
    _view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
  //  _view1.backgroundColor = [UIColor lightTextColor];
    _view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    // view1.backgroundColor = [UIColor blackColor];
    
    [_view2 addSubview:_objDetailsOfferPriceViewController.view];
    
  //  _view2.backgroundColor = [UIColor lightTextColor];
    [self.view addSubview:_view1];
    [self.view sendSubviewToBack:_view1];
    flipped = NO;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapGesture.numberOfTapsRequired=2;
    [self.view addGestureRecognizer:tapGesture];
    
// LoadingView *loadingView = //   [LoadingView loadingViewInView:view1];
    
//    [loadingView
//     performSelector:@selector(removeView)
//     withObject:nil
//     afterDelay:5.0];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)handleTap:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        [UIView transitionWithView:self.view
                          duration:1
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        animations:^{
                            
                            if (!flipped) {
                                [_view1 removeFromSuperview]; //or hide it.
                                [self.view addSubview:_view2];
                                flipped = YES;
                            } else {
                                //  [_view1 removeFromSuperview];
                                [_view2 removeFromSuperview]; //or hide it.
                                [self.view addSubview:_view1];
                                [objGenericCollectionVC.view removeFromSuperview];
                                 [self.viewCollectionVCContainer addSubview:objGenericCollectionVC.view];
                                flipped = NO;
                            }
                            
                        } completion:nil];
    }
}

@end
