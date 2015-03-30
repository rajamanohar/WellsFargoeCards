//
//  AddCardViewController.h
//  eWallet
//
//  Created by Mummidi, Raja on 1/7/15.
//
//

#import <UIKit/UIKit.h>
#import "BankCard.h"
@interface AddCardViewController : UIViewController<UIAlertViewDelegate,UITextFieldDelegate>
{
    BOOL isCustomerIDChecked;
}
@property (nonatomic,strong) NSString *strCustomerID;

@property (nonatomic,strong) BankCard *objBankCard;
@property (nonatomic,strong) IBOutlet UITextField *txtCardNumber;
@property (nonatomic,strong) IBOutlet UITextField *txtCustomerID;
@property (nonatomic,strong) IBOutlet UITextField *txtCvv;
@property (nonatomic,strong) IBOutlet UITextField *txtValidThru;
@property (nonatomic,strong) IBOutlet UITextField *txtType;
@property (nonatomic,strong) IBOutlet UITextField *txtNameonCard;



-(IBAction)onAddCardClicked:(id)sender;
@end
