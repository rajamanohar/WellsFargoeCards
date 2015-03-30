//
//  GenericCollectionViewController.m
//  WellsFargoeCards
//
//  Created by Mummidi, Raja on 2/13/15.
//  Copyright (c) 2015 Mummidi, Raja. All rights reserved.
//

#import "GenericCollectionViewController.h"
#import "CVCell.h"
#import "OffersCVCell.h"
@interface GenericCollectionViewController ()
{
    NSIndexPath *selectedIndexPath;
}

@end

@implementation GenericCollectionViewController
@synthesize isHeaderEnabled,arrServiceOfferings,collectionVCDelegate,strCustomerCellName;

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];

    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    if([strCustomerCellName isEqualToString:@"cvCell"]){
            [self.collectionView registerClass:[CVCell class] forCellWithReuseIdentifier:strCustomerCellName];
    }else  if([strCustomerCellName isEqualToString:@"OffersCVCell"]){
            [self.collectionView registerClass:[OffersCVCell class] forCellWithReuseIdentifier:strCustomerCellName];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [arrServiceOfferings count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    NSString *cellIdentifier = [NSString stringWithFormat:@"%@" ,strCustomerCellName];
    
    if([strCustomerCellName isEqualToString:@"cvCell"]){
        CVCell *cell = (CVCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        
        cell.titleLabel.text=[arrServiceOfferings objectAtIndex:indexPath.row];
        ///  cell.titleLabel.layer.borderWidth=1;
        // cell.titleLabel.layer.borderColor=[[UIColor lightGrayColor]CGColor];
        
        //  cell.titleLabel.layer.cornerRadius=15;
        cell.imgCellOffer.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[arrServiceOfferings objectAtIndex:indexPath.row]]];
        cell.layer.borderWidth=1;
        cell.layer.borderColor=[[UIColor lightGrayColor] CGColor];
        return cell;
    }else  if([strCustomerCellName isEqualToString:@"OffersCVCell"]){
        OffersCVCell *cell = (OffersCVCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        
        cell.titleLabel.text=[arrServiceOfferings objectAtIndex:indexPath.row];
        ///  cell.titleLabel.layer.borderWidth=1;
        // cell.titleLabel.layer.borderColor=[[UIColor lightGrayColor]CGColor];
        
        //  cell.titleLabel.layer.cornerRadius=15;
        cell.imgCellOffer.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[arrServiceOfferings objectAtIndex:indexPath.row]]];
        cell.layer.borderWidth=1;
        cell.layer.borderColor=[[UIColor lightGrayColor] CGColor];
        return cell;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Select Item
    
    UICollectionViewCell *cell =[collectionView cellForItemAtIndexPath:indexPath];
    //[cell replaceHeaderGradientWith:[UIColor blackColor]];
    cell.backgroundColor = [UIColor lightGrayColor];
    selectedIndexPath=indexPath;

    [collectionVCDelegate requestTheService:[arrServiceOfferings objectAtIndex:indexPath.row]];
    
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell =[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor lightGrayColor];
    
    
}
- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell =[collectionView cellForItemAtIndexPath:selectedIndexPath];
    //[cell replaceHeaderGradientWith:[UIColor blackColor]];
     cell.backgroundColor = [UIColor whiteColor];
}
#pragma mark <UICollectionViewDelegate>


// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}



// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)scrollToItemAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated
{
    
}
/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
