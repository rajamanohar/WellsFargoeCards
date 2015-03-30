//
//  OffersTableViewCell.m
//  eWallet
//
//  Created by Mummidi, Raja on 2/9/15.
//
//

#import "OffersTableViewCell.h"

@implementation OffersTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.imgLogo.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    self.imgLogo.layer.cornerRadius=15;
    self.imgLogo.layer.borderWidth=1;
     self.imgLogo.clipsToBounds  = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
