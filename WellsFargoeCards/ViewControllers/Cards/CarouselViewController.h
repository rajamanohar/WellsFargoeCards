//
//  ViewController.h
//  ImageFXViewDemo
//
//  Created by Nick Lockwood on 31/10/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BankCard.h"
#import "FXImageView.h"
#import "iCarousel.h"

@interface CarouselViewController : UIViewController <iCarouselDataSource,UIGestureRecognizerDelegate>
{
    BankCard *objCardDetails;
}

@property (nonatomic, strong) IBOutlet iCarousel *carousel;
@property (nonatomic, strong) NSMutableArray *arrCardsList;

@end
