//
//  CardDetailsViewController.h
//  iCarouselExample
//
//  Created by Mummidi, Raja on 12/19/14.
//
//

#import <UIKit/UIKit.h>
#import "CarouselViewController.h"
#import "Customer.h"
#import "BankCard.h"
#import "SupportViewController.h"
#import "ServerCommunicator.h"
#import "TransactionsViewController.h"
#import "AddCardViewController.h"
#import "ManageCardViewController.h"
#import "GenericCollectionViewController.h"
@interface CardDetailsViewController : UIViewController<UIGestureRecognizerDelegate,GenericCollectionVCDelegate,ServerCommunicatorDelegate>
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
    GenericCollectionViewController *objGenericCollectionVC;
    }

@property(nonatomic, strong) NSString *strSelectedCardType;


@end
