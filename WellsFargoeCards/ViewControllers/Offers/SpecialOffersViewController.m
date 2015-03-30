//
//  SpecialOffersViewController.m
//  WellsFargoeCards
//
//  Created by Mummidi, Raja on 2/17/15.
//  Copyright (c) 2015 Mummidi, Raja. All rights reserved.
//

#import "SpecialOffersViewController.h"
#import "GenericCollectionViewController.h"
@interface SpecialOffersViewController ()<GenericCollectionVCDelegate>
{
    NSArray *arrOffers;
}
@property(nonatomic,strong) IBOutlet UIView *viewCollectionVCContainer;
@property(nonatomic,strong)  GenericCollectionViewController *objGenericCollectionVC;
@end

@implementation SpecialOffersViewController
@synthesize objGenericCollectionVC;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"Special Offers";
    arrOffers=@[@"Bags",@"Cameras",@"Health Care",@"Home Decor",@"Kitchen Appliances",@"Laptops",@"Men Apparels",@"Mobile Accessories",@"Mobiles",@"Perfumes",@"Watches",@"Women Apparels"];
    // Do any additional setup after loading the view.
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    aFlowLayout.sectionInset = UIEdgeInsetsMake(20.0f, 20.0f, 10.0f, 20.0f);
    aFlowLayout.itemSize = CGSizeMake(130.0f, 120.0f);
    aFlowLayout.minimumInteritemSpacing = 20.0f;
    
    objGenericCollectionVC =[[GenericCollectionViewController alloc] initWithCollectionViewLayout:aFlowLayout];
    objGenericCollectionVC.collectionVCDelegate=self;
    objGenericCollectionVC.strCustomerCellName=@"cvCell";
  
        objGenericCollectionVC.arrServiceOfferings=arrOffers;
   
    objGenericCollectionVC.collectionView.frame=CGRectMake(0,0,self.viewCollectionVCContainer.frame.size.width,self.viewCollectionVCContainer.frame.size.height);
    
    objGenericCollectionVC.collectionView.backgroundColor=[UIColor clearColor];
    objGenericCollectionVC.collectionView.scrollEnabled=YES;
    objGenericCollectionVC.collectionView.bounces = YES;
    self.viewCollectionVCContainer.backgroundColor=[UIColor clearColor];
    [self.viewCollectionVCContainer addSubview:objGenericCollectionVC.view];
}
-(void)requestTheService:(NSString *)serviceName
{
}
@end
