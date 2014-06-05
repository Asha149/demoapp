//
//  Team3PlayViewController.m
//  PhraseCrazyApp
//
//  Created by ajeet Singh on 23/10/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import "Team3PlayViewController.h"
#import "ViewController.h"
#import "PhraseObjectClass.h"
#import "PhraseDatabaseClass.h"

#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-480)?NO:YES)
@interface Team3PlayViewController ()

@end

@implementation Team3PlayViewController
@synthesize btnBack,btnEndgame,btnNewPhrase,btnStartTurn,btnSuccess,btnGiveup;
@synthesize lblPhrase,lblScore1,lblScore2,lblScore3,lblTeamNo,lblTime;
@synthesize arrPhrases = _arrPhrase;

int hours, minutes, seconds;
int secondsLeft;
int ScoreTeam11 =0,ScoreTeam22 =0,ScoreTeam33 = 0,ScoreTeam44 = 0;
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
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
   
    [btnStartTurn setHidden:NO];
    [btnSuccess setHidden:NO];
    [btnNewPhrase setHidden:YES];
    self.arrPhrases = [PhraseDatabaseClass database].getPhrases;
    if(IS_IPHONE5)
    {
        
        [self.lblPhrase setFrame:CGRectMake(self.lblPhrase.frame.origin.x, self.lblPhrase.frame.origin.y+27, self.lblPhrase.frame.size.width, self.lblPhrase.frame.size.height)];
    }
     lblTime.text = [NSString stringWithFormat:@"%d",appDelegate.Time];
    countNewTeamButton = 0;
         [self countdownTimer];
    countNewTeamButton ++;
        if(countNewTeamButton % 3 == 1)
        {
            lblTeamNo.text = @"1";
        }
        else if (countNewTeamButton % 3 == 2)
        {
            lblTeamNo.text = @"2";
        }
        else if (countNewTeamButton % 3 == 0)
        {
           lblTeamNo.text = @"3";
        }
        else
        {
            NSLog(@"out of team no... ...");
        }
    if(appDelegate.intPhraseNo > 51)
    {
        appDelegate.intPhraseNo =0;
    }
    appDelegate.intPhraseNo ++;
    NSLog(@"int phrase no.%d",appDelegate.intPhraseNo);
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",appDelegate.intPhraseNo]forKey:@"PhraseNo"];
    randNum = (arc4random()%3700);
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"PhraseNo"];
    int PhraseNo = [str intValue];
    PhraseObjectClass *info = [_arrPhrase objectAtIndex:PhraseNo];
    lblPhrase.text = info.Phrases;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark timer
- (void)updateCounter:(NSTimer *)theTimer {
    if(secondsLeft > 0 ){
        NSLog(@"%d",secondsLeft);
        secondsLeft -- ;
        
        minutes = (secondsLeft % 3600) / 60;
        seconds = (secondsLeft %3600) % 60;
        lblTime.text = [NSString stringWithFormat:@"%02d:%02d",  minutes, seconds];
        NSLog(@"seconds %02d",seconds);
        
        if(secondsLeft == 0)
        {
            
            [lblPhrase setText:@""];
            [timer invalidate];
            timer = nil;
            
            UIAlertView *alert = [[UIAlertView alloc]
                                  
                                  initWithTitle:@""
                                  message:@"Time is up. Next teams turn."
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil, nil];
            alert.tag = 1;
            [self SoundIntegrate];
            [alert show];
        }
    }
    else{
        
        secondsLeft = (appDelegate.Time * 60)-1;
        //secondsLeft = 10;
        NSLog(@"Seconds left : %d",secondsLeft);
        //secondsLeft = 10;
        minutes = (secondsLeft % 3600) / 60;
        seconds = (secondsLeft %3600) % 60;
        lblTime.text = [NSString stringWithFormat:@"%02d:%02d",  minutes, seconds];
    }
}

-(void)countdownTimer{
    secondsLeft = 0;
    hours = 0;
    minutes = 0;
    seconds = 0;
    
    static int interval = 1;
    NSLog(@"%d",interval);
    if(timer)
    {
        [timer invalidate];
        timer = nil;
    }
    timer = [[NSTimer alloc]init];
    
    secondsLeft = (appDelegate.Time *60);
    //secondsLeft = 10;
    NSLog(@"Time :: %d",appDelegate.Time);
    NSLog(@"Seconds left : %d",secondsLeft);
    //secondsLeft = 10;
    minutes = (secondsLeft % 3600) / 60;
    seconds = (secondsLeft %3600) % 60;
    lblTime.text = [NSString stringWithFormat:@"%02d:%02d",  minutes, seconds];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateCounter:) userInfo:nil repeats:YES];
}
#pragma mark Sound Integration
-(void)SoundIntegrate
{
    NSString *path = [[NSString alloc]init];
    
    path = [[NSBundle mainBundle] pathForResource:@"Microwave Bell Ding" ofType:@"mp3"];
    NSLog(@"path%@",path);
    AVAudioPlayer* theAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    theAudio.delegate = self;
    [theAudio play];
    
}
#pragma mark button click event
-(IBAction)btnBack_click:(id)sender
{
    [timer invalidate];
    timer = nil;
    ScoreTeam11 =0;
    ScoreTeam22 =0;
    ScoreTeam33 =0;
    ViewController *vc = [[ViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}
-(IBAction)btnNewPhrase_click:(id)sender
{
    randNum = (arc4random()%3700);
    PhraseObjectClass *info = [_arrPhrase objectAtIndex:randNum];
    lblPhrase.text = info.Phrases;
}
-(IBAction)btnNewteam_click:(id)sender
{
//    
    [btnStartTurn setHidden:NO];
    [btnSuccess setHidden:NO];
    [btnNewPhrase setHidden:NO];
//    countNewTeamButton ++;
//     [self countdownTimer];
//    if(countNewTeamButton % 3 == 1)
//    {
//        lblTeamNo.text = @"1";
//    }
//    else if (countNewTeamButton % 3 == 2)
//    {
//        lblTeamNo.text = @"2";
//    }
//    else if (countNewTeamButton % 3 == 0)
//    {
//       lblTeamNo.text = @"3";
//    }
//    else
//    {
//        NSLog(@"out of team no... ...");
//    }
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

}
-(IBAction)btnSuccess_click:(id)sender
{
    if(countNewTeamButton % 3 == 1)
    {
        ScoreTeam11 ++;
        NSLog(@"score of team1 :: %d",ScoreTeam11);
        lblScore1.text = [NSString stringWithFormat:@"%d",ScoreTeam11];
    }
    else if (countNewTeamButton % 3 == 2)
    {
        ScoreTeam22 ++;
        NSLog(@"score of team2 :: %d",ScoreTeam22);
        lblScore2.text = [NSString stringWithFormat:@"%d",ScoreTeam22];
    }
    else if (countNewTeamButton % 3 == 0)
    {
        ScoreTeam33 ++ ;
        NSLog(@"score of team3 :: %d",ScoreTeam33);
        lblScore3.text = [NSString stringWithFormat:@"%d",ScoreTeam33];
    }
    else
    {
        NSLog(@"out of ...");
    }
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
    
}
-(IBAction)btnEndGame_click:(id)sender
{
    [timer invalidate];
    timer = nil;
    if(ScoreTeam11 >ScoreTeam22 && ScoreTeam11 > ScoreTeam33)
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@""
                              message:@"Team 1 is winner."
                              delegate:self
                              cancelButtonTitle:@"Back To Menu"
                              otherButtonTitles:@"Cancel",
                              nil];
        alert.tag = 4;
        [alert show];

    }
    else if (ScoreTeam22 > ScoreTeam11 && ScoreTeam22 > ScoreTeam33)
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@""
                              message:@"Team 2 is winner."
                              delegate:self
                              cancelButtonTitle:@"Back To Menu"
                              otherButtonTitles:@"Cancel",
                              nil];
        alert.tag = 4;
        [alert show];

    }
    else if(ScoreTeam33 > ScoreTeam11 && ScoreTeam33 > ScoreTeam22)
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@""
                              message:@"Team 3 is winner."
                              delegate:self
                              cancelButtonTitle:@"Back To Menu"
                              otherButtonTitles:@"Cancel",
                              nil];
        alert.tag = 4;
        [alert show];

    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@""
                              message:@"Game is tie."
                              delegate:self
                              cancelButtonTitle:@"Back To Menu"
                              otherButtonTitles:@"Cancel",
                              nil];
        alert.tag = 4;
        [alert show];
    }
   
    
}
- (void)dealloc {
      [super dealloc];
}
#pragma mark alert view button click event
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 1)
    {
        [timer invalidate];
        timer = nil;
        secondsLeft = 0;
        
        if(buttonIndex == 0)
        {
        [self countdownTimer];
            countNewTeamButton ++;
        if(countNewTeamButton % 3 == 1)
        {
            lblTeamNo.text = @"1";
        }
        else if (countNewTeamButton % 3 == 2)
        {
            lblTeamNo.text = @"2";
        }
        else if (countNewTeamButton % 3 == 0)
        {
            lblTeamNo.text = @"3";
        }
        else
        {
            NSLog(@"out of team no... ...");
        }
        }

    }
    if(alertView.tag == 4)
    {
        if(buttonIndex == 0)
        {
            ScoreTeam11 =0;
            ScoreTeam22 =0;
            ScoreTeam33 =0;
            ScoreTeam44 =0;
            ViewController *vc = [[ViewController alloc]init];
            [self presentViewController:vc animated:YES completion:nil];
            
        }
        else
        {
             timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateCounter:) userInfo:nil repeats:YES];
        }
    }
}
@end
