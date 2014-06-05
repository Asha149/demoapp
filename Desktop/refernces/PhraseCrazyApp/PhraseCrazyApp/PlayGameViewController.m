
#import "PlayGameViewController.h"
#import "QuartzCore/QuartzCore.h"
#import "ViewController.h"
#import "PhraseObjectClass.h"
#import "PhraseDatabaseClass.h"
#import "AppDelegate.h"
#import "ScoreForGroupPlayViewController.h"
#import "Team3PlayViewController.h"
#import "Team4PlayViewController.h"
#import "GroupPlayViewController.h"

#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-480)?NO:YES)

@interface PlayGameViewController ()

@end

@implementation PlayGameViewController

@synthesize lblPhrase,lblTeam ;
@synthesize myCounterLabel,btnback;
@synthesize arrPhrases = _arrPhrase;
@synthesize lblTeam1Score,lblTeam2Score;
@synthesize btnComplete,lblTimer;

@synthesize imgBackGround;
@synthesize lblTeam1,lblTeam2;
@synthesize lblNowPlaying,lblScore;
@synthesize btnGiveUp,btnNewteam;

int hours, minutes, seconds;
int secondsLeft;
int CountCompleteButton =0;
int ScoreTeam1 =0,ScoreTeam2 =0,ScoreTeam3 = 0,Scoreteam4 = 0;
int randNum,varChangeTeam;
NSString *path;
AVAudioPlayer* theAudio;

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
    path = [[NSString alloc]init];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    varChangeTeam =0;
    self.arrPhrases = [PhraseDatabaseClass database].getPhrases;
    [btnComplete setHidden:NO];
    ScoreTeam1 = 0;
    ScoreTeam2 = 0;
    CountCompleteButton =0;
    

    if(appDelegate.IsTimed == TRUE)
    {
        
        if(IS_IPHONE5)
        {
          
            [self.lblPhrase setFrame:CGRectMake(self.lblPhrase.frame.origin.x, self.lblPhrase.frame.origin.y+30, self.lblPhrase.frame.size.width, self.lblPhrase.frame.size.height)];
        }
        
        [lblTimer setHidden:NO];
        [myCounterLabel setHidden:NO];
        myCounterLabel.text = [NSString stringWithFormat:@"%d",appDelegate.Time];
        NSLog(@"Total Team :: %d",appDelegate.Team);
        
       
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
        GroupPlayViewController *vc = [[GroupPlayViewController alloc]init];
        [self presentViewController:vc animated:YES completion:nil];
    }
    if(appDelegate.IsTimed == TRUE)
        {
    //       // myCounterLabel.text = @"2:00";
            [self countdownTimer];
    //
       }
    else
        {
            [timer invalidate];
            timer = nil;
       }
        if(appDelegate.flag == 0)
        {

    //        [btnNewPhrase setHidden:NO];
//    [btnComplete setHidden:NO];
            varChangeTeam ++;
            CountCompleteButton ++;
            if(varChangeTeam %2 == 0)
            {
    
                [lblTeam setText:@"Team 2"];
            }
           else
           {
    
                [lblTeam setText:@"Team 1"];
            }
        }

    //        randNum = (arc4random()%450);
    //        PhraseObjectClass *info = [_arrPhrase objectAtIndex:randNum];
    //        lblPhrase.text = info.Phrases;
    //    }
    //    else
    //    {
    //        [btnComplete setHidden:NO];
    //        [btnNewPhrase setHidden:NO];
    //        varChangeTeam ++;
    //        CountCompleteButton ++;
    //        if(varChangeTeam %2 == 0)
    //        {
    //
    //            [lblTeam setText:@"Team 2"];
    //        }
    //        else
    //        {
    //            
    //            [lblTeam setText:@"Team 1"];
    //        }

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

#pragma mark Sound Integration
-(void)SoundIntegrate
{
   
    
    path = [[NSBundle mainBundle] pathForResource:@"Microwave Bell Ding" ofType:@"mp3"];
    NSLog(@"path%@",path);
     theAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    theAudio.delegate = self;
    [theAudio play];
    
}

#pragma mark timer
- (void)updateCounter:(NSTimer *)theTimer {
    if(secondsLeft > 0 ){
        NSLog(@"  Time Left :::::: %d",secondsLeft);
        secondsLeft -- ;
       
        minutes = (secondsLeft % 3600) / 60;
        seconds = (secondsLeft %3600) % 60;
        myCounterLabel.text = [NSString stringWithFormat:@"%02d:%02d",  minutes, seconds];
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
        myCounterLabel.text = [NSString stringWithFormat:@"%02d:%02d",  minutes, seconds];
    }
}

-(void)countdownTimer
{
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
    myCounterLabel.text = [NSString stringWithFormat:@"%02d:%02d",  minutes, seconds];
    
   timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateCounter:) userInfo:nil repeats:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark click event

-(IBAction)btnBack_click:(id)sender
{
    [timer invalidate];
    timer = nil;
    ScoreTeam1 = 0;
    ScoreTeam2 = 0;
    ScoreTeam3 = 0;
    ViewController *vc = [[ViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}

-(IBAction)btnNewTeam_click:(id)sender
{
    [btnNewteam setHidden:NO];
//    if(IS_IPHONE5)
//    {
//        
//        [self.lblPhrase setFrame:CGRectMake(self.lblPhrase.frame.origin.x, self.lblPhrase.frame.origin.y, self.lblPhrase.frame.size.width, self.lblPhrase.frame.size.height)];
//    }
//    
//    NSLog(@"Flag %d",appDelegate.flag);
//    if(appDelegate.IsTimed == TRUE)
//    {
//       // myCounterLabel.text = @"2:00";
//        [self countdownTimer];
//         
//    }
//    else
//    {
//        [timer invalidate];
//        timer = nil;
//    }
//    if(appDelegate.flag == 0)
//    {
//    
//        [btnNewPhrase setHidden:NO];
        [btnComplete setHidden:NO];
//        varChangeTeam ++;
//        CountCompleteButton ++;
//        if(varChangeTeam %2 == 0)
//        {
//       
//            [lblTeam setText:@"Team 2"];
//        }
//        else
//        {
//       
//            [lblTeam setText:@"Team 1"];
//        }
//        
//        randNum = (arc4random()%450);
//        PhraseObjectClass *info = [_arrPhrase objectAtIndex:randNum];
//        lblPhrase.text = info.Phrases;
//    }
//    else
//    {
//        [btnComplete setHidden:NO];
//        [btnNewPhrase setHidden:NO];
//        varChangeTeam ++;
//        CountCompleteButton ++;
//        if(varChangeTeam %2 == 0)
//        {
//            
//            [lblTeam setText:@"Team 2"];
//        }
//        else
//        {
//            
//            [lblTeam setText:@"Team 1"];
//        }
//        randNum = (arc4random()%450);
//        PhraseObjectClass *info = [_arrPhrase objectAtIndex2+:randNum];
//        lblPhrase.text = info.Phrases;
//    }
    /* NSLog(@"FL = %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"FL"]);
     to Store Value
     */
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
    
    NSLog(@"Phrase no :: %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"PhraseNo"]);
    [timer invalidate];
    timer = nil;
   
    if (appDelegate.IsTimed == TRUE) {
    if(ScoreTeam1 == ScoreTeam2)
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@""
                              message:@"Game is tie."
                              delegate:self
                              cancelButtonTitle:@"Back To Menu"
                              otherButtonTitles:@"Cancel",
                              nil];
        alert.tag = 3;
        [alert show];
        
       
    }
    else if(ScoreTeam1 > ScoreTeam2)
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
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@""
                              message:@"Team 2 is winner."
                              delegate:self
                              cancelButtonTitle:@"Back To Menu"
                              otherButtonTitles:@"Cancel",
                              nil];
        alert.tag = 5;
        [alert show];
    }
            }
    else
    {
        
    }
}
-(IBAction)btnComplete_click:(id)sender
{
    if(appDelegate.IsTimed == TRUE)
    {
          if(secondsLeft != 0)
            {
                if(CountCompleteButton % 2 == 0)
                {
                    ScoreTeam2 = ScoreTeam2 + 1;
                    lblTeam2Score.text =  [NSString stringWithFormat:@"%d", ScoreTeam2];
                }
                else
                {
                    ScoreTeam1 = ScoreTeam1 + 1;
                    lblTeam1Score.text =  [NSString stringWithFormat:@"%d", ScoreTeam1];
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
   
    }
    else
    {
        
        if(CountCompleteButton % 2 == 0)
        {
            ScoreTeam2 = ScoreTeam2 + 1;
            lblTeam2Score.text =  [NSString stringWithFormat:@"%d", ScoreTeam2];
            [lblTeam setText:@"Team 1"];
        }
        else
        {
            ScoreTeam1 = ScoreTeam1 + 1;
            lblTeam1Score.text =  [NSString stringWithFormat:@"%d", ScoreTeam1];
            [lblTeam setText:@"Team 2"];
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
    
    
}
-(void)SoundStop
{
       if([theAudio isPlaying])
    {
        [theAudio stop];
        theAudio= nil;
    }

    
    theAudio.delegate = self;
    
    
    
}
#pragma mark alert view button click event
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 1)
    {
        [timer invalidate];
        timer = nil;
        secondsLeft = 0;
        [self SoundStop];
           if (buttonIndex == 0){
            CountCompleteButton ++;
            if(CountCompleteButton % 2 == 0)
            {
               [lblTeam setText:@"Team 2"];
                [self countdownTimer];
            }
            else
            {
               [lblTeam setText:@"Team 1"];
                [self countdownTimer];
            }
            randNum = (arc4random()%3700);
                   PhraseObjectClass *info = [_arrPhrase objectAtIndex:randNum];
                lblPhrase.text = info.Phrases;
            
            NSLog(@"clicked on ok");
            myCounterLabel.text = @"";
        }else if (buttonIndex == 1){
            //reset clicked
            [timer invalidate];
            timer = nil;
            NSLog(@"clicked on ok");
        }
    }
    else if(alertView.tag == 3 || alertView.tag == 4 || alertView.tag == 5)
    {
        if(buttonIndex == 0)
        {
            ScoreTeam1 = 0;
            ScoreTeam2 = 0;
            
            
            ViewController *vc = [[ViewController alloc]init];
            [self presentViewController:vc animated:YES completion:nil];
            
            
        }
        else
        {
            NSLog(@"timer :: %d",secondsLeft);
            minutes = (secondsLeft % 3600) / 60;
            seconds = (secondsLeft %3600) % 60;
            myCounterLabel.text = [NSString stringWithFormat:@"%02d:%02d",  minutes, seconds];
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateCounter:) userInfo:nil repeats:YES];
            
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
}

@end
