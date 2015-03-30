//
//  AuthenticationViewController.h
//  eWallet
//
//  Created by Mummidi, Raja on 1/7/15.
//
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "VoiceAuthenticationViewController.h"
//#import "CustomerViewController.h"

@interface AuthenticationViewController : UIViewController

@property (nonatomic,strong) IBOutlet UIImageView *imgBanner;
@property (nonatomic,strong) IBOutlet UITableView *tblAuthentication;

@property(nonatomic,strong) LoginViewController *objLoginViewController;
@property(nonatomic,strong) VoiceAuthenticationViewController *objVoiceAuthenticationViewController;
//@property(nonatomic,strong) CustomerViewController *objCustomerViewCtrl;
@end
