//
//  VoiceAuthenticationViewController.h
//  eWallet
//
//  Created by Mummidi, Raja on 1/7/15.
//
//

#import <UIKit/UIKit.h>

@interface VoiceAuthenticationViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *btnRegistration;
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;

- (IBAction)onRegistration:(id)sender; //Handles registration process of ViGo user
- (IBAction)onLogin:(id)sender; //Handles logon process of ViGo user

@end
