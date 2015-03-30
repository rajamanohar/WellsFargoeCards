//
//  VoiceLoginViewController.h
//  eWallet
//
//  Created by Mummidi, Raja on 1/7/15.
//
//

#import <UIKit/UIKit.h>
//#import "CustomerViewController.h"

@interface VoiceLoginViewController : UIViewController

@property (strong, nonatomic) NSString *strSourcePage;
@property (strong, nonatomic) IBOutlet UILabel *lbStatus;
@property (strong, nonatomic) IBOutlet UIButton *btnRecord;
//@property(nonatomic,strong) CustomerViewController *objCustomerViewCtrl;
- (IBAction)onRecord:(id)sender; //Record's audio data and send it to system

@end
