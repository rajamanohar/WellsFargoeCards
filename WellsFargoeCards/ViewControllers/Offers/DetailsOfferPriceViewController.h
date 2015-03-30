//
//  DetailsOfferPriceViewController.h
//  eWallet
//
//  Created by Mummidi, Raja on 2/10/15.
//
//

#import <UIKit/UIKit.h>

@interface DetailsOfferPriceViewController : UIViewController
@property(nonatomic,strong) IBOutlet UITableView *tbleOffers;
@property(nonatomic,strong) IBOutlet UIImageView *imgOffer;
@property(nonatomic,strong) NSArray *arrSpecialDays;
@property(nonatomic,strong) NSString *strOfferSelection;
@property(nonatomic,strong) NSString *strVendorName;
@property(nonatomic) int section;

-(IBAction)clickAddtoCart:(id)sender;

@end
