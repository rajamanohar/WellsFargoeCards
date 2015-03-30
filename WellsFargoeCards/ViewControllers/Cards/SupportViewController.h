//
//  SupportViewController.h
//  iCarouselExample
//
//  Created by Mummidi, Raja on 12/19/14.
//
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "DetailsCustomerServiceViewController.h"

@interface SupportViewController : UIViewController<MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>
@property (nonatomic,weak) IBOutlet UITabBar *tabContactOptions;
@property (nonatomic,strong) IBOutlet UITableView *tblCards;
@property (nonatomic,strong) DetailsCustomerServiceViewController *objDetailCustomerServiceViewCtrl;
@end
