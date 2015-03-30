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

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface ViGo : NSObject

+(ViGo *)shared;
-(void)initCredential:(NSString*)url andUsername:(NSString*)userName andPassword:(NSString*)passWord andOrgId:(NSString*)orgID;
-(NSString*)getUrl;
-(NSString*)getUserName;
-(NSString*)getPassword;
-(NSString*)getOrgID;
-(NSDictionary*)getRecordSettings;

@end

@interface ViGoAudioRecorder : AVAudioRecorder

- (void)onRecordComplete:(float)time andCallBack:(void (^)(NSData* audioData, NSError *error))_completionBlock;

@end

@interface RegisterClaimantClass : NSObject <NSXMLParserDelegate>

- (void)onClaimantRegistered:(void (^)(NSDictionary* dict, NSError *error))_completionBlock;

@end



@interface StartDialogueClass : NSObject <NSXMLParserDelegate>

- (id)initWithData:(NSString*)claimantID andConfigID:(NSString*)configurationID andCallRef:(NSString*)callReference __attribute__((deprecated));
- (id)initWithData:(NSString*)claimantID andConfigID:(NSString*)configurationID andCallRef:(NSString*)callReference andLanguage:(NSString*)language;
- (void)onDialogueStarted:(void (^)(NSDictionary* dict, NSError *error))_completionBlock;

@end

@interface SubmitPhraseClass : NSObject <NSXMLParserDelegate>

- (id)initWithData:(NSString*)dialogueID andUtterance:(NSData*)audioData andPrompt:(NSString*)promptHint;
- (void)onPhraseSubmitted:(void (^)(NSDictionary* dict, NSError *error))_completionBlock;

@end

@interface AbortDialogueClass : NSObject <NSXMLParserDelegate>

- (id)initWithData:(NSString*)dialogueID;
- (void)onDialogueAborted:(void (^)(NSDictionary* dict, NSError *error))_completionBlock;

@end

@interface DeleteClaimantClass : NSObject <NSXMLParserDelegate>

- (id)initWithData:(NSString*)claimantID;
- (void)onClaimantDeleted:(void (^)(NSDictionary* dict, NSError *error))_completionBlock;

@end

@interface AdaptClaimantClass : NSObject <NSXMLParserDelegate>

- (id)initWithData:(NSString*)claimantID andDialogueID:(NSString*)dialogueID;
- (void)onClaimantAdapted:(void (^)(NSDictionary* dict, NSError *error))_completionBlock;

@end




