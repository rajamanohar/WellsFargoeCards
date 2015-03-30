//
//  OffersCollectionViewController.h
//  eWallet
//
//  Created by Mummidi, Raja on 2/2/15.
//
//

#import <UIKit/UIKit.h>
extern NSString * const kCellIdent;
extern NSString * const kHeaderIdent;
@interface OffersCollectionViewController : UIViewController
@property (nonatomic, readonly) UICollectionReusableView *header;
@end
