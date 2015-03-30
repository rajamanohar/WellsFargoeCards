//
//  CardDetails.h
//  WellsFargoeCards
//
//  Created by Mummidi, Raja on 2/17/15.
//  Copyright (c) 2015 Mummidi, Raja. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardDetails : NSObject
{
    
}
@property(nonatomic) float availableBalance;
@property(nonatomic,strong) NSString *strNumber;
@property(nonatomic,strong) NSString *strNameOnCard;
@property(nonatomic,strong) NSString *strProvider;
@property(nonatomic,strong) NSString *strType;
@property(nonatomic,strong) NSString *strCVV;
@property(nonatomic,strong) NSString *strValidFrom;
@property(nonatomic,strong) NSString *strValidThru;


-(void)setCardDetails:(NSDictionary *)dict;
-(NSDictionary *)getCardDetails;
@end
