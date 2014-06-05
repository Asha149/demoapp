//
//  GroupPlayViewController.m
//  PhraseCrazyApp
//
//  Created by ajeet Singh on 24/10/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import "GroupPlayViewController.h"
#import "ViewController.h"
#import "PhraseObjectClass.h"
#import "PhraseDatabaseClass.h"
#import "ScoreForGroupPlayViewController.h"

#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-480)?NO:YES)

@interface GroupPlayViewController ()

@end

@implementation GroupPlayViewController
@synthesize lblPhrase,btnSuccess,btnStartTurn,btnNewPhrase,btnEndgame,btnBack;
@synthesize arrPhrases = _arrPhrase;



int ScoreTeam1,ScoreTeam2;
int randNum,varChangeTeam;
int countNewTeamButton;

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
     self.arrPhrases = [PhraseDatabaseClass database].getPhrases;
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if(IS_IPHONE5)
    {
        
        [self.lblPhrase setFrame:CGRectMake(self.lblPhrase.frame.origin.x, self.lblPhrase.frame.origin.y+25, self.lblPhrase.frame.size.width, self.lblPhrase.frame.size.height)];
    }

   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark click event

-(IBAction)btnBack_click:(id)sender
{
    ViewController *vc = [[ViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}
-(IBAction)btnNewPhrase_click:(id)sender
{
    randNum = (arc4random()%3700);
    PhraseObjectClass *info = [_arrPhrase objectAtIndex:randNum];
    NSLog(@"phrase :: %@",info.Phrases);
    //lblPhrase.text = info.Phrases;
    
}
-(IBAction)btnNewteam_click:(id)sender
{
    [btnSuccess setHidden:NO];
    [btnNewPhrase setHidden:NO];
    countNewTeamButton ++;
    if(appDelegate.intPhraseNo > 51)
    {
        appDelegate.intPhraseNo = 0;
    }
        
    appDelegate.intPhraseNo ++;
    NSLog(@"int phrase no.%d",appDelegate.intPhraseNo);
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",appDelegate.intPhraseNo]forKey:@"PhraseNo"];
    randNum = (arc4random()%3700);
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"PhraseNo"];
    int PhraseNo = [str intValue];
    PhraseObjectClass *info = [_arrPhrase objectAtIndex:PhraseNo];
    lblPhrase.text = info.Phrases;
    //lblPhrase.text = @"Ask not what you can do for your country, rather ask what your country can do for you!";
   // lblPhrase.text = @"Early to bed, early to rise makes a man healthy, wealthy and wise !";
}

-(IBAction)btnSuccess_click:(id)sender
{
    if(countNewTeamButton % 2 == 0)
    {
        ScoreTeam2 = ScoreTeam2 + 1;
       
    }
    else
    {
        ScoreTeam1 = ScoreTeam1 + 1;
    }
    [lblPhrase setText:@""];
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@""
                          message:@"Your turn is over - next person’s turn."
                          delegate:self
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:@"Cancel",
                          nil];
    
    [alert show];



}
-(IBAction)btnEndGame_click:(id)sender
{
    ViewController *vc = [[ViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
    
//    if(ScoreTeam1 == ScoreTeam2)
//    {
//        UIAlertView *alert = [[UIAlertView alloc]
//                              initWithTitle:@""
//                              message:@"Game is tie."
//                              delegate:self
//                              cancelButtonTitle:@"Ok"
//                              otherButtonTitles:@"Cancel",
//                              nil];
//        alert.tag = 4;
//        [alert show];
//        
//        
//    }
//    else if(ScoreTeam1 > ScoreTeam2)
//    {
//        UIAlertView *alert = [[UIAlertView alloc]
//                              initWithTitle:@""
//                              message:@"Team 1 is winner."
//                              delegate:self
//                              cancelButtonTitle:@"Ok"
//                              otherButtonTitles:@"Cancel",
//                              nil];
//        alert.tag = 4;
//        [alert show];
//    }
//    else
//    {
//        UIAlertView *alert = [[UIAlertView alloc]
//                              initWithTitle:@""
//                              message:@"Team 2 is winner."
//                              delegate:self
//                              cancelButtonTitle:@"Ok"
//                              otherButtonTitles:@"Cancel",
//                              nil];
//        alert.tag = 4;
//        [alert show];
//    }
//   
    
}
#pragma mark alert view button click event
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 4)
    {
        if(buttonIndex == 0)
        {
            ScoreTeam1 =0;
            ScoreTeam2 =0;
           
            
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@""
                                  message:@""
                                  delegate:self
                                  cancelButtonTitle:@"Back to Menu"
                                  otherButtonTitles:@"Exit",
                                  nil];
            alert.tag = 9;
            [alert show];
        }
    }
    if(alertView.tag == 9)
    {
        if(buttonIndex == 0)
        {
            ViewController *vc = [[ViewController alloc]init];
            [self presentViewController:vc animated:YES completion:nil];
            
            
        }
        else
        {
            exit(0);
            
        }
    }
}


@end
