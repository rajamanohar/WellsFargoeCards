//
//  ContainerPageViewController.h
//  eWallet
//
//  Created by Mummidi, Raja on 2/2/15.
//
//

#import <UIKit/UIKit.h>

@interface ContainerPageViewController : UIViewController<UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageController;
@property(strong,nonatomic) NSArray *arrOffersBanners;
@property (weak, nonatomic) IBOutlet UIPageControl *pgctrlOfferBannerIndex;
@end
