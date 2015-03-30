//
//  TransactionCellView.m
//  eWallet
//
//  Created by Mummidi, Raja on 12/23/14.
//
//

#import "TransactionCellView.h"
#import "Utility.h"
@interface TransactionCellView ()
    @property(nonatomic,weak) IBOutlet UILabel *lblTransactionID;
    @property(nonatomic,weak) IBOutlet UILabel *lblTransactionAmount;
    @property(nonatomic,weak) IBOutlet UILabel *lblTransactionDate;
@end

@implementation TransactionCellView
@synthesize lblTransactionID,lblTransactionDate,lblTransactionAmount,dictTransactionDetails;
- (void)awakeFromNib {
    // Initialization code
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    lblTransactionAmount.text=[NSString stringWithFormat:@"$ %@",[dictTransactionDetails objectForKey:@"trans_amount"]];
    NSString *finalString= [Utility convertDate:[dictTransactionDetails objectForKey:@"trans_date"] fromInputFormat:@"dd-mm-yyyy" toOutputFormat:@"dd MMM yyyy HH:mm"];
    lblTransactionDate.text=finalString;//[NSString stringWithFormat:@" %@",[dictTransactionDetails objectForKey:@"trans_date"]];
    lblTransactionID.text=[NSString stringWithFormat:@"%@",[dictTransactionDetails objectForKey:@"trans_id"]];
    
    // Configure the view for the selected state
}

@end
