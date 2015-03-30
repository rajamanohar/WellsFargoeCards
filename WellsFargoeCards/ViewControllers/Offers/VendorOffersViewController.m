//
//  VendorOffersViewController.m
//  eWallet
//
//  Created by Mummidi, Raja on 1/29/15.
//
//

#import "VendorOffersViewController.h"
#import "VendorOfferTableCell.h"
#import "Utility.h"
@interface VendorOffersViewController ()

@end

@implementation VendorOffersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  //  [Utility setTableViewBorderColor:self.tblCards];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [Utility setTableViewBorderColor:self.tblCards];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (BOOL)tableView:(UITableView *)tableView canCollapseSection:(NSInteger)section
{
    if (section>0) return NO;
    
    return NO;
}

#pragma mark - Table view data source
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section==0)
        return @"Bank Cards";
    else
        return @"Other Cards";
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  
        return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"newFriendCell";
    VendorOfferTableCell *cell;
    
    if (cell == nil) {
        cell = [[VendorOfferTableCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        UINib *nib = [UINib nibWithNibName:@"VendorOfferTableCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    }
    cell = (VendorOfferTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}

@end
