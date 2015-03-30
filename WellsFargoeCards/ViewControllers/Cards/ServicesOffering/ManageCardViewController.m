//
//  ManageCardViewController.m
//  eWallet
//
//  Created by Mummidi, Raja on 1/7/15.
//
//

#import "ManageCardViewController.h"
#import "DisplayCardDetails.h"
@interface ManageCardViewController ()

@end

@implementation ManageCardViewController
@synthesize objCardDetails;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.navigationItem.title=@"Manage Cards";
     // objCardDetails=[[CardDetails alloc] init];
    self.tblCards.layer.borderWidth=1.0f;
    self.tblCards.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.tblCards.layer.cornerRadius=2.0f;
    [self.tblCards.layer setMasksToBounds:YES];
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
-(void)viewWillAppear:(BOOL)animated
{
    
    DisplayCardDetails *objDisplayCardDetails=[[DisplayCardDetails alloc]init];
    objDisplayCardDetails.objCardDetails=objCardDetails;
    objDisplayCardDetails.view.frame=CGRectMake(self.imgCardView.frame.origin.x+30, self.imgCardView.frame.size.height-120,self.imgCardView.frame.size.width-30, 100);
    objDisplayCardDetails.view.backgroundColor=[UIColor clearColor];
    
    [self.imgCardView addSubview:objDisplayCardDetails.view];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    if(indexPath.row==0){
        cell.textLabel.text = @"Unbilled Transactions";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if(indexPath.row==1){
        
        cell.textLabel.text = @"Pay the bill";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if(indexPath.row==2){
        cell.textLabel.text = @"Generate Gift Card";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if(indexPath.row==3){
         cell.textLabel.text = @"Block the card";
        // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 54, cell.frame.size.width, 1)];
    label.backgroundColor=[UIColor grayColor];
    label.alpha=0.35;
  //  [cell addSubview:label];
    cell.textLabel.alpha=0.7;
  
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0){
        self.objTrasactionViewCtrl=[self.storyboard instantiateViewControllerWithIdentifier:@"transactionsVC"];
        self.objTrasactionViewCtrl.strCustomerID=self.strCustomerID;
         self.objTrasactionViewCtrl.viewName=@"Manage Cards";
        [self.navigationController pushViewController:self.objTrasactionViewCtrl animated:YES];
    }
    else if(indexPath.row==1){
        
    }
    else if(indexPath.row==2){
        self.objVendorOffersViewCtrl=[[VendorOffersViewController alloc] init];
       self.objVendorOffersViewCtrl.strCustomerID=self.strCustomerID;
     //   self.objVendorOffersViewCtrl.viewName=@"Manage Cards";
  //      [self.navigationController pushViewController:self.objVendorOffersViewCtrl animated:YES];
    }
    else if(indexPath.row==3){
       
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Block the card" message:@"Do you want the block the card?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Confirm",@"Cancel", nil];
        [alertView show];
        
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex== 1)
    {
        // do something
    }
    else
    {
        // do something else
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    // continue for each alertView
    
}

@end
