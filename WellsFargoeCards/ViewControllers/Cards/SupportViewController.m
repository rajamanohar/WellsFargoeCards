//
//  SupportViewController.m
//  iCarouselExample
//
//  Created by Mummidi, Raja on 12/19/14.
//
//

#import "SupportViewController.h"
#import <UIKit/UIKit.h>
#import "Constant.h"
@interface SupportViewController ()<UITabBarDelegate>

@end

@implementation SupportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tabContactOptions.delegate=self;
    self.navigationItem.title=@"Customer Support";
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


-(IBAction)sendMessage:(id)sender
{
    //check if the device can send text messages
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device cannot send text messages" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    //set receipients
    NSArray *recipients = [NSArray arrayWithObjects:@"0650454323",@"0434320943",@"0560984122", nil];
    
    //set message text
    NSString * message = @"";
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    // messageController.navigationItem.title=@"WF Messaging";
    [messageController setRecipients:recipients];
    [messageController setBody:message];
    
    // Present message view controller on screen
    [self presentViewController:messageController animated:YES completion:nil];
}
#pragma mark - MFMailComposeViewControllerDelegate methods
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Oups, error while sendind SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
            
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)sendEmail:(id)sender
{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        [mailer setSubject:@"Report Issue"];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:@"customercare@wellsfargo.com", @"bankcards@wellsfargo.com", nil];
        [mailer setToRecipients:toRecipients];
        
        UIImage *myImage = [UIImage imageNamed:@"app_icon_44.png"];
        NSData *imageData = UIImagePNGRepresentation(myImage);
        [mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@"mobiletutsImage"];
        
        //        NSString *emailBody = @"Have you seen the MobileTuts+ web site?";
        //        [mailer setMessageBody:emailBody isHTML:NO];
        //
       // [self presentModalViewController:mailer animated:YES];
        [self presentViewController:mailer animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        
    }
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    
    // Remove the mail view
    [self dismissModalViewControllerAnimated:YES];
}
-(IBAction)connectFaceTime:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kCustomerCareFacetime]];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if(item.tag == 0){
        //party like its 1999 right here
        [self connectFaceTime:item];
    }
    else if(item.tag == 1){
        //party like its 1999 right here
        [self sendMessage:item];
    }
    else if(item.tag == 2){
        //party like its 1999 right here
        [self sendEmail:item];
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section==0)
        return @"Contacts";
//    else if(section==1)
//        return @"Apply by Phone";
//    else if(section==1)
//        return @"Application Status";
//    else if(section==1)
//        return @"Pay your card bill";
//    else if(section==1)
//        return @"Redeem Rewards";
    
    return @"";
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.font=[UIFont systemFontOfSize:13];
    if(indexPath.row==0){
      
        cell.textLabel.text = @"Account Management";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if(indexPath.row==1){
        cell.textLabel.text = @"Apply by Phone";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if(indexPath.row==2){
        cell.textLabel.text = @"Application Status";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if(indexPath.row==3){
        cell.textLabel.text = @"Pay your card bill";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if(indexPath.row==4){
        cell.textLabel.text = @"Redeem Rewards";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.objDetailCustomerServiceViewCtrl= [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsCustomerServiceVC"];
    
    // self.objCardsDetails.strCardNumber=[self.creditCardNumbers objectAtIndex:indexPath.row];
    
     //self.objDetailCustomerServiceViewCtrl.strCustomer_id=[self.dictCustomerDetails objectForKey:@"customer_id"];
    if(indexPath.row==0){
        
        self.objDetailCustomerServiceViewCtrl.strServiceType = @"Account Management";
       
    }
    else if(indexPath.row==1){
        self.objDetailCustomerServiceViewCtrl.strServiceType = @"Apply by Phone";
       
    }
    else if(indexPath.row==2){
        self.objDetailCustomerServiceViewCtrl.strServiceType = @"Application Status";
       
    }else if(indexPath.row==3){
        self.objDetailCustomerServiceViewCtrl.strServiceType = @"Pay your card bill";
       
    }
    else if(indexPath.row==4){
        self.objDetailCustomerServiceViewCtrl.strServiceType = @"Redeem Rewards";
       
    }

    
    
    [self.navigationController pushViewController: self.objDetailCustomerServiceViewCtrl animated:YES];
    
}

@end
