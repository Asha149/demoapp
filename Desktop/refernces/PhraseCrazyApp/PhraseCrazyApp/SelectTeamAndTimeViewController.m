//
//  SelectTeamAndTimeViewController.m
//  PhraseCrazyApp
//
//  Created by ajeet Singh on 08/10/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import "SelectTeamAndTimeViewController.h"
#import "PlayGameViewController.h"
#import "AppDelegate.h"
#import "ViewController.h"
#import "Team3PlayViewController.h"
#import "Team4PlayViewController.h"

#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)

@interface SelectTeamAndTimeViewController ()

@end

@implementation SelectTeamAndTimeViewController
@synthesize lblMinutes,lblTeam,pkvMinutes,pkvTeam;
@synthesize btnPlay;
@synthesize btnBack;

NSMutableArray *arrMinutes,*arrTeams;

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
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    appDelegate.IsTimed = TRUE;
    
    arrMinutes = [[NSMutableArray alloc]initWithObjects:@"2 Minutes",@"3 Minutes",@"4 Minutes",@"5 Minutes",@"6 Minutes",nil];
    arrTeams = [[NSMutableArray alloc]initWithObjects:@"2 Teams",@"3 Teams",@"4 Teams", nil];
    
    [pkvTeam setFrame:CGRectMake(pkvTeam.frame.origin.x, pkvTeam.frame.origin.y,pkvTeam.frame.size.width,pkvTeam.frame.size.height -30)];
    [pkvMinutes setFrame:CGRectMake(pkvMinutes.frame.origin.x, pkvMinutes.frame.origin.y,pkvMinutes.frame.size.width,pkvMinutes.frame.size.height -30)];
    
    NSString *version = [[UIDevice currentDevice] systemVersion];
    BOOL isAtLeast7 = [version floatValue] >= 7.0;
    if (isAtLeast7)
    {
        pkvTeam = [[UIPickerView alloc] initWithFrame:CGRectMake(0, IS_IPHONE5 ?388:280, 320, 150)];
    }
    else
    {
        pkvTeam = [[UIPickerView alloc] initWithFrame:CGRectMake(0, IS_IPHONE5 ?368:280, 320, 150)];
        
    }
    
}

#pragma mark - PickerView Methods...
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(pickerView == pkvMinutes)
    {
        return [arrMinutes count];
    }
    else
    {
        return [arrTeams count];
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(pickerView == pkvMinutes)
    {
        return [arrMinutes objectAtIndex:row];
    }
    else
    {
        return [arrTeams objectAtIndex:row];
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component
{
    if(pickerView == pkvMinutes)
    {
        lblMinutes.text = [arrMinutes objectAtIndex:row];
        appDelegate.Time = [[arrMinutes objectAtIndex:row]intValue];
        if(appDelegate.Time == 0)
        {
            appDelegate.Time = [[arrMinutes objectAtIndex:0]intValue];
            lblMinutes.text = [arrMinutes objectAtIndex:0];
        }
    }
    else
    {
        lblTeam.text = [arrTeams objectAtIndex:row];
        appDelegate.Team = [[arrTeams objectAtIndex:row]intValue];
        if(appDelegate.Team == 0)
        {
            appDelegate.Team = [[arrTeams objectAtIndex:0]intValue];
            lblTeam.text = [arrTeams objectAtIndex:0];
        }
        
    }
    
}
-(IBAction)btnPlay_click:(id)sender
{
    
   
    
    if(appDelegate.Team == 3)
    {
        if(appDelegate.Time == 0)
        {
            appDelegate.Time = [[arrMinutes objectAtIndex:0]intValue];
            lblMinutes.text = [arrMinutes objectAtIndex:0];
        }
        if(appDelegate.Team == 0)
        {
            appDelegate.Team = [[arrTeams objectAtIndex:0]intValue];
            lblTeam.text = [arrTeams objectAtIndex:0];
        }
        Team3PlayViewController *vc = [[Team3PlayViewController alloc]init];
        [self presentViewController:vc animated:YES completion:nil];
        return;
    }
    else if (appDelegate.Team == 4)
    {
        if(appDelegate.Time == 0)
        {
            appDelegate.Time = [[arrMinutes objectAtIndex:0]intValue];
            lblMinutes.text = [arrMinutes objectAtIndex:0];
        }
        if(appDelegate.Team == 0)
        {
            appDelegate.Team = [[arrTeams objectAtIndex:0]intValue];
            lblTeam.text = [arrTeams objectAtIndex:0];
        }
        Team4PlayViewController *vc = [[Team4PlayViewController alloc]init];
        [self presentViewController:vc animated:YES completion:nil];
    }
    else
    {
        if(appDelegate.Time == 0)
        {
            appDelegate.Time = [[arrMinutes objectAtIndex:0]intValue];
            lblMinutes.text = [arrMinutes objectAtIndex:0];
        }
        if(appDelegate.Team == 0)
        {
            appDelegate.Team = [[arrTeams objectAtIndex:0]intValue];
            lblTeam.text = [arrTeams objectAtIndex:0];
        }
        PlayGameViewController *vc = [[PlayGameViewController alloc]init];
        [self presentViewController:vc animated:YES completion:Nil];
        
    }

    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)btnBack_click:(id)sender
{
    ViewController *vc = [[ViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}
@end
