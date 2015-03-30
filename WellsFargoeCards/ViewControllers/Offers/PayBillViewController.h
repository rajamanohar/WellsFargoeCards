//
//  PayBillViewController.h
//  eWallet
//
//  Created by Mummidi, Raja on 1/7/15.
//
//

#import <UIKit/UIKit.h>
#import "Customer.h"
#import "BankCard.h"
@interface PayBillViewController : UIViewController
{
    BOOL flipped;
    BOOL isStatusReady;
    int index;
    int indexValue;
    UIView *view1;
    UIView *view2;
    NSMutableArray *arrCreditCards;
    Customer *objCustomerDetails;
    BankCard *objCardDetails;
}
@property(nonatomic)float amountTobePaid;

@end
