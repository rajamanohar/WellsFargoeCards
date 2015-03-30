//
//  VoiceAuthenticationViewController.m
//  eWallet
//
//  Created by Mummidi, Raja on 1/7/15.
//
//

#import "VoiceAuthenticationViewController.h"

#import "ViGo.h"
#import "ParseViewController.h"
#import "VoiceVaultData.h"
#import "VoiceLoginViewController.h"


static NSString* const VIGO_SERVER_URL = @"https://a9i1.voicevault.net/RestApi850/";
static NSString* const VIGO_CREDENTIAL_ID = @"DgK9sVG3JBSFYnkjd7MC";
static NSString* const VIGO_CREDENTIAL_PWD = @"UUPNVyNaeS7pHzeYE7wv3wQHKfffB9";
static NSString* const VIGO_APP_ID = @"5f37a122-a8f5-41f1-bcb6-92861065efb9";
//static NSString* const VIGO_CONFIGURATION_ID = @"1722f1b9-9294-4b81-b52f-83d756529e9f"; //"People carry umbrellas when it is raining"
static NSString* const VIGO_CONFIGURATION_ID = @"1924e68e-e337-44e3-b3da-2fa56c44fc1b";
static NSString* const VIGO_PHRASE_LANGUAGE = @"EnglishUnitedStates"; // Change this only if you are using a configuration ID that corresponds to a different language.


@interface VoiceAuthenticationViewController ()

@end



@implementation VoiceAuthenticationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title=@"Voice Authentication";
    
    
    UIImage *image = [UIImage imageNamed: @"VoiceVault.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: image];
    imageView.frame = CGRectMake(100, 0, 109, 30);
    
    CGRect applicationFrame = CGRectMake(0, 0, 300, 40);
    UIView * newView = [[UIView alloc] initWithFrame:applicationFrame];
    [newView addSubview:imageView];
    self.navigationItem.titleView = newView;
    
   
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.btnRegistration.enabled = YES;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if([defaults objectForKey:@"claimantID"]){
        [[VoiceVaultData sharedInstance]setClaimantID:[defaults objectForKey:@"claimantID"]];
         self.btnLogin.enabled = YES;
    }
    
    else
        self.btnLogin.enabled = NO;
    
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





-(void)viewDidAppear:(BOOL)animated
{
    self.btnRegistration.enabled = YES;
    
    
}


- (IBAction)onRegistration:(id)sender {
    
    self.btnRegistration.enabled = NO;
    
    
    [[ViGo shared]initCredential:VIGO_SERVER_URL andUsername:VIGO_CREDENTIAL_ID andPassword:VIGO_CREDENTIAL_PWD andOrgId:VIGO_APP_ID];
    
    RegisterClaimantClass *registerClaimant = [[RegisterClaimantClass alloc]init];
    
    [registerClaimant onClaimantRegistered:^(NSDictionary *dict, NSError *error) {
        
        
        if (!error)
        {
            
            NSLog(@"Success");
            NSString *claimantID = [dict objectForKey:@"claimant_id"];
            [[VoiceVaultData sharedInstance]setClaimantID:claimantID];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:claimantID forKey:@"claimantID"];
   
            
            
            StartDialogueClass *startDialogue = [[StartDialogueClass alloc] initWithData:claimantID  andConfigID:VIGO_CONFIGURATION_ID andCallRef:@"iOS Sample App" andLanguage:VIGO_PHRASE_LANGUAGE];
            
            [startDialogue onDialogueStarted:^(NSDictionary *dict, NSError *error) {
                
                if (!error)
                {
                    
                    NSString *dialogue = [dict objectForKey:@"dialogue_id"];
                    [[VoiceVaultData sharedInstance]SetDialogueID:dialogue];
                    
                    
                    
                    VoiceLoginViewController *objView  = [[VoiceLoginViewController alloc] initWithNibName:@"VoiceLoginViewController" bundle:nil];
                    [self.navigationController pushViewController:objView animated:NO];
                    
                    NSLog(@"Success");
                    
                }else{
                    
                    
                    NSLog(@"Fail");
                    
                }
                
            }];
            
            
            
            
        }else{
            
            
            NSLog(@"Fail");
            
        }
        
    }];
    
    
    
    
    
    
}

- (IBAction)onLogin:(id)sender {
    
    [[ViGo shared]initCredential:VIGO_SERVER_URL andUsername:VIGO_CREDENTIAL_ID andPassword:VIGO_CREDENTIAL_PWD andOrgId:VIGO_APP_ID];
    
    RegisterClaimantClass *registerClaimant = [[RegisterClaimantClass alloc]init];
    
    [registerClaimant onClaimantRegistered:^(NSDictionary *dict, NSError *error) {
        
        
        
        StartDialogueClass *startDialogue = [[StartDialogueClass alloc]initWithData:[[VoiceVaultData sharedInstance] getClaimantID]  andConfigID:VIGO_CONFIGURATION_ID andCallRef:@"iOS Sample App" andLanguage:VIGO_PHRASE_LANGUAGE];
        
        [startDialogue onDialogueStarted:^(NSDictionary *dict, NSError *error) {
            
            if (!error)
            {
                
                NSString *dialogue = [dict objectForKey:@"dialogue_id"];
                [[VoiceVaultData sharedInstance]SetDialogueID:dialogue];
                
                
                VoiceLoginViewController *objView  = [[VoiceLoginViewController alloc] initWithNibName:@"VoiceLoginViewController" bundle:nil];
                objView.strSourcePage=@"Login";
                [self.navigationController pushViewController:objView animated:NO];
                
                NSLog(@"Success");
                
            }else{
                
                
                NSLog(@"Fail");
                
            }
        }];
        
    }];
    
    
}



@end
