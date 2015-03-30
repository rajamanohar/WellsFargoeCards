//
//  OffersCollectionViewController.m
//  eWallet
//
//  Created by Mummidi, Raja on 2/2/15.
//
//

#import "OffersCollectionViewController.h"
#import "CVCell.h"

@interface OffersCollectionViewController ()

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;

@end
NSString * const kHeaderIdent = @"Hearder";


@implementation OffersCollectionViewController
@synthesize collectionView, header;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Create data for collection views
    NSMutableArray *firstSection = [[NSMutableArray alloc] init];
    NSMutableArray *secondSection = [[NSMutableArray alloc] init];
    
    for (int i=0; i<3; i++) {
        [firstSection addObject:[NSString stringWithFormat:@"Cell %d", i]];
        //[secondSection addObject:[NSString stringWithFormat:@"item %d", i]];
    }
    
    self.dataArray = [[NSArray alloc] initWithObjects:firstSection, secondSection, nil];
    
    /* Uncomment this block to use nib-based cells */
    //UINib *cellNib = [UINib nibWithNibName:@"NibCell" bundle:nil];
    //[self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"cvCell"];
    /* end of nib-based cells block */
    
    /* uncomment this block to use subclassed cells */
    [self.collectionView registerClass:[CVCell class] forCellWithReuseIdentifier:@"cvCell"];
    /* end of subclass-based cells block */
    
    // Configure layout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(100, 100)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    
    UICollectionViewFlowLayout *flowHeaderLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowHeaderLayout setSectionInset:UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)];
    [flowHeaderLayout setItemSize:CGSizeMake(300.0, 54.0)];
    [flowHeaderLayout setHeaderReferenceSize:CGSizeMake(320.0, 160.0)];
    
    [self.collectionView registerClass:[UICollectionReusableView class]
       forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
              withReuseIdentifier:kHeaderIdent];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.collectionView = nil;
    self.dataArray = nil;
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return [self.dataArray count];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSMutableArray *sectionArray = [self.dataArray objectAtIndex:section];
    return [sectionArray count];
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // Setup cell identifier
    static NSString *cellIdentifier = @"cvCell";
    
    /*  Uncomment this block to use nib-based cells */
    // UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    // UILabel *titleLabel = (UILabel *)[cell viewWithTag:100];
    // [titleLabel setText:cellData];
    /* end of nib-based cell block */
    
    /* Uncomment this block to use subclass-based cells */
    CVCell *cell = (CVCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSMutableArray *data = [self.dataArray objectAtIndex:indexPath.section];
    NSString *cellData = [data objectAtIndex:indexPath.row];
    [cell.titleLabel setText:cellData];
    /* end of subclass-based cells block */
    
    // Return the cell
    return cell;
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)cv viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (!header) {
        
        header = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                    withReuseIdentifier:kHeaderIdent
                                                           forIndexPath:indexPath];
        CGRect bounds;
        bounds = [header bounds];
        
        UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 60)];
        lbl.text=@"Test";
        
        [header addSubview:lbl];

    }
    
    return header;
}



@end
