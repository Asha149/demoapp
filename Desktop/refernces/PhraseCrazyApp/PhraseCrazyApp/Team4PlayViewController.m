//
//  Team4PlayViewController.m
//  PhraseCrazyApp
//
//  Created by ajeet Singh on 23/10/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import "Team4PlayViewController.h"
#import "ViewController.h"
#import "PhraseObjectClass.h"
#import "PhraseDatabaseClass.h"

#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-480)?NO:YES)
@interface Team4PlayViewController ()

@end

@implementation Team4PlayViewController

@synthesize lblTeamNo,lblScore1,lblScore2,lblScore3,lblTime,lblPhrase,lblScore4;
@synthesize btnBack,btnEndgame,btnNewPhrase,btnStartTurn,btnSuccess;
@synthesize arrPhrases = _arrPhrase;;
@synthesize btnGiveUp;


int hours, minutes, seconds;
int secondsLeft;
int ScoreTeam1,ScoreTeam2,ScoreTeam3,ScoreTeam4;
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
    ScoreTeam1 = 0;
    ScoreTeam2 =0;
    ScoreTeam3 = 0;
    ScoreTeam4 = 0;
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    self.arrPhrases = [PhraseDatabaseClass database].getPhrases;
    [btnGiveUp setHidden:YES];
    [btnStartTurn setHidden:NO];
    [btnSuccess setHidden:NO];
    [btnNewPhrase setHidden:YES];
    
    if(IS_IPHONE5)
    {
        
        [self.lblPhrase setFrame:CGRectMake(self.lblPhrase.frame.origin.x, self.lblPhrase.frame.origin.y+35, self.lblPhrase.frame.size.width, self.lblPhrase.frame.size.height)];
    }
    lblTime.text = [NSString stringWithFormat:@"%d",appDelegate.Time];
    countNewTeamButton = 0;
    countNewTeamButton ++;
        [self countdownTimer];
        if(countNewTeamButton % 4 == 1)
        {
            lblTeamNo.text = @"1";
        }
        else if (countNewTeamButton % 4 == 2)
        {
            lblTeamNo.text = @"2";
        }
        else if (countNewTeamButton % 4 == 3)
        {
            lblTeamNo.text = @"3";
        }
        else if (countNewTeamButton % 4 == 0)
        {
            lblTeamNo.text = @"4";
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
    // Do any additional setup after loading the view from its nib.
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
    ScoreTeam1 =0;
    ScoreTeam2 =0;
    ScoreTeam3 =0;
    ScoreTeam4 =0;
    
    ViewController *vc = [[ViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}
-(IBAction)btnNewPhrase_click:(id)sender
{
    randNum = (arc4random()%3700);
    PhraseObjectClass *info = [_arrPhrase objectAtIndex:randNum];
    
    lblPhrase.text = info.Phrases;
}
-(IBAction)btnGiveUp_click:(id)sender
{
    [btnGiveUp setHidden:YES];
    [btnStartTurn setHidden:NO];
}
-(IBAction)btnNewteam_click:(id)sender
{

    [btnStartTurn setHidden:NO];
   
    [btnSuccess setHidden:NO];
    [btnNewPhrase setHidden:NO];
//    countNewTeamButton ++;
//    [self countdownTimer];
//    if(countNewTeamButton % 4 == 1)
//    {
//        lblTeamNo.text = @"1";
//    }
//    else if (countNewTeamButton % 4 == 2)
//    {
//        lblTeamNo.text = @"2";
//    }
//    else if (countNewTeamButton % 4 == 3)
//    {
//        lblTeamNo.text = @"3";
//    }
//    else if (countNewTeamButton % 4 == 0)
//    {
//        lblTeamNo.text = @"4";
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
    if(countNewTeamButton % 4 == 1)
    {
        ScoreTeam1 ++;
        NSLog(@"score of team1 :: %d",ScoreTeam1);
        lblScore1.text = [NSString stringWithFormat:@"%d",ScoreTeam1];
    }
    else if (countNewTeamButton % 4 == 2)
    {
        ScoreTeam2 ++;
        NSLog(@"score of team2 :: %d",ScoreTeam2);
        lblScore2.text = [NSString stringWithFormat:@"%d",ScoreTeam2];
    }
    else if (countNewTeamButton % 4 == 3)
    {
        ScoreTeam3 ++ ;
        NSLog(@"score of team3 :: %d",ScoreTeam3);
        lblScore3.text = [NSString stringWithFormat:@"%d",ScoreTeam3];
    }
    else if (countNewTeamButton % 4 == 0)
    {
        ScoreTeam4 ++ ;
        NSLog(@"score of team4 :: %d",ScoreTeam4);
        lblScore4.text = [NSString stringWithFormat:@"%d",ScoreTeam4];
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
    if(ScoreTeam1 >ScoreTeam2 && ScoreTeam1 > ScoreTeam3 && ScoreTeam1 > ScoreTeam4)
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
    else if (ScoreTeam2 > ScoreTeam1 && ScoreTeam2 > ScoreTeam3 && ScoreTeam2 > ScoreTeam4)
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
    else if (ScoreTeam3 > ScoreTeam1 && ScoreTeam3 > ScoreTeam2 && ScoreTeam3 > ScoreTeam4)
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
    else if(ScoreTeam4 > ScoreTeam1 && ScoreTeam4 > ScoreTeam2 && ScoreTeam4 > ScoreTeam3)
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@""
                              message:@"Team 4 is winner."
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
        if(buttonIndex == 0)
        {
            countNewTeamButton ++;
            [self countdownTimer];
            if(countNewTeamButton % 4 == 1)
            {
                lblTeamNo.text = @"1";
            }
            else if (countNewTeamButton % 4 == 2)
            {
                lblTeamNo.text = @"2";
            }
            else if (countNewTeamButton % 4 == 3)
            {
                lblTeamNo.text = @"3";
            }
            else if (countNewTeamButton % 4 == 0)
            {
                lblTeamNo.text = @"4";
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
            ScoreTeam1 =0;
            ScoreTeam2 =0;
            ScoreTeam3 =0;
            ScoreTeam4 =0;
            ViewController *vc = [[ViewController alloc]init];
            [self presentViewController:vc animated:YES completion:nil];
           
        }
        else
        {
             timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateCounter:) userInfo:nil repeats:YES];
        }
    }
    if(alertView.tag == 9)
    {
        if(buttonIndex == 0)
        {
            

        }
        else
        {
            exit(0);
        }
    }
}

@end

