//
//  DisplayCartViewController.m
//  eWallet
//
//  Created by Mummidi, Raja on 2/4/15.
//
//

#import "DisplayCartViewController.h"
#import "DisplayCartTableViewCell.h"
#import "PayBillViewController.h"
@interface DisplayCartViewController ()
{
    NSMutableArray *arrSelectedVendors;
        float totalAmount ,actualAmount ,additionalAmount;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barbtnClose;
@property(nonatomic,strong) IBOutlet UILabel *lblActualAmount;
@property(nonatomic,strong) IBOutlet UILabel *lblTotalAmount;
@property(nonatomic,strong) IBOutlet UILabel *lblAdditionalAmount;
@property(nonatomic,strong) PayBillViewController *objPayBillViewController;


@end

static DisplayCartViewController *sharedMyManager = nil;


@implementation DisplayCartViewController
@synthesize lblItemsCount;

+(DisplayCartViewController*)sharedMySingleton
{
    @synchronized([DisplayCartViewController class])
    {
        if (!sharedMyManager)
            sharedMyManager=[[self alloc] init];
        
        
        return sharedMyManager;
    }
    
    return nil;
}


- (id)init {
    if (self = [super init]) {
       // someProperty = [[NSString alloc] initWithString:@"Default Property Value"];
        lblItemsCount=[[UILabel alloc] initWithFrame:CGRectMake(10, 2, 20, 15)];
        lblItemsCount.textColor=[UIColor whiteColor];
        lblItemsCount.font=[UIFont boldSystemFontOfSize:14];
        lblItemsCount.text=@"0";
        _numberofItems=0;
        self.dictOffers=[[NSMutableDictionary alloc] init];
     
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
        self.navigationItem.title=@"Cart";
    lblItemsCount.text=[NSString stringWithFormat:@"%d",_numberofItems];
       arrSelectedVendors=[[NSMutableArray alloc] init];
    for(NSString *vendorName in self.dictOffers){
        [arrSelectedVendors addObject:vendorName];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
        self.edgesForExtendedLayout = UIRectEdgeNone;
    UIBarButtonItem*  mailbutton =[[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(sendmail)];
    self.navigationItem.rightBarButtonItem=mailbutton;

    // Do any additional setup after loading the view from its nib.
}
-(void)sendmail
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)viewDidAppear:(BOOL)animated
{
    [self.tblOffers reloadData];
    totalAmount =0,actualAmount =0,additionalAmount=0;
    for(NSString *vendorName in self.dictOffers){
        
        NSMutableDictionary *dictOffers=[self.dictOffers objectForKey:vendorName];
   
        for(NSString *offerName in [dictOffers allKeys] ){
            NSArray *arrOffers=[dictOffers objectForKey:offerName];
            for(NSDictionary *dict in arrOffers){
            
                actualAmount+=[[dict  objectForKey:@"offer_price"] floatValue ];
                additionalAmount+=[[dict  objectForKey:@"discount_price"]floatValue];
          
           
            }
            
        }
    }
    totalAmount=additionalAmount+actualAmount;
    
    self.lblActualAmount.text=[NSString stringWithFormat:@"$ %.2f",actualAmount];
    self.lblAdditionalAmount.text=[NSString stringWithFormat:@"$ %.2f",additionalAmount];
    self.lblTotalAmount.text=[NSString stringWithFormat:@"$ %.2f",totalAmount];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)closeBtn:(id)sender
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dictOffers count];
    
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
    return  [[self.dictOffers objectForKey:[arrSelectedVendors objectAtIndex:section]] count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    UILabel *lblText=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 40)];
    lblText.text=[arrSelectedVendors objectAtIndex:section];
    lblText.font=[UIFont boldSystemFontOfSize:14];
    //lblText.textAlignment=NSTextAlignmentCenter;
    [headerView addSubview:lblText];
    return headerView;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    DisplayCartTableViewCell *cell;
    
    if (cell == nil) {
        cell = [[DisplayCartTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SimpleTableCell"];
        UINib *nib = [UINib nibWithNibName:@"DisplayCartTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:@"SimpleTableCell"];
    }
    cell = (DisplayCartTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"SimpleTableCell"];
    
    
    NSMutableDictionary *dictOffers=[self.dictOffers objectForKey:[arrSelectedVendors objectAtIndex:indexPath.section]];
    
    for(NSString *offerName in [dictOffers allKeys] ){
            NSArray *arrOffers=[dictOffers objectForKey:offerName];
            NSDictionary *dict=[arrOffers objectAtIndex:indexPath.row];
            cell.lblOfferName.text=[dict  objectForKey:@"offer_name"];
            float value=[[dict  objectForKey:@"offer_price"] floatValue ]+[[dict  objectForKey:@"discount_price"]floatValue];
            cell.lblOfferWorth.text=[NSString stringWithFormat:@"$ %.2f",value];
            cell.txtOfferQty.text=[NSString stringWithFormat:@"%d",[arrOffers count]];
            cell.imgOffer.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", cell.lblOfferName.text]];
        
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    return 85;
}
-(IBAction)onClickProccedtoPay:(id)sender
{
    self.objPayBillViewController=[[PayBillViewController alloc] initWithNibName:@"PayBillViewController" bundle:nil];
    
    self.objPayBillViewController.amountTobePaid=actualAmount;
    [self.navigationController pushViewController:self.objPayBillViewController animated:YES];
}
@end
