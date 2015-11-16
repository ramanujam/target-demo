//
//  DealsDetailsViewController.h
//  DailyDeals
//
//  Created by MyAppTemplates Software on 08/04/14.
//  Copyright (c) 2014 MyAppTemplates Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponViewController.h"
@interface DealsDetailsViewController : UIViewController
@property(nonatomic,strong)CouponViewController *controller;
-(IBAction)btnBackClk:(id)sender;
-(IBAction)btnBuyClk:(id)sender;

-(void)socialShareCampaignChanges: (NSString*)content;
-(void) socialShareCampaign;
@property(nonatomic, strong) IBOutlet UIButton *fbShare;
@property(nonatomic, strong) IBOutlet UIButton *twShare;
@end
