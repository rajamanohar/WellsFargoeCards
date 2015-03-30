//
//  AuthenticationViewController.m
//  eWallet
//
//  Created by Mummidi, Raja on 1/7/15.
//
//

#import "AuthenticationViewController.h"
//#import "DatabaseQueryHandler.h"
#import <LocalAuthentication/LocalAuthentication.h>
@interface AuthenticationViewController ()

@end

@implementation AuthenticationViewController
@synthesize tblAuthentication,imgBanner;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"e-Cards";
    
    tblAuthentication.layer.borderWidth=1.0f;
    tblAuthentication.layer.borderColor = [UIColor lightGrayColor].CGColor;
   // tblAuthentication.layer.cornerRadius=5.0f;
    
    imgBanner.layer.borderWidth=1.0f;
    imgBanner.layer.borderColor= [UIColor grayColor].CGColor;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    headerview.backgroundColor=[UIColor darkGrayColor];
    //headerview.alpha=0.5;
    UILabel *lblText=[[UILabel alloc] initWithFrame:CGRectMake(tableView.frame.size.width/2-80, headerview.frame.size.height/2-15, tableView.frame.size.width, 40)];
    
    lblText.text=@"Authentication Options";
    lblText.font=[UIFont boldSystemFontOfSize:15];
    lblText.textColor=[UIColor whiteColor];
    [headerview addSubview:lblText];
    return headerview;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    UILabel *lblAuthenticaitonName=[[UILabel alloc] initWithFrame:CGRectMake(80, 20, 200, 40)];
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(3, 10, 64, 64)];
                          
  
    if(indexPath.row==0){
       lblAuthenticaitonName.text = @"Credentials";
         imageView.image=[UIImage imageNamed:@"password13.png"];
    }
    else if(indexPath.row==1){
        lblAuthenticaitonName.text = @"Fingerprint";
        imageView.image=[UIImage imageNamed:@"fingerprint43.png"];
    }
     else  if(indexPath.row==2){
        lblAuthenticaitonName.text = @"Voice";
        imageView.image=[UIImage imageNamed:@"microphone9.png"];
        
    }
    imageView.alpha=0.3;
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 79, cell.frame.size.width, 1)];
    label.backgroundColor=[UIColor grayColor];
    label.alpha=0.35;
   // [cell addSubview:label];
    [cell addSubview:lblAuthenticaitonName];
    [cell addSubview:imageView];
   
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        self.objLoginViewController =[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginVC"];
        [self.navigationController pushViewController:self.objLoginViewController animated:YES];
    }
    else if(indexPath.row==1)
    {
        LAContext *context = [[LAContext alloc] init];
        
        NSError *error = nil;
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
            
           // activityIndicator.center=self.view.center;
           // [activityIndicator startAnimating];
            UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(-40, 20, 150, 30)];
            // lbl.center = self.view.center;
            lbl.text = @"Authenticating";
            //[activityIndicator addSubview:lbl];
           // [self.view addSubview:activityIndicator];
            
            [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                    localizedReason:@"Are you the device owner?"
                              reply:^(BOOL success, NSError *error) {
                                  
                                  if (error) {
                                     // [activityIndicator stopAnimating];
                                      
                                      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                      message:@"There was a problem verifying your identity."
                                                                                     delegate:nil
                                                                            cancelButtonTitle:@"Ok"
                                                                            otherButtonTitles:nil];
                                      [alert show];
                                      return;
                                  }
                                  
                                  if (success) {
                                      
                                      //[activityIndicator stopAnimating];
                                      
                                     // CardsListViewController *cardList = [[CardsListViewController alloc]init];
                                     // [self.navigationController pushViewController:cardList animated:YES];
//                                      
//                                      NSArray *arrResponse=[DatabaseQueryHandler getCustomerDetails:@"543200" andPassword:@"wells@123"];
//                                      [self didDownloadComplete:arrResponse];

                                      
                                      
                                  } else {
                                     // [activityIndicator stopAnimating];
                                      
                                      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                      message:@"You are not the device owner."
                                                                                     delegate:nil
                                                                            cancelButtonTitle:@"Ok"
                                                                            otherButtonTitles:nil];
                                      [alert show];
                                  }
                                  
                              }];
            
        } else {
           // [activityIndicator stopAnimating];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Your device cannot authenticate using TouchID."
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
            [alert show];
            
        }
    }
    else if(indexPath.row==2)
    {
        self.objVoiceAuthenticationViewController=[[VoiceAuthenticationViewController alloc] init];
        [self.navigationController pushViewController:self.objVoiceAuthenticationViewController animated:YES];
        
    }
}

- (void)didDownloadComplete:(NSArray *)arrResponse
{
    if([arrResponse count]>0){
        NSDictionary *dict=[arrResponse objectAtIndex:0];
        if([dict count]>0){
//            self.objCustomerViewCtrl=[[CustomerViewController alloc] init];
//            self.objCustomerViewCtrl.dictCustomerDetails=dict;
//            UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:self.objCustomerViewCtrl];
//            [self presentViewController:nav animated:YES completion:nil];
        }
    }
}


@end
