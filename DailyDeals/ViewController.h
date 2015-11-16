//
//  ViewController.h
//  DailyDeals
//
//  Created by MyAppTemplates Software on 07/04/14.
//  Copy/Users/subhashkrjha/Desktop/DailyDeals/DailyDeals/Base.lproj/Main.storyboard
//Users/subhashkrjha/Desktop/DailyDeals/DailyDeals/ViewController.h
//Users/subhashkrjha/Desktop/DailyDeals/DailyDeals/ViewController.mright (c) 2014 MyAppTemplates Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADBMobile.h"


@interface ViewController : UIViewController<UITextFieldDelegate>
@property(nonatomic,strong)IBOutlet UIScrollView *scrollView;
@property(nonatomic,strong)IBOutlet UIButton *btnTwitter;
@property(nonatomic,strong)IBOutlet UIButton *btnFacebook;
@property(nonatomic,strong)IBOutlet UIButton *btnLogin;
@property(nonatomic,strong)IBOutlet UIButton *btnRegister;
@property(nonatomic,strong)IBOutlet UITextField *txtFieldEmail;
@property(nonatomic,strong)IBOutlet UITextField *txtFieldPassword;
@property(nonatomic,strong)IBOutlet UILabel *welcomeMessage;

-(void)welcomeMessageCampaign;
-(void)socialLoginCampaign;
-(void)welcomeMessageCampaignChanges: (NSString*) content;
-(void)socialLoginCampaignChanges: (NSString*) content;
-(void) makeMboxConfirm;

-(IBAction)btnLoginClk:(id)sender;
-(IBAction)btnFacebookLoginClk:(id)sender;
-(IBAction)btnTwitterClk:(id)sender;


@end
