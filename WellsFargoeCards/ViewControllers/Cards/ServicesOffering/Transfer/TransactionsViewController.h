//
//  TransactionsViewController.h
//  eWallet
//
//  Created by Mummidi, Raja on 12/23/14.
//
//

#import <UIKit/UIKit.h>
#import "ServerCommunicator.h"

@interface TransactionsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ServerCommunicatorDelegate>
{
    NSMutableArray *arrTransactions;
}
@property (nonatomic,strong) IBOutlet UIView *tableContainerView;
@property (nonatomic,strong) NSString *strCustomerID;
@property (nonatomic,strong) NSString *viewName;
@end
