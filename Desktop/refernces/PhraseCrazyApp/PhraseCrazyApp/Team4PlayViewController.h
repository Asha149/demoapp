//
//  Team4PlayViewController.h
//  PhraseCrazyApp
//
//  Created by ajeet Singh on 23/10/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"

@interface Team4PlayViewController : UIViewController<UIAlertViewDelegate,AVAudioPlayerDelegate>
{
    NSTimer *timer;
    AppDelegate *appDelegate;
    NSArray *_arrPhrase;
    
}


@property (nonatomic,retain)IBOutlet UIButton *btnBack;
@property (nonatomic,retain)IBOutlet UIButton *btnNewPhrase;
@property (nonatomic,retain)IBOutlet UIButton *btnSuccess;
@property (nonatomic,retain)IBOutlet UIButton *btnStartTurn,*btnGiveUp;
@property (nonatomic,retain)IBOutlet UIButton *btnEndgame;
@property (nonatomic,retain)IBOutlet UILabel *lblScore1,*lblScore2,*lblScore3,*lblScore4;
@property (nonatomic,retain)IBOutlet UILabel *lblTeamNo,*lblTime,*lblPhrase;
@property (nonatomic, retain) NSArray *arrPhrases;

-(IBAction)btnBack_click:(id)sender;
-(IBAction)btnNewPhrase_click:(id)sender;
-(IBAction)btnNewteam_click:(id)sender;
-(IBAction)btnSuccess_click:(id)sender;
-(IBAction)btnEndGame_click:(id)sender;
-(IBAction)btnGiveUp_click:(id)sender;

@end
