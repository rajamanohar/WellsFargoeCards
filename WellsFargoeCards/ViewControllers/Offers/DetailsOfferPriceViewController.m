//
//  DetailsOfferPriceViewController.m
//  eWallet
//
//  Created by Mummidi, Raja on 2/10/15.
//
//

#import "DetailsOfferPriceViewController.h"
#import "DisplayCartViewController.h"
#import "OffersDescriptionViewController.h"

@interface DetailsOfferPriceViewController ()<UIAlertViewDelegate>

@end

@implementation DetailsOfferPriceViewController
@synthesize strOfferSelection,strVendorName;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tbleOffers.layer.borderWidth=1.0f;
    self.tbleOffers.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.tbleOffers.layer.cornerRadius=2.0f;
    [self.tbleOffers.layer setMasksToBounds:YES];
    
    self.imgOffer.layer.borderWidth=1.0f;
    self.imgOffer.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.imgOffer.layer.cornerRadius=2.0f;
    [self.imgOffer.layer setMasksToBounds:YES];
  
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
     _imgOffer.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",strOfferSelection]];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section==0){
    UIView *headerview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    headerview.backgroundColor=[UIColor lightGrayColor];
    //headerview.alpha=0.5;
    UILabel *lblText=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 40)];
    lblText.text=@"Offer";
    lblText.font=[UIFont boldSystemFontOfSize:14];
    lblText.textColor=[UIColor whiteColor];
    [headerview addSubview:lblText];
    
    UILabel *lblDiscount=[[UILabel alloc] initWithFrame:CGRectMake(tableView.frame.size.width-80, 5, tableView.frame.size.width, 40)];
    lblDiscount.text=@"Value";
    lblDiscount.font=[UIFont boldSystemFontOfSize:14];
    lblDiscount.textColor=[UIColor whiteColor];
    [headerview addSubview:lblDiscount];
    return headerview;
    }else if(section==1){
        UIView *headerview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
        headerview.backgroundColor=[UIColor lightGrayColor];
        //headerview.alpha=0.5;
        UILabel *lblText=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 40)];
        lblText.text=@"Offer Summery";
        lblText.font=[UIFont boldSystemFontOfSize:14];
        lblText.textColor=[UIColor whiteColor];
        [headerview addSubview:lblText];
    
        return headerview;

    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
    return 2;
    else return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    
    UILabel *lblText=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, cell.frame.size.width, 40)];
    lblText.font=[UIFont boldSystemFontOfSize:13];
    lblText.textColor=[UIColor blackColor];
    [cell addSubview:lblText];
    
    UILabel *lblDiscount=[[UILabel alloc] initWithFrame:CGRectMake(cell.frame.size.width-60, 5, cell.frame.size.width, 40)];
    lblDiscount.font=[UIFont boldSystemFontOfSize:13];
    lblDiscount.textColor=[UIColor blackColor];
    [cell addSubview:lblDiscount];
    if(indexPath.section==0){
        if(indexPath.row==0){
            lblText.text=strOfferSelection;
            lblDiscount.text=@"$ 10,000";
        }else if(indexPath.row==1){
            lblText.text=@"Addintional Offer";
            lblDiscount.text=@"$ 1000";
        }
    }else   if(indexPath.section==1){
     
            lblText.text=strOfferSelection;
            lblDiscount.text=@"$ 11,000";
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}
-(IBAction)clickAddtoCart:(id)sender
{
    DisplayCartViewController *objDisplayCartVC=  [DisplayCartViewController sharedMySingleton];
    objDisplayCartVC.numberofItems=objDisplayCartVC.numberofItems+1;
     objDisplayCartVC.lblItemsCount.text=[NSString stringWithFormat:@"%d",objDisplayCartVC.numberofItems] ;
     NSMutableDictionary *dictSelectedOffers=[[NSMutableDictionary alloc] init];
    if([objDisplayCartVC.dictOffers objectForKey:strVendorName]){
        dictSelectedOffers=[objDisplayCartVC.dictOffers objectForKey:strVendorName];
    }
    
    NSMutableArray *arrselectedItems=[[NSMutableArray alloc] init];
    
    if([dictSelectedOffers objectForKey:strOfferSelection]){
        arrselectedItems=[dictSelectedOffers objectForKey:strOfferSelection];
    }

        NSMutableDictionary *dictSpeicifiedOffer=[[NSMutableDictionary alloc] init];
        [dictSpeicifiedOffer  setValue:strOfferSelection forKey:@"offer_name"];
        [dictSpeicifiedOffer  setValue:@"10000" forKey:@"offer_price"];
        [dictSpeicifiedOffer  setValue:@"1000" forKey:@"discount_price"];
        [arrselectedItems  addObject:dictSpeicifiedOffer];
    
        [dictSelectedOffers setObject:arrselectedItems forKey:strOfferSelection];
    
        [objDisplayCartVC.dictOffers setObject:dictSelectedOffers forKey:strVendorName];
    
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Status" message:@"Successfully added to the cart" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    alertView.delegate=self;
    [alertView show];
    
    
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
   [self.navigationController popViewControllerAnimated:NO];
    
}
-(IBAction)displayOfferDetails:(id)sender
{
    OffersDescriptionViewController *objOfferDesc=[self.storyboard instantiateViewControllerWithIdentifier:@"OffersDescriptionVC"];
    [self presentViewController:objOfferDesc animated:YES completion:nil];
}
@end
/*
 1.Pay $10,000  using Wells Fargo Debit or                 Credit cards and get addintional amount of      $ 500 from this discount card
 
 2.Costco giving this special offers to only Wells  Fargo card holders.
 
 3.Customer can use this discount card money at any time until the expiray date.
 
 4. Unless the card is used before the expiry.Only the paid amount will be credited to your card.
 */
