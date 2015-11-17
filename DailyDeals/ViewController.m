//
//  ViewController.m
//  DailyDeals
//
//  Created by MyAppTemplates Software on 07/04/14.
//  Copyright (c) 2014 MyAppTemplates Software. All rights reserved.
//

#import "ViewController.h"
#import "DailyDealsViewController.h"
#import "ADBMobile.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    [self welcomeMessageCampaign];
    [self makeMboxConfirm];
    
    /* UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Daily Deals" message:@"Please take a moment to rate our app!" delegate:self cancelButtonTitle:@"Not now, remind me later" otherButtonTitles:nil];
     // optional - add more buttons:
     [alert addButtonWithTitle:@"Yes, I'll rate you now"];
     [alert addButtonWithTitle:@"No, thanks"];
     [alert show];*/
    
    // Do any additional setup after loading the view, typically from a nib.
    //Hide navigation bar and set scrollview contentSize
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    self.scrollView.contentSize=CGSizeMake(320, 560);
    
    _btnFacebook.hidden = YES;
    _btnTwitter.hidden = YES;
    
    [self socialLoginCampaign];
    [self makeMboxConfirm];
    
    
}
#pragma mark Button Action
-(IBAction)btnLoginClk:(id)sender
{
    [self performSegueWithIdentifier:@"loginToDailyDeatls" sender:self];
}
-(IBAction)btnFacebookLoginClk:(id)sender
{
    [self performSegueWithIdentifier:@"loginToDailyDeatls" sender:self];
}
-(IBAction)btnTwitterClk:(id)sender
{
    [self performSegueWithIdentifier:@"loginToDailyDeatls" sender:self];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"loginToDailyDeatls"]) {
        
        // DailyDealsViewController *newSegue=segue.destinationViewController;
        //Pass any value to dailyDetails ViewController if require
    }
}
#pragma mark UITExtField delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self moveScrollView:textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==self.txtFieldEmail) {
        [self.txtFieldPassword becomeFirstResponder];
        
        
    }else if(textField==self.txtFieldPassword)
    {
        [self.txtFieldPassword resignFirstResponder];
        [self originalSizeScrollView:textField];
    }
    
    return YES;
}
#pragma mark ScrollView methods ::::::::::::::::::::::::::::::::::::::::::::

-(void)moveScrollView:(UIView *)theView{
    
    CGRect rc = [theView bounds];
    
    rc = [theView convertRect:rc toView:self.scrollView];
    CGPoint pt = rc.origin;
    pt.x = 0;
    pt.y=pt.y-150;
    
    [self.scrollView setContentOffset:pt animated:YES];
}

-(void)originalSizeScrollView:(UIView *)theView{
    
    CGRect rc = [theView bounds];
    
    rc = [theView convertRect:rc toView:self.scrollView];
    CGPoint pt = rc.origin;
    pt.x = 0;
    pt.y = 0;
    [self.scrollView setContentOffset:pt animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)welcomeMessageCampaignChanges: (NSString*) content
{
    self.welcomeMessage.text = content;
    self.welcomeMessage.font = [UIFont fontWithName:@"Helvetica" size:13];
    self.welcomeMessage.numberOfLines = 0;
}



-(void)welcomeMessageCampaign
{
    
    //  Passing custom parameters for targeting. In this example, the parameters are
    //  hardcoded but typically variables should be used for sending custom profile information.
    
    NSDictionary *targetParams = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  @"true", @"loyaltyAccount",
                                  @"platinum", @"memberLevel",
                                  @"prod",@"host",
                                  @"fashion",@"entity.categoryId", nil];  //nil to signify end of objects and keys.
    
    //  Create and load target request. Here "welcome-message" is the name of the location.
    //  This shows up in the dropdown in the UI.
    ADBTargetLocationRequest* locationRequest = [ADBMobile targetCreateRequestWithName:@"welcome-message"
                                                                        defaultContent:@"Welcome new user!"
                                                                            parameters:targetParams];
    
    [ADBMobile targetLoadRequest:locationRequest callback:^(NSString *content)
     
     {
         NSLog(@"Response from Target --- %@", content);
         
         //It is typically a bad practice to run on the main thread!
         [self performSelectorOnMainThread:@selector(welcomeMessageCampaignChanges:) withObject:content waitUntilDone:NO];
         
     }];
    
}

-(void)socialLoginCampaignChanges: (NSString*) content
{
    //    NSLog(@"Response from Target --- %@", content);
    if ([content isEqualToString:@"fb"])
    {
        _btnFacebook.hidden = NO;
    }
    else if ([content isEqualToString:@"tw"])
    {
        _btnTwitter.hidden = NO;
    }
    else if ([content isEqualToString:@"both-social"])
    {
        _btnFacebook.hidden = NO;
        _btnTwitter.hidden = NO;
    }
    
}


-(void)socialLoginCampaign
{
    
    ADBTargetLocationRequest* locationRequest = [ADBMobile targetCreateRequestWithName:@"social-signup" defaultContent:@"Default Message" parameters:nil];
    [ADBMobile targetLoadRequest:locationRequest callback:^(NSString *content)
     
     {
         [self performSelectorOnMainThread:@selector(socialLoginCampaignChanges:) withObject:content waitUntilDone:NO];
     }
     ];
    
    
}

//Send a conversion event with orderTotal

-(void) makeMboxConfirm
{
    
    ADBTargetLocationRequest* orderConfirm = [ADBMobile targetCreateOrderConfirmRequestWithName:@"signed-up" orderId:@"order" orderTotal:@"2.00" productPurchasedId:nil parameters:nil];
    [ADBMobile targetLoadRequest:orderConfirm callback:nil];
    
}

@end
