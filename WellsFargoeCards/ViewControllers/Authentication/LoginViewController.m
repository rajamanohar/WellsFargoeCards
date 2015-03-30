//
//  LoginViewController.m
//  eWallet
//
//  Created by Mummidi, Raja on 12/22/14.
//
//

#import "LoginViewController.h"
#import "ServerCommunicator.h"
#import "Constant.h"
#import "Customer.h"
#import "DatabaseQueryHandler.h"

@interface LoginViewController ()<ServerCommunicatorDelegate>
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.txtCustomerID.delegate=self;
    self.txtPasswrd.delegate=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.txtCustomerID.text=@"543200";
    self.txtPasswrd.text=@"wells@123";
    //[self onClickSignIn:nil];
}

-(IBAction)onClickSignIn:(id)sender
{
    if([self.txtCustomerID.text isEqualToString:@""] ||[self.txtPasswrd.text isEqualToString:@""]){
        
        self.lblAuthenticate.hidden=NO;
        self.lblAuthenticate.text=@"Customer ID and Password can't be empty";
        [self.actIndicatorView stopAnimating];
    }
    else{
        
        ServerCommunicator *objServerCommunicator=[[ServerCommunicator alloc] init];
        objServerCommunicator.delegate=self;
       // [objServerCommunicator requestWithQuery:[NSString stringWithFormat:@"%@&dbo_customerid=%@&dbo_password=%@",kAccountLogin,self.txtCustomerID.text,self.txtPasswrd.text]];
        
        NSArray *arrResponse=[DatabaseQueryHandler getCustomerDetails:self.txtCustomerID.text andPassword:self.txtPasswrd.text];
        [self didDownloadComplete:arrResponse];
        
        
        self.actIndicatorView.hidden=NO;
        [self.actIndicatorView startAnimating];
    }
}

- (void)didDownloadComplete:(NSArray *)arrResponse
{
    if([arrResponse count]>0){
    NSDictionary *dict=[arrResponse objectAtIndex:0];
        if([dict count]>0){
            
            //Setting customer details to singleton class
            [[Customer sharedCustomer] setCustomerDetails:dict];
            
            self.objCustomerViewCtrl=[self.storyboard instantiateViewControllerWithIdentifier:@"CustomerVC"];
            UINavigationController *nc1=[[UINavigationController alloc] initWithRootViewController:self.objCustomerViewCtrl];
  
            self.objOffersViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"OffersVC"];
            UINavigationController *nc2=[[UINavigationController alloc] initWithRootViewController:self.objOffersViewController];
        
            
            UITabBarController *tbc = [self.storyboard instantiateViewControllerWithIdentifier:@"MyTabBarVC"];
            tbc.viewControllers=@[nc1,nc2];
            tbc.selectedIndex=0;
            [self presentViewController:tbc animated:YES completion:nil];
            
        }else{
            self.lblAuthenticate.hidden=NO;
            self.lblAuthenticate.text=@"Incorrect Credentials";
        }
    
    }else{
         self.lblAuthenticate.hidden=NO;
         self.lblAuthenticate.text=@"Incorrect Credentials";
    }
     [self.actIndicatorView stopAnimating];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.lblAuthenticate.hidden=YES;
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string   // return NO to not change text
{
    self.lblAuthenticate.hidden=YES;
    return YES;
}
- (void) receiveCredentialsNotification:(NSNotification *) notification
{
    
}

@end
