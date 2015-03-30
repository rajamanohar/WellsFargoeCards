//
//  Customer.m
//  WellsFargoeCards
//
//  Created by Mummidi, Raja on 3/27/15.
//  Copyright (c) 2015 Mummidi, Raja. All rights reserved.
//

#import "Customer.h"
#import "Utility.h"
@implementation Customer
@synthesize strDOB,strEmail,strName,strPhone,strCustomerID;


+ (id)sharedCustomer{
    static Customer *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        //  someProperty = [[NSString alloc] initWithString:@"Default Property Value"];
    }
    return self;
}




-(void)setCustomerDetails:(NSDictionary *)dictCustomerDetails
{
    strCustomerID=[dictCustomerDetails objectForKey:@"customer_id"];
    strName=  [NSString stringWithFormat:@"%@ %@",[dictCustomerDetails objectForKey:@"firstname"],
               [dictCustomerDetails objectForKey:@"lastname"]] ;
    NSString *dobConverstion=[Utility  convertDate:[dictCustomerDetails objectForKey:@"dob_date"]
                                   fromInputFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                                    toOutputFormat:@"dd MMM yyyy"];
    strDOB=  dobConverstion;
    strEmail=  [dictCustomerDetails objectForKey:@"email"];
    strPhone= [dictCustomerDetails objectForKey:@"phone_number"];
    
}
-(NSDictionary *)getCustomerDetails
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setValue:strName forKey:@"customer_id"];
    [dict setValue:strName forKey:@"name"];
    [dict setValue:strDOB forKey:@"dob"];
    [dict setValue:strEmail forKey:@"email"];
    [dict setValue:strPhone forKey:@"phone"];
    
    return dict;
}
@end
