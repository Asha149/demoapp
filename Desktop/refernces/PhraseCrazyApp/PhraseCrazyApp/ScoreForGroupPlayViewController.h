//
//  ScoreForGroupPlayViewController.h
//  PhraseCrazyApp
//
//  Created by ajeet Singh on 21/10/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoreForGroupPlayViewController : UIViewController

@property (nonatomic,retain)IBOutlet UILabel *lblScore1;
@property (nonatomic,retain)IBOutlet UILabel *lblScore2;
@property (nonatomic,retain)IBOutlet UILabel *lblMessage;
@property (nonatomic,retain)IBOutlet UIButton *btnBack;

@property (nonatomic,retain)NSString *strScore1,*strScore2,*strMessage;
-(IBAction)btnback_click:(id)sender;

@end
