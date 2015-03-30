//
//  PagingSupportViewController.h
//  eWallet
//
//  Created by Mummidi, Raja on 2/2/15.
//
//

#import <UIKit/UIKit.h>

@interface PagingSupportViewController : UIViewController


@property (assign, nonatomic) NSInteger indexNumber;
@property(strong,nonatomic) NSArray *arrOfferBanners;
@property(strong,nonatomic) IBOutlet UIImageView *imgCurrentBanner;
@end
