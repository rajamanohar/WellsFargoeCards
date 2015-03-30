//
//  CustomerViewController.m
//  WellsDemoApp
//
//  Created by Mummidi, Raja on 12/15/14.
//  Copyright (c) 2014 Patil, Chandrachud K. All rights reserved.
//

#import "CustomerViewController.h"

#import "CardDetailsViewController.h"
#import "Constant.h"
#import "DatabaseQueryHandler.h"
#import "DTCustomColoredAccessory.h"
#import "OffersViewController.h"
#import "ServerCommunicator.h"
#import "Utility.h"
#import <QuartzCore/QuartzCore.h>

@interface CustomerViewController ()<ServerCommunicatorDelegate>
{
    NSMutableArray   *arrBankCards,*arrOtherCards,*arrAllCards;
    CardDetailsViewController *objCardsDetails;
    OffersViewController *objOffersViewController;
}

@property(nonatomic, weak) IBOutlet UILabel *lblCustomerName;
@property(nonatomic, weak) IBOutlet UILabel *lblCustomerEmail;
@property(nonatomic, weak) IBOutlet UILabel *lblCustomerMobileno;
@property(nonatomic, strong) NSArray *arrSectionItems;

@end

@implementation CustomerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // self.dictCustomerDetails=self.tabBarController.dictCustomerDetails;
    arrBankCards=[[NSMutableArray alloc] init];
    arrOtherCards=[[NSMutableArray alloc] init];
    
    self.navigationItem.title=@"My Cards";
    self.arrSectionItems=@[@"Bank Cards",@"Other Cards"];
    objCustomer=[Customer sharedCustomer];
    
    //Set customer details to the view
    [self setCustomerDetailsToView];
    
    //Get All Customer Cards
    [self getCustomerCards:[objCustomer strCustomerID]];
 
}

-(void)setCustomerDetailsToView
{
    self.lblCustomerName.text=[objCustomer  strName];
    self.lblCustomerEmail.text=[objCustomer  strEmail];
    self.lblCustomerMobileno.text=[objCustomer  strPhone];
}


-(void)getCustomerCards:(NSString *)customer_id
{
    ServerCommunicator *objServerCommunicator=[[ServerCommunicator alloc] init];
    objServerCommunicator.delegate=self;
    NSArray *arrResponse=[DatabaseQueryHandler getCustomerCardTypes:[objCustomer strCustomerID]];
    [self didDownloadComplete:arrResponse];
    
  //  [objServerCommunicator requestWithQuery:[NSString stringWithFormat:@"%@&dbo_customerid=%@",
          //                                                                                                                  kGetCardsTypes,customer_id]];

}


- (void)didDownloadComplete:(NSArray *)arrResponse
{
    arrAllCards=[[NSMutableArray alloc] initWithArray:arrResponse];
    
    for(NSDictionary *dict in arrResponse){
        if([[dict objectForKey:@"type"] isEqualToString:@"Credit card"]||
                                    [[dict objectForKey:@"type"] isEqualToString:@"Debit card"]
                                    ||[[dict objectForKey:@"type"] isEqualToString:@"Forex card"]){
            
            [arrBankCards addObject:dict];
        }
        else{
            
            [arrOtherCards addObject:dict];
        }
    }
    [tblCards reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    tblCards.layer.borderWidth=1.0f;
    tblCards.layer.borderColor = [UIColor lightGrayColor].CGColor;
    //self.tblCards.layer.cornerRadius=5.0f;
    [tblCards.layer setMasksToBounds:YES];
    [tblCards reloadData];
    
}


#pragma mark - Table view data source
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return  [self.arrSectionItems objectAtIndex:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
        return [self.arrSectionItems count];
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
        return [arrBankCards count];
    else if(section==1)
        return [arrOtherCards count];
    else
        return 1;
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    
    if(indexPath.section==0){
        NSDictionary *dict=[arrBankCards objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@)",[dict objectForKey:@"type"],[dict objectForKey:@"count"]];
    }
    else if(indexPath.section==1){
        NSDictionary *dict=[arrOtherCards objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@)",[dict objectForKey:@"type"],[dict objectForKey:@"count"]];
    }
    
        cell.textLabel.font=[UIFont boldSystemFontOfSize:14];
        cell.textLabel.textColor=[UIColor darkGrayColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    objCardsDetails=nil;
    objCardsDetails= [self.storyboard instantiateViewControllerWithIdentifier:@"CardDetailsVC"];
  
    if(indexPath.section==0){
        
        NSDictionary *dict=[arrBankCards objectAtIndex:indexPath.row];
        NSString *cardType = [NSString stringWithFormat:@"%@",[dict objectForKey:@"type"]];
        objCardsDetails.strSelectedCardType=cardType;
        [self.navigationController pushViewController:objCardsDetails animated:YES];
     }
    else if(indexPath.section==1){
        
        NSDictionary *dict=[arrOtherCards objectAtIndex:indexPath.row];
        NSString *cardType = [NSString stringWithFormat:@"%@",[dict objectForKey:@"type"]];
        objCardsDetails.strSelectedCardType=cardType;
        [self.navigationController pushViewController:objCardsDetails animated:YES];
    }
    else if(indexPath.section==2){
    //         self.objOffersViewController= [[OffersViewController alloc] init];
    //        [self.navigationController pushViewController:self.objOffersViewController animated:YES];
    //        
    }
    
}


@end
