//
//  BankCard.m
//  WellsFargoeCards
//
//  Created by Mummidi, Raja on 3/13/15.
//  Copyright (c) 2015 Mummidi, Raja. All rights reserved.
//

#import "BankCard.h"

@implementation BankCard
@synthesize strNameOnCard,strCVV,strNumber,strProvider,strType,strValidFrom,strValidThru,availableBalance;

- (id)init {
    if (self = [super init]) {
        isBlocked=0;
    }
    return self;
}

-(void)blockCard
{
    isBlocked=1;
}

-(BOOL)isBlocked
{
    if(isBlocked) return YES;
    return NO;
}


-(void)setCardDetails:(NSDictionary *)dict
{
    strNumber=[[NSString alloc]initWithString:[dict  objectForKey:@"number"]];
    strNameOnCard=[[NSString alloc]initWithString:[dict  objectForKey:@"nameoncard"]];
    strCVV=[[NSString alloc]initWithString:[NSString stringWithFormat:@"%@",[dict objectForKey:@"ccv"]]];
    strProvider=[[NSString alloc]initWithString:[dict  objectForKey:@"name"]];
    strType=[[NSString alloc]initWithString:[dict  objectForKey:@"type"]];
    strValidFrom=[[NSString alloc]initWithString:[dict  objectForKey:@"validfrom"]];
    strValidThru=[[NSString alloc]initWithString:[dict  objectForKey:@"validthru"]];
    availableBalance=[[dict  objectForKey:@"available_balance"] floatValue];
}


-(NSDictionary *)getCardDetails
{
    NSDictionary *dict=[[NSDictionary alloc] init];
    [dict setValue:@"" forKey:@"Error"];
    
    if(isBlocked){
        [dict setValue:@"Card is Blocked" forKey:@"Error"];
        return dict;
    }
    
    
     [dict setValue:strNumber forKey:@"number"];
     [dict setValue:strNameOnCard forKey:@"nameoncard"];
     [dict setValue:strCVV forKey:@"cvv"];
     [dict setValue:strProvider forKey:@"name"];
     [dict setValue:strType forKey:@"type"];
     [dict setValue:strValidFrom forKey:@"validfrom"];
     [dict setValue:strValidThru forKey:@"validthru"];
     [dict setValue:[NSString stringWithFormat:@"%f",availableBalance] forKey:@"available_balance"];
    return dict;
   
}
-(void)getStatementOftheMonth:(NSString *)nameoftheMonth
{
    
}
-(void)getStatementsFrom:(NSString *)startDate andUpto:(NSString *)endDate
{
    
}
-(void)withDrawMoney:(float)amount
{
    
}

@end
