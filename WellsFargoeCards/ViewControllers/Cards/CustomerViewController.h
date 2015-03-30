//
//  CustomerViewController.h
//  iCarouselExample
//
//  Created by Mummidi, Raja on 12/19/14.
//
//

#import <UIKit/UIKit.h>
#import "Customer.h"

@interface CustomerViewController : UIViewController
{
    IBOutlet UITableView *tblCards;
    IBOutlet UIImageView *imgProfile;
    Customer *objCustomer;
}

@end
