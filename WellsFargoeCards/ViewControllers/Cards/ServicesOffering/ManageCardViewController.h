//
//  ManageCardViewController.h
//  eWallet
//
//  Created by Mummidi, Raja on 1/7/15.
//
//

#import <UIKit/UIKit.h>
#import "BankCard.h"
#import "TransactionsViewController.h"
#import "VendorOffersViewController.h"

@interface ManageCardViewController : UIViewController<UIAlertViewDelegate>
@property (nonatomic,strong) NSString *strCustomerID;
@property (nonatomic,strong) IBOutlet UITableView *tblCards;
@property (nonatomic,strong) IBOutlet UIImageView *imgCardView;
@property (nonatomic,strong) TransactionsViewController *objTrasactionViewCtrl;
@property (nonatomic,strong) VendorOffersViewController *objVendorOffersViewCtrl;
@property (nonatomic,strong) BankCard *objCardDetails;
@end
