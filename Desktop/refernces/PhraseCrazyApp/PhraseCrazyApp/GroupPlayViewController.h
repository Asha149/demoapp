//
//  GroupPlayViewController.h
//  PhraseCrazyApp
//
//  Created by ajeet Singh on 24/10/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface GroupPlayViewController : UIViewController
{
    AppDelegate *appDelegate;
    NSArray *_arrPhrase;
}
@property (nonatomic,retain)IBOutlet UIButton *btnBack;
@property (nonatomic,retain)IBOutlet UIButton *btnNewPhrase;
@property (nonatomic,retain)IBOutlet UIButton *btnSuccess;
@property (nonatomic,retain)IBOutlet UIButton *btnStartTurn;
@property (nonatomic,retain)IBOutlet UIButton *btnEndgame;

@property (nonatomic,retain)IBOutlet UILabel *lblPhrase;
@property (nonatomic, retain) NSArray *arrPhrases;

-(IBAction)btnBack_click:(id)sender;
-(IBAction)btnNewPhrase_click:(id)sender;
-(IBAction)btnNewteam_click:(id)sender;
-(IBAction)btnSuccess_click:(id)sender;
-(IBAction)btnEndGame_click:(id)sender;


@end
