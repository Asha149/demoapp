//
//  PlayGameViewController.h
//  PhraseCrazyApp
//
//  Created by ajeet Singh on 10/09/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>

@interface PlayGameViewController : UIViewController <UIAlertViewDelegate,AVAudioPlayerDelegate>
{
    NSTimer *timer;
    UILabel *_lblPhrase;
     NSArray *_arrPhrase;
    AppDelegate *appDelegate;
}
@property (nonatomic,retain) IBOutlet UILabel *lblPhrase;
@property (nonatomic, retain)IBOutlet UILabel *myCounterLabel;
@property (nonatomic,retain) IBOutlet UIButton *btnback;
@property (nonatomic, retain) NSArray *arrPhrases;
@property (nonatomic,retain)IBOutlet UILabel *lblTeam;
@property (nonatomic,retain)IBOutlet UILabel *lblTeam1Score, *lblTeam2Score;
@property (nonatomic,retain)IBOutlet UIButton *btnComplete;
@property (nonatomic,retain)IBOutlet UILabel *lblTimer;

@property (nonatomic,retain)IBOutlet UIImageView *imgBackGround;
@property (nonatomic,retain)IBOutlet UILabel *lblTeam1,*lblTeam2;
@property (nonatomic,retain)IBOutlet UILabel *lblScore,*lblNowPlaying;
@property (nonatomic,retain)IBOutlet UIButton *btnGiveUp,*btnNewteam;


-(void)updateCounter:(NSTimer *)theTimer;
-(void)countdownTimer;
-(IBAction)btnBack_click:(id)sender;
-(IBAction)btnNewTeam_click:(id)sender;
-(IBAction)btnComplete_click:(id)sender;
-(IBAction)btnEndGame_click:(id)sender;


@end