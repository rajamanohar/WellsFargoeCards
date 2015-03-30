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

#import "VoiceVaultData.h"

@implementation VoiceVaultData

@synthesize claimantID;
@synthesize dialogueID;


static VoiceVaultData *sharedSingletonClass = nil;

+(VoiceVaultData*) sharedInstance
{
    if(sharedSingletonClass == nil)
        sharedSingletonClass = [[VoiceVaultData alloc] init];
    
    return sharedSingletonClass;
    
}

-(id)init
{
    
    self = [super init];
    if (self){
        claimantID = [[NSString alloc]init];
        dialogueID = [[NSString alloc]init];
        claimantID = @"";
        dialogueID = @"";


    }
    return self;
    
}

-(void) SetDialogueID:(NSString*)dialID;
{
    dialogueID = dialID;
    
}

-(NSString*)GetDialogueID;
{
    return dialogueID;
}

-(void) setClaimantID:(NSString *)claimID
{
    claimantID = claimID;

}
-(NSString*)getClaimantID
{
    return claimantID;

}



@end
