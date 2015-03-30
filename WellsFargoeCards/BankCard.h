//
//  BankCard.h
//  WellsFargoeCards
//
//  Created by Mummidi, Raja on 3/13/15.
//  Copyright (c) 2015 Mummidi, Raja. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankCard : NSObject
{
    BOOL isBlocked;
}
@property(nonatomic) float availableBalance;
@property(nonatomic,strong) NSString *strNumber;
@property(nonatomic,strong) NSString *strNameOnCard;
@property(nonatomic,strong) NSString *strProvider;
@property(nonatomic,strong) NSString *strType;
@property(nonatomic,strong) NSString *strCVV;
@property(nonatomic,strong) NSString *strValidFrom;
@property(nonatomic,strong) NSString *strValidThru;

-(BOOL)isBlocked;
-(void)blockCard;
-(void)setCardDetails:(NSDictionary *)cardDetails;
-(NSDictionary *)getCardDetails;
-(void)getStatementOftheMonth:(NSString *)nameoftheMonth;
-(void)getStatementsFrom:(NSString *)startDate andUpto:(NSString *)endDate;
-(void)withDrawMoney:(float)amount;

@end
