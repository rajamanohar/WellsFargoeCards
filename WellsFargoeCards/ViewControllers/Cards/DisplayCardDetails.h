//
//  DisplayCardDetails.h
//  eWallet
//
//  Created by Mummidi, Raja on 12/23/14.
//
//

#import <UIKit/UIKit.h>
#import "BankCard.h"
@interface DisplayCardDetails : UIViewController
//@property (nonatomic, strong) NSString *strCardNum

@property(nonatomic,strong) BankCard *objCardDetails;
@property(nonatomic,strong) IBOutlet UIImageView *imgViewVendor;
@end
