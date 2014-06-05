//
//  GameRuleViewController.h
//  PhraseCrazyApp
//
//  Created by ajeet Singh on 13/09/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameRuleViewController : UIViewController

@property (nonatomic,retain)IBOutlet UILabel *txtFullGroup,*txtTeamStyle;
@property (nonatomic,retain)IBOutlet UIButton *btnBack;
@property (nonatomic,retain)IBOutlet UIScrollView *scrollRule;
@property (nonatomic,retain)IBOutlet UILabel *lblTips;
@property (nonatomic,retain)IBOutlet UILabel *lblGroup;
@property (nonatomic,retain)IBOutlet UILabel *lblTeam;

-(IBAction)btnBack_click:(id)sender;

@end
