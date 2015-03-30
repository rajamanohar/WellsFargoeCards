//
//  TransactionsViewController.m
//  eWallet
//
//  Created by Mummidi, Raja on 12/23/14.
//
//

#import "TransactionsViewController.h"
#import "TransactionCellView.h"
#import "DatabaseQueryHandler.h"
#import <QuartzCore/QuartzCore.h>
#import "Utility.h"
#import "Constant.h"
#import "GenericTableViewController.h"
@interface TransactionsViewController ()
@property(nonatomic,strong) GenericTableViewController *objGenericTableViewController;
@end

@implementation TransactionsViewController
@synthesize objGenericTableViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self getTransactionDetails];
 //self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
//    self.tbleTransctions.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    self.tbleTransctions.layer.borderWidth=1.0f;
//    self.tbleTransctions.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    self.tbleTransctions.layer.cornerRadius=5.0f;
//    [self.tbleTransctions.layer setMasksToBounds:YES];
    
    if([self.viewName isEqualToString:@"Manage Cards"]){
    self.navigationItem.title=@"Unbilled transactions";
    }else{
        self.navigationItem.title=@"Statements";
    }
    
    
   // self.tbleTransctions.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tbleTransctions.bounds.size.width, 0.01f)];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrTransactions count];
}
-(void)getTransactionDetails
{
    ServerCommunicator *objServerCommunicator=[[ServerCommunicator alloc] init];
    objServerCommunicator.delegate=self;
 //   [objServerCommunicator requestWithQuery:[NSString stringWithFormat:@"%@&dbo_customerid=%@",kGetCardsTrans,self.strCustomerID]];
    
        NSArray *arrResponse=[DatabaseQueryHandler getCustomerCardTransactionDetails:self.strCustomerID];
        [self didDownloadComplete:arrResponse];
    
}


- (void)didDownloadComplete:(NSArray *)arrResponse
{
    
    //Initialise and display table View in the view
    objGenericTableViewController=[[GenericTableViewController alloc] init];
    objGenericTableViewController.strCustomTableViewCellname=@"TransactionCellView";
    objGenericTableViewController.arrTransactions=arrResponse;
    objGenericTableViewController.tableView.frame=self.tableContainerView.bounds;
    [self.tableContainerView addSubview:objGenericTableViewController.view];
    [objGenericTableViewController.tableView reloadData];
}
@end
