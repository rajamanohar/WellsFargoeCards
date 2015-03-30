//
//  DisplayVendorViewController.h
//  eWallet
//
//  Created by Mummidi, Raja on 2/9/15.
//
//

#import <UIKit/UIKit.h>

#import "DetailsOfferPriceViewController.h"

@interface DisplayVendorViewController : UIViewController
@property(nonatomic,strong) IBOutlet UIImageView *imgBackground;
@property(nonatomic,strong) IBOutlet UITableView *tbleOffers;
@property(nonatomic,strong) IBOutlet UITextView *txtDescription;

@property(nonatomic,strong)  UIBarButtonItem *mailbutton;
@property(nonatomic,strong)  UILabel *lblItemsCount;

@property(nonatomic,strong) NSString *strBackgroundImage;
@property(nonatomic,strong) NSString *strSelectedVendorName;

@property(strong,nonatomic) DetailsOfferPriceViewController *objDetailsOfferPriceViewController;
@end
