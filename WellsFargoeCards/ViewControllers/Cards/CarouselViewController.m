//
//  ViewController.m
//  ImageFXViewDemo
//
//  Created by Nick Lockwood on 31/10/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CarouselViewController.h"
#import "DisplayCardDetails.h"

@interface CarouselViewController ()
@end
@implementation CarouselViewController

@synthesize carousel = _carousel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])){
        objCardDetails=[[BankCard alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //configure carousel
    _carousel.type = iCarouselTypeCoverFlow;
}

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [self.arrCardsList count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    //create new view if no view is available for recycling
    if (view == nil)
    {
        FXImageView *imageView = [[FXImageView alloc] initWithFrame:CGRectMake(0, 0, 250.0f, 250.0f)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.asynchronous = YES;
       // imageView.reflectionScale = 0.5f;
      //  imageView.reflectionAlpha = 0.25f;
       // imageView.reflectionGap = 10.0f;
      //  imageView.shadowOffset = CGSizeMake(0.0f, 2.0f);
       // imageView.shadowBlur = 5.0f;
        imageView.cornerRadius = 10.0f;
        view = imageView;
    }
    
    //Get card details from the index value
    NSDictionary *dict=[self.arrCardsList objectAtIndex:index];
    [objCardDetails setCardDetails:dict];
    
    
    //show placeholder for loading in progress
    ((FXImageView *)view).processedImage = [UIImage imageNamed:@"placeholder.png"];
    
    if(index%2){
        ((FXImageView *)view).image=[UIImage imageNamed:[NSString stringWithFormat:@"gray_%@",objCardDetails.strProvider]];
    }
    else{
        ((FXImageView *)view).image=[UIImage imageNamed:[NSString stringWithFormat:@"red_%@",objCardDetails.strProvider]];
    }
    if([objCardDetails.strType isEqualToString:@"Discount card"]){
        ((FXImageView *)view).image=[UIImage imageNamed:[NSString stringWithFormat:@"red_all"]];
    }
    
    DisplayCardDetails *objDisplayCardDetails=[[DisplayCardDetails alloc]init];
    objDisplayCardDetails.objCardDetails=objCardDetails;
    objDisplayCardDetails.view.frame=CGRectMake(((FXImageView *)view).frame.origin.x+10, ((FXImageView *)view).frame.size.height-170,((FXImageView *)view).frame.size.width-30, 180);
    objDisplayCardDetails.view.backgroundColor=[UIColor clearColor];
     if([objCardDetails.strType isEqualToString:@"Discount card"]){
         objDisplayCardDetails.imgViewVendor.hidden=NO;
         objDisplayCardDetails.imgViewVendor.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@_logo.jpeg",
                                                                                                                          [NSString stringWithFormat:@"%@",objCardDetails.strNameOnCard]]];
         }
    [((FXImageView *)view) addSubview:objDisplayCardDetails.view];
    return view;
}
@end
