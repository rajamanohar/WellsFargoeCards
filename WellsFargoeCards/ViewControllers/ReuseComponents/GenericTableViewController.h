//
//  GenericTableViewController.h
//  WellsFargoeCards
//
//  Created by Mummidi, Raja on 2/16/15.
//  Copyright (c) 2015 Mummidi, Raja. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    kPlain=0, kGrouped=1
} TableViewStyle;

@interface GenericTableViewController : UITableViewController
@property(nonatomic) TableViewStyle style;
@property(nonatomic,strong) NSArray *arrTransactions ;
@property(nonatomic,strong) NSString *strCustomTableViewCellname;


@end
