//
//  ContainerPageViewController.m
//  eWallet
//
//  Created by Mummidi, Raja on 2/2/15.
//
//

#import "ContainerPageViewController.h"
#import "PagingSupportViewController.h"
@interface ContainerPageViewController ()
{
int pageIndex;
}
@end

@implementation ContainerPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    pageIndex=1;
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                        navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                        options:nil];
    self.pageController.dataSource = self;
    self.pageController.delegate=self;
    [[self.pageController view] setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    
  
    PagingSupportViewController *viewControllerObject = [self viewControllerAtIndex:0];
    viewControllerObject.arrOfferBanners=self.arrOffersBanners;
    viewControllerObject.view.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    NSArray *viewControllers = [NSArray arrayWithObject:viewControllerObject];
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward
                                   animated:YES completion:nil];
    //timer to rotate the views
    [NSTimer scheduledTimerWithTimeInterval:1.5
                                     target:self
                                   selector:@selector(targetMethod:)
                                   userInfo:nil
                                    repeats:YES];
    
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
    [self.view bringSubviewToFront:self.pgctrlOfferBannerIndex];
    
    
}

-(void)targetMethod:(NSTimer *)timer {
    //do smth
    if(pageIndex>3)
        pageIndex=0;
    self.pgctrlOfferBannerIndex.currentPage=pageIndex;
    PagingSupportViewController *viewControllerObject = [self viewControllerAtIndex:pageIndex++];
    viewControllerObject.arrOfferBanners=self.arrOffersBanners;
    NSArray *viewControllers = [NSArray arrayWithObject:viewControllerObject];
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward
                                   animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Sent when a gesture-initiated transition begins.
- (void)pageViewController:(UIPageViewController *)pageViewController
                            willTransitionToViewControllers:(NSArray *)pendingViewControllers
{
    
}

// Sent when a gesture-initiated transition ends. The 'finished' parameter indicates whether the animation finished, while the 'completed' parameter indicates whether the transition completed or bailed out (if the user let go early).
- (void)pageViewController:(UIPageViewController *)pageViewController
                                             didFinishAnimating:(BOOL)finished
                                        previousViewControllers:(NSArray *)previousViewControllers
                                            transitionCompleted:(BOOL)completed
{
    
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
         viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(PagingSupportViewController *)viewController indexNumber];
    
    if (index == 0) {
         return [self viewControllerAtIndex:3];
     }
    
    index--;
     return [self viewControllerAtIndex:index];
}



- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(PagingSupportViewController *)viewController indexNumber];
    index++;
    
     if (index == 4) {
         return [self viewControllerAtIndex:0];
    }
     return [self viewControllerAtIndex:index];
}


- (PagingSupportViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    PagingSupportViewController *childViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PagingSupportVC"];;
     childViewController.indexNumber = index;
     return childViewController;
}


- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    
    return 4;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    
    return 0;
}

@end
