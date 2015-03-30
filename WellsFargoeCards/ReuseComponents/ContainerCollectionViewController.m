//
//  ContainerCollectionViewController.m
//  eWallet
//
//  Created by Mummidi, Raja on 2/4/15.
//
//

#import "ContainerCollectionViewController.h"
#import "ProductDescpViewController.h"
#import "RecipeCollectionHeaderViewCollectionReusableView.h"
#import "CVCell.h"
#import <QuartzCore/QuartzCore.h>
@interface ContainerCollectionViewController ()

@end

@implementation ContainerCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"FlickrCell"];
    
    UINib *nibH = [UINib nibWithNibName:@"RecipeCollectionHeaderViewCollectionReusableView" bundle:nil];
    [self.collectionView registerNib:nibH
                                forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                withReuseIdentifier:@"HeaderView"];
    
//    [self.collectionView registerClass:[UICollectionReusableView class]
//            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
//                   withReuseIdentifier:@"HeaderView"];
//    
    [self.collectionView registerClass:[CVCell class] forCellWithReuseIdentifier:@"cvCell"];
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



#pragma Collection View Datasource 

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
   
    return 4;
}
// 2
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    //return [self.searches count];
    return 2;
}
// 3
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellIdentifier = @"cvCell";
    

    CVCell *cell = (CVCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    

    if(indexPath.row%2){
        cell.imgCellOffer.image=[UIImage imageNamed:@"mobile_1.jpeg"];
        cell.titleLabel.text=@"10%";
    }
    else{
         cell.imgCellOffer.image=[UIImage imageNamed:@"mobile_2.jpeg"];
         cell.titleLabel.text=@"5%";
    }
    
     cell.titleLabel.layer.borderWidth=1;
     cell.titleLabel.layer.borderColor=[[UIColor redColor]CGColor];
     cell.titleLabel.layer.cornerRadius=15;
     cell.layer.borderWidth=1;
     cell.layer.borderColor=[[UIColor darkGrayColor] CGColor];

    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Select Item
    
   UICollectionViewCell *cell =[collectionView cellForItemAtIndexPath:indexPath];
    //[cell replaceHeaderGradientWith:[UIColor blackColor]];
    cell.backgroundColor = [UIColor blueColor];
    
    ProductDescpViewController *objProductDescpViewController=[[ProductDescpViewController alloc] initWithNibName:@"ProductDescpViewController" bundle:nil];
    [self.navigationController pushViewController:objProductDescpViewController animated:YES];
}

#pragma mark – UICollectionViewDelegateFlowLayout

// 1
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *searchTerm = self.searches[indexPath.section];
//    FlickrPhoto *photo =self.searchResults[searchTerm][indexPath.row];
//    // 2
//    CGSize retval = photo.thumbnail.size.width > 0 ? photo.thumbnail.size : CGSizeMake(100, 100);
//    retval.height += 35; retval.width += 35;
//    return retval;
    CGSize retval=CGSizeMake(120,120);
    return retval;
}

// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(50, 10, 50,20);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        RecipeCollectionHeaderViewCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
       
        
       // NSString *title = [[NSString alloc]initWithFormat:@"Recipe Group #%li", indexPath.section + 1];
       // headerView.title.text = title;
//        UIImage *headerImage = [UIImage imageNamed:@"header_banner.png"];
//        headerView.backgroundImage.image = headerImage;
//        
        reusableview = headerView;
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        
        reusableview = footerview;
    }
    
    return reusableview;
}


@end
