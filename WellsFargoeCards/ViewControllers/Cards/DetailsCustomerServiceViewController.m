//
//  DetailsCustomerServiceViewController.m
//  eWallet
//
//  Created by Mummidi, Raja on 1/7/15.
//
//

#import "DetailsCustomerServiceViewController.h"
#import "DetailsCustomerServiceCell.h"
#import <UIKit/UIKit.h>
#import "Constant.h"
@interface DetailsCustomerServiceViewController ()<UITabBarDelegate>

@end

@implementation DetailsCustomerServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
       self.tabContactOptions.delegate=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.title= self.strServiceType;
    self.tbleTransctions.layer.borderWidth=1.0f;
    self.tbleTransctions.layer.borderColor = [UIColor lightGrayColor].CGColor;
   // self.tbleTransctions.layer.cornerRadius=5.0f;
    //[self.tbleTransctions.layer setMasksToBounds:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section==0){
        
        return  @"Phone Number";
       
    }
    else if(section==1){
         return   @"Email";
       // cell.lblCall.text=@"1-925-825-7600";
        //  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if(section==2){
         return   @"Working Hours";
      
        // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return @"";
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
        return 2;
    else
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"newFriendCell";
    DetailsCustomerServiceCell *cell;
    
    if (cell == nil) {
        cell = [[DetailsCustomerServiceCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        UINib *nib = [UINib nibWithNibName:@"DetailsCustomerServiceCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    }
    cell = (DetailsCustomerServiceCell *)[tableView dequeueReusableCellWithIdentifier:@"newFriendCell"];
   
 //   btnCall.frame=CGRectMake(30, 30,50, 40);
    
    if(indexPath.section==0){
            if(indexPath.row==0){
                
                cell.lblType.text = @"Phone Number";
                 cell.txtView.text=@"1-800-642-4720";
                
              //  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            else if(indexPath.row==1){
                cell.lblType.text = @"International Collect Calls";
                 cell.txtView.text=@"1-925-825-7600";
              //  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
    }
    else if(indexPath.section==1){
        cell.lblType.text = @"Email";
        cell.txtView.text=@"customercare@mybank.com";
        //  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if(indexPath.section==2){
        cell.lblType.text = @"Working Hours";
        cell.lblInfo.hidden=NO;
        cell.lblInfo.text=@"24 hours a day, 7 days a week";
        cell.txtView.hidden=YES;
       // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 59, tableView.frame.size.width, 1)];
    label.backgroundColor=[UIColor grayColor];
    label.alpha=0.35;
    [cell addSubview:label];
  
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

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
        
        NSArray *toRecipients = [NSArray arrayWithObjects:@"customercare@mybank.com", @"bankcards@mybank.com", nil];
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

@end
