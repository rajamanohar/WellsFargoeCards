//
//  ContainerCollectionViewController.h
//  eWallet
//
//  Created by Mummidi, Raja on 2/4/15.
//
//

#import <UIKit/UIKit.h>

@interface ContainerCollectionViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) IBOutlet UICollectionView *collectionView;
@end
