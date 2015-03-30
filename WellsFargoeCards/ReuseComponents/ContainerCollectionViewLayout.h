//
//  ContainerCollectionViewLayout.h
//  eWallet
//
//  Created by Mummidi, Raja on 2/10/15.
//
//

#import <UIKit/UIKit.h>

@interface ContainerCollectionViewLayout : UICollectionViewLayout

@property (nonatomic) UIEdgeInsets itemInsets;
@property (nonatomic) CGSize itemSize;
@property (nonatomic) CGFloat interItemSpacingY;
@property (nonatomic) NSInteger numberOfColumns;
@end
