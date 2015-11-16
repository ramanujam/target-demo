//
//  DailyDealsViewController.m
//  DailyDeals
//
//  Created by MyAppTemplates Software on 07/04/14.
//  Copyright (c) 2014 MyAppTemplates Software. All rights reserved.
//

#import "DailyDealsViewController.h"
#import "DailyDealsCell.h"
#import "ProfileViewController.h"
#import "DealsDetailsViewController.h"
#import "Container.h"
#import "ADBMobile.h"
@interface DailyDealsViewController ()

@property BOOL useWEST;

@end

@implementation DailyDealsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        // Custom initialization
        self.inApp = [[NSMutableArray alloc] init];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    [self runLocationTargeting];
    //Add side bar on view
    self.appMenu=[[AppMenuView alloc] initWithNibName:@"AppMenuView" bundle:nil];
    
    self.appMenu.delegate=self;

    [self.viewAppMenu addSubview:self.appMenu.view];
   
}
- (void) runLocationTargeting {
    
    [ADBMobile targetClearCookies];
    
    ADBTargetLocationRequest *locationRequest = [ADBMobile targetCreateRequestWithName:@"content-campaign" defaultContent:@"Niagara Falls Day Trip/New York, USA/$175/$500/30/museumtour.jpg;National Air and Space Museum Tour/Washington, D.C., USA/$30/$75/25/niagrafalls.jpg;Florida Keys Weekend Getaway/Key West, Florida, USA/$750/$1200/75/floridakeys.png;4 Tickets to Broadway Musical (You Choose Which!)/New York City, New York, USA/$100/$400/100/broadway.png;New England Lobster Dinner/Portland, Maine, USA/$75/$200/40/LobsterDinner.jpg;" parameters:nil];
    
    
    [ADBMobile targetLoadRequest:locationRequest callback:^(NSString *content) {
        self.inApp = [content componentsSeparatedByString: @";"];
        [self performSelectorOnMainThread:@selector(setContent) withObject:content waitUntilDone:NO];
        
    }];
}

-(void) setContent
{
    [self.tblViewDeals reloadData];

    
}

#pragma mark UITableViewDelegate and UITableViewDatasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([self.inApp count] == 0) {
        return 0;
    } else {
        return 1;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.inApp count] == 0) {
        return 0;
    } else {
        return 5;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        
    NSString *cellIdentifier=@"DailyDealsCell";

        DailyDealsCell *cell=(DailyDealsCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            UIViewController *controller = [[UIViewController alloc]initWithNibName:@"DailyDealsCell" bundle:nil];
            cell= (DailyDealsCell *)controller.view;
            
        }

       //cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[self.inApp objectAtIndex:indexPath.row]]];
       // deals title deals location current price old price purchase count image name
       NSString *cellString = [self.inApp objectAtIndex:(indexPath.row)];
       NSArray *cellInfo = [cellString componentsSeparatedByString: @"/"];
       cell.imageView.image = [UIImage imageNamed:[cellInfo objectAtIndex:5]];
       cell.lblDealsTitle.text=cellInfo[0];
       cell.lblDealsState.text = cellInfo[1];
       cell.lblDealsCurrentPrice.text = cellInfo[2];
       cell.lblDealsOldPrice.text = cellInfo[3];
       cell.lblDealsPurchasedCount.text = cellInfo[4];
        
    return cell;
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [self performSegueWithIdentifier:@"DailyDealsToDetails" sender:self];
}
-(IBAction)btnProfileClk:(id)sender
{
    [self performSegueWithIdentifier:@"DailyDealsToProfile" sender:self];
}
-(IBAction)btnSlideManuClk:(id)sender
{
   
    if(!self.btnSlide.selected){
        [self openAppMenu];
        self.btnSlide.selected=YES;
    }else{
       self.btnSlide.selected=NO;
        [self hideAppMenu];
    }
}
-(void)openAppMenu{
    
    tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tapGesture.delegate=self;
    [self.viewContainer addGestureRecognizer:tapGesture];
    [self moveByX:160.0 animated:YES];
    
}
-(void)hideAppMenu{
    // self.navBack.backgroundColor=[UIColor whiteColor];
    self.btnSlide.selected=NO;
    [self.viewContainer removeGestureRecognizer:tapGesture];
    [self moveByX:0.0 animated:YES];
}
-(void)tapAction:(id)sender
{
    if (self.appMenu) {
        [self hideAppMenu];
    }
}

#pragma mark - App menu delegates
-(void)menuSelected:(NSString *)selectedText
{
    //selected text
}

-(void)moveByX:(CGFloat)x animated:(BOOL)animated{
    
    CGRect rect=self.viewContainer.frame;
    
    rect.origin.x=x;
    
    if(animated){
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.3];
        self.viewContainer.frame=rect;
        [UIView commitAnimations];
        
    }else{
        self.viewContainer.frame=rect;
    }
    
    
}


-(IBAction)btnSearchClk:(id)sender
{
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"DailyDealsToProfile"]) {
        
         //ProfileViewController *newSegue=segue.destinationViewController;
        //Pass any value to dailyDetails ViewController if require
    }
    if ([segue.identifier isEqualToString:@"DailyDealsToProfile"]) {
        
        //DealsDetailsViewController *newSegue=segue.destinationViewController;
        //Pass any value to dailyDetails ViewController if require
    }
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
