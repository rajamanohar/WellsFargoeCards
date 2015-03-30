//
//  DisplayCartViewController.h
//  eWallet
//
//  Created by Mummidi, Raja on 2/4/15.
//
//

#import <UIKit/UIKit.h>

@interface DisplayCartViewController : UIViewController

@property(nonatomic) int numberofItems;
@property(nonatomic,strong) NSMutableDictionary *dictOffers;
@property(nonatomic,strong) IBOutlet UILabel *lblItemsCount;
@property(nonatomic,strong) IBOutlet UITableView *tblOffers;
+(DisplayCartViewController*)sharedMySingleton;
@end
