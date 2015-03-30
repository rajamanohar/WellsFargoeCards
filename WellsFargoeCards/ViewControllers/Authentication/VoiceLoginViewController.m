//
//  VoiceLoginViewController.m
//  eWallet
//
//  Created by Mummidi, Raja on 1/7/15.
//
//

#import "VoiceLoginViewController.h"
#import "ParseViewController.h"
#import "ViGo.h"
#import "VoiceVaultData.h"
//#import "DatabaseQueryHandler.h"
//static NSString* const VIGO_PHRASE_TEXT = @"At VoiceVault, my voice is my password";
static NSString* const VIGO_PHRASE_TEXT = @"People carry umbrellas when it is raining";
static float const VIGO_RECORD_TIME_SECS = 5.0f; // Change this if you require a different duration for the selected passphrase.
@interface VoiceLoginViewController ()

@end

@implementation VoiceLoginViewController
@synthesize lbStatus;
@synthesize btnRecord;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *image = [UIImage imageNamed: @"VoiceVault.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: image];
    imageView.frame = CGRectMake(50, 0, 109, 30);
    
    CGRect applicationFrame = CGRectMake(0, 0, 300, 40);
    UIView * newView = [[UIView alloc] initWithFrame:applicationFrame];
    [newView addSubview:imageView];
    self.navigationItem.titleView = newView;
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryRecord error:nil];
    if ([self.strSourcePage isEqualToString:@"Login"]) {
        lbStatus.text = @"Press the button and speak";
    }else{
    lbStatus.text = @"Press the button and speak until sucess alert appears";
    }
    [btnRecord setBackgroundColor:[UIColor greenColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)onRecord:(id)sender {
    
    btnRecord.enabled = NO;
    [btnRecord setBackgroundColor:[UIColor grayColor]];
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* docsDir = [dirPaths objectAtIndex:0];
    
    NSString *soundFilePath = [docsDir stringByAppendingPathComponent:@"audio.wav"];
    
    
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    NSError *error = nil;
    
    ViGoAudioRecorder *recorder = [[ViGoAudioRecorder alloc]initWithURL:soundFileURL settings:[[ViGo shared]getRecordSettings] error:&error];
    
    [recorder onRecordComplete:VIGO_RECORD_TIME_SECS andCallBack:^(NSData *audioData, NSError *error) {
        
        if (!error)
        {
            SubmitPhraseClass *submitPhrase = [[SubmitPhraseClass alloc]initWithData:[[VoiceVaultData sharedInstance] GetDialogueID] andUtterance:audioData andPrompt:VIGO_PHRASE_TEXT];
            [submitPhrase onPhraseSubmitted:^(NSDictionary *dict, NSError *error) {
                if (!error)
                {
                    NSLog(@"Success");
                    btnRecord.enabled = YES;
                    [btnRecord setBackgroundColor:[UIColor greenColor]];
                    
                    
                    if ([[dict objectForKey:@"dialogue_status"]isEqualToString:@"Succeeded"] || [[dict objectForKey:@"dialogue_status"]isEqualToString:@"Failed"])
                    {
                        if ([[dict objectForKey:@"dialogue_status"]isEqualToString:@"Succeeded"])
                        {
                            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Success"
                                                                              message:@"Success"
                                                                             delegate:self
                                                                    cancelButtonTitle:@"OK"
                                                                    otherButtonTitles:nil];
                            [message show];
                            
                            
                        }
                        
                        
                        //UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                       // DAViewController *objView  = [storyboard instantiateViewControllerWithIdentifier:@"DAViewController"];
                       // [self.navigationController pushViewController:objView animated:NO];
                        
                    }
                    
                    
                }else
                {
                    
                    NSLog(@"Fail");
                    
                }
            }];
            
            
            NSLog(@"Success");
            
        }else{
            
            
            NSLog(@"Fail");
            
        }
    }];
    
    
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   if([self.strSourcePage isEqualToString:@"Login"])
   {
//       NSArray *arrResponse=[DatabaseQueryHandler getCustomerDetails:@"543200" andPassword:@"wells@123"];
       //[self didDownloadComplete:arrResponse];
       
   }else{
        [self.navigationController popViewControllerAnimated:YES];
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
