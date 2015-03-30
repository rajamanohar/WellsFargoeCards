//
//  OffersViewController.h
//  eWallet
//
//  Created by Mummidi, Raja on 1/29/15.
//
//

#import <UIKit/UIKit.h>

#import "OffersCollectionViewController.h"
#import "CarouselViewController.h"
#import "ContainerPageViewController.h"

@interface OffersViewController : UIViewController

@property(strong,nonatomic) NSArray *arrOfferHeaders;
@property(strong,nonatomic) NSArray *arrOfferBanners;


@property(strong,nonatomic) OffersCollectionViewController *objOffersCollectionViewCtrl;
@property (nonatomic, strong) CarouselViewController *objCarouselViewCtrl;
@property(nonatomic,strong) ContainerPageViewController *objContainerPageViewCtrl;

@property (nonatomic,strong) IBOutlet UITableView *tblCards;
@property(nonatomic, strong) IBOutlet UIView *viewFlipContainer;
@end
