//
//  DetailsCustomerServiceViewController.h
//  eWallet
//
//  Created by Mummidi, Raja on 1/7/15.
//
//
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface DetailsCustomerServiceViewController : UIViewController<MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>
@property (nonatomic,strong) NSString *strServiceType;
@property (nonatomic,weak) IBOutlet UILabel *lblTpye;
@property (nonatomic,strong) IBOutlet UITableView *tbleTransctions;
@property (nonatomic,weak) IBOutlet UITabBar *tabContactOptions;
@end
