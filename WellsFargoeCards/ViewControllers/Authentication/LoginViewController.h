//
//  LoginViewController.h
//  eWallet
//
//  Created by Mummidi, Raja on 12/22/14.
//
//

#import <UIKit/UIKit.h>
#import "CustomerViewController.h"
#import "OffersViewController.h"
@interface LoginViewController : UIViewController<UITextFieldDelegate>
@property(nonatomic,weak) IBOutlet UITextField *txtCustomerID;
@property(nonatomic,weak) IBOutlet UITextField *txtPasswrd;
@property(nonatomic,weak) IBOutlet UILabel *lblAuthenticate;
@property(nonatomic,weak) IBOutlet UIActivityIndicatorView *actIndicatorView;
@property(nonatomic,strong) CustomerViewController *objCustomerViewCtrl;
@property(nonatomic,strong) OffersViewController *objOffersViewController;

@end
