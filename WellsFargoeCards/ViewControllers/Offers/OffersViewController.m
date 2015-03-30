//
//  OffersViewController.m
//  eWallet
//
//  Created by Mummidi, Raja on 1/29/15.
//
//

#import "OffersViewController.h"
#import "CardDetailsViewController.h"
#import <QuartzCore/QuartzCore.h>
//#import "ShopCategoriesListViewController.h"
//#import "ContainerCollectionViewController.h"
#import "OffersTableViewCell.h"
#import "DisplayVendorViewController.h"
#import "DisplayCartViewController.h"
@interface OffersViewController ()
{
    UIBarButtonItem *mailbutton;
    UILabel *lblItemsCount;
}
@property(nonatomic,strong) NSArray *arrVendorsList;
@property(nonatomic, strong) CardDetailsViewController *objCardsDetails;
@end

@implementation OffersViewController
@synthesize objContainerPageViewCtrl;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
 
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title=@"Vendor List";
    self.arrOfferHeaders =@[@"Vendors"];
    self.arrVendorsList  =@[@"Costco",@"J.C.Penny",@"Kohl's",@"Macy's",@"Sears",@"Target",@"Wal-Mart"];
    self.arrOfferBanners =@[@"offer_banner1.jpg",@"offer_banner2.jpg",@"offer_banner3.jpg",@"offer_banner4.jpg"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.backBarButtonItem.title=@"Back";
    self.tblCards.layer.borderWidth=1;
    self.tblCards.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    
    
    UIImage* image3 = [UIImage imageNamed:@"cart.png"];
    CGRect frameimg = CGRectMake(0, 0, 24, 24);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];

    [someButton setBackgroundImage:image3 forState:UIControlStateNormal];
    DisplayCartViewController *objDisplayCartViewController=[DisplayCartViewController sharedMySingleton];
    [someButton addSubview:objDisplayCartViewController.lblItemsCount];
    someButton.alpha=0.4;
    [someButton addTarget:self action:@selector(sendmail)
         forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    
    mailbutton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    self.navigationItem.rightBarButtonItem=mailbutton;
    
}
-(void)sendmail
{
    DisplayCartViewController *objDisplayCartViewController=[DisplayCartViewController sharedMySingleton];
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:objDisplayCartViewController];
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
-(void)viewDidAppear:(BOOL)animated
{
//    objContainerPageViewCtrl=[self.storyboard instantiateViewControllerWithIdentifier:@"ContainerPageVC"];
//    objContainerPageViewCtrl.view.frame=CGRectMake(0, 0,self.view.frame.size.width, self.viewFlipContainer.frame.size.height);
//    [self.view addSubview:objContainerPageViewCtrl.view];
    
    [self.view bringSubviewToFront:self.tblCards];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.arrOfferHeaders count];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrVendorsList count];
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 60)];
//    UILabel *lblText=[[UILabel alloc] initWithFrame:CGRectMake((tableView.frame.size.width/2)-20, 5, 200, 40)];
//    lblText.text=[self.arrOfferHeaders objectAtIndex:section];
//    lblText.font=[UIFont boldSystemFontOfSize:15];
//   // lblText.textAlignment=NSTextAlignmentCenter;
//    [headerView addSubview:lblText];
//    headerView.backgroundColor=[UIColor lightGrayColor];
//   // lblText.backgroundColor=[UIColor grayColor];
//    return headerView;
//    
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"SimpleTableCell";
    OffersTableViewCell *cell;
    
    if (cell == nil) {
        cell = [[OffersTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        UINib *nib = [UINib nibWithNibName:@"OffersTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    }
    cell = (OffersTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"SimpleTableCell"];
    cell.lblVendorName.text=[self.arrVendorsList objectAtIndex:indexPath.row];
    cell.imgLogo.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@_logo.jpeg",[self.arrVendorsList objectAtIndex:indexPath.row]]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //cell.backgroundColor=[UIColor lightGrayColor];
   // cell.alpha=0.2;
    return cell;
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DisplayVendorViewController *objDisplayVendorViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"DisplayVendorVC"];
    objDisplayVendorViewController.strBackgroundImage=[self.arrVendorsList objectAtIndex:indexPath.row];
    objDisplayVendorViewController.strSelectedVendorName=[self.arrVendorsList objectAtIndex:indexPath.row];
    objDisplayVendorViewController.mailbutton=mailbutton;
    [self.navigationController pushViewController:objDisplayVendorViewController animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 90;
}
-(void)dismissModalViewControllerAnimated
{
    
}
@end
