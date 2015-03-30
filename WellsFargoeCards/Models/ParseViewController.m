//
//Copyright (c) 2014, VoiceVault Inc.
//All rights reserved.
//
//Redistribution and use in source and binary forms, with or without
//modification, are permitted provided that the following conditions are met:
//* Redistributions of source code must retain the above copyright
//notice, this list of conditions and the following disclaimer.
//* Redistributions in binary form must reproduce the above copyright
//notice, this list of conditions and the following disclaimer in the
//documentation and/or other materials provided with the distribution.
//* Neither the name of VoiceVault nor the names of its contributors
//may be used to endorse or promote products derived from this
//software without specific prior written permission.
//
//THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//DISCLAIMED. IN NO EVENT SHALL VOICEVAULT BE LIABLE FOR ANY
//DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "ParseViewController.h"
#import "ViGo.h"
#import "VoiceVaultData.h"
//#import "DAViewController.h"

static NSString* const VIGO_PHRASE_TEXT = @"***Enter the passphrase for your selected configuration here***";
static float const VIGO_RECORD_TIME_SECS = 5.0f; // Change this if you require a different duration for the selected passphrase.

@interface ParseViewController ()

@end

@implementation ParseViewController
@synthesize lbStatus;
@synthesize btnRecord;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
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
    lbStatus.text = @"Press the button and speak";
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
                                                                             delegate:nil
                                                                    cancelButtonTitle:@"OK"
                                                                    otherButtonTitles:nil];
                            [message show];
                        
                        
                        }
                        
                        
                       /// UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
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
@end
