//
//  Customer.h
//  WellsFargoeCards
//
//  Created by Mummidi, Raja on 3/27/15.
//  Copyright (c) 2015 Mummidi, Raja. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Customer : NSObject
{
    
}
@property(nonatomic,strong) NSString *strCustomerID;
@property(nonatomic,strong) NSString *strName;
@property(nonatomic,strong) NSString *strDOB;
@property(nonatomic,strong) NSString *strEmail;
@property(nonatomic,strong) NSString *strPhone;



+ (id)sharedCustomer;
-(void)setCustomerDetails:(NSDictionary *)dictCustomer;
-(NSDictionary *)getCustomerDetails;


@end
