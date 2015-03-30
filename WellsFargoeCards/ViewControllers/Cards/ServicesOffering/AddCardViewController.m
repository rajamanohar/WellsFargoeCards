//
//  AddCardViewController.m
//  eWallet
//
//  Created by Mummidi, Raja on 1/7/15.
//
//

#import "AddCardViewController.h"
#import "Customer.h"
#import <QuartzCore/QuartzCore.h>
@interface AddCardViewController ()

@end
#define MAXLENGTH 6
@implementation AddCardViewController
@synthesize objBankCard;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title=@"Add-on Card";
    self.txtCustomerID.delegate=self;
    self.txtCardNumber.delegate=self;
    self.txtCvv.delegate=self;
    self.txtType.delegate=self;
    self.txtValidThru.delegate=self;
    self.txtNameonCard.delegate=self;
    isCustomerIDChecked=0;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
     self.txtCardNumber.text=objBankCard.strNumber;
     self.txtNameonCard.text=objBankCard.strNameOnCard;
     self.txtCvv.text=objBankCard.strCVV;
     self.txtType.text=objBankCard.strType;
     self.txtValidThru.text=objBankCard.strValidThru;
    
}

-(IBAction)onAddCardClicked:(id)sender
{
    if([self.txtCustomerID.text isEqualToString:@""] || [self.txtCustomerID.text length]<6){
        isCustomerIDChecked=1;
        self.txtCustomerID.layer.borderWidth = 2.0f;
        self.txtCustomerID.layer.borderColor = [[UIColor redColor] CGColor];
        self.txtCustomerID.layer.cornerRadius = 5;
        self.txtCustomerID.clipsToBounds      = YES;
    }else{
    
        NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
        [dict setValue:self.txtCardNumber.text forKey:@"cardnumber"];
        [dict setValue:self.txtCvv.text forKey:@"cvv"];
        [dict setValue:self.txtType.text forKey:@"name"];
        [dict setValue:self.txtValidThru.text forKey:@"validthru"];
        [dict setValue:@"12/14" forKey:@"validfrom"];
        [dict setValue:self.txtNameonCard.text forKey:@"nameoncard"];
        [dict setValue:@"Credit Card" forKey:@"type"];
        [dict setValue:@"543200" forKey:@"customer_id"];
        [dict setValue:@"30000" forKey:@"available_balance"];
        
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Add-on Card" message:@"Add-on card successfully added" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
     int length = [textField.text length] ;
    if(textField.tag==0){
        if(isCustomerIDChecked){
            isCustomerIDChecked=0;
            self.txtCustomerID.layer.borderWidth = 1.0f;
            self.txtCustomerID.layer.borderColor = [[UIColor clearColor] CGColor];
            self.txtCustomerID.layer.cornerRadius = 5;
            self.txtCustomerID.clipsToBounds      = YES;
        }
    if (length >= MAXLENGTH && ![string isEqualToString:@""]) {
        textField.text = [textField.text substringToIndex:MAXLENGTH];
        return NO;
    }
    }
    return YES;
}
@end
