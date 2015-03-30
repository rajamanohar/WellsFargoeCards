//
//  DisplayCartTableViewCell.h
//  eWallet
//
//  Created by Mummidi, Raja on 2/4/15.
//
//

#import <UIKit/UIKit.h>

@interface DisplayCartTableViewCell : UITableViewCell

@property(nonatomic,strong) IBOutlet UILabel *lblOfferWorth;
@property(nonatomic,strong) IBOutlet UILabel *lblOfferName;
@property(nonatomic,strong) IBOutlet UITextField *txtOfferQty;
@property(nonatomic,strong) IBOutlet UIImageView *imgOffer;
@end
