//
//  GenericCollectionViewController.h
//  WellsFargoeCards
//
//  Created by Mummidi, Raja on 2/13/15.
//  Copyright (c) 2015 Mummidi, Raja. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GenericCollectionVCDelegate<NSObject>
@required
- (void) requestTheService:(NSString *)serviceName;
@end

@interface GenericCollectionViewController : UICollectionViewController
@property (nonatomic) BOOL isHeaderEnabled;
@property(nonatomic,strong) NSArray *arrServiceOfferings;
@property(nonatomic,strong) NSString *strCustomerCellName;
@property(nonatomic,strong) id<GenericCollectionVCDelegate>  collectionVCDelegate;
@end
