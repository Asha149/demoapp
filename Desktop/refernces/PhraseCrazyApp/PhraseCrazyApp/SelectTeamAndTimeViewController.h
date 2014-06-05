//
//  SelectTeamAndTimeViewController.h
//  PhraseCrazyApp
//
//  Created by ajeet Singh on 08/10/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface SelectTeamAndTimeViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>
{
    AppDelegate *appDelegate;
    
}
@property (nonatomic,retain)IBOutlet UILabel *lblMinutes, *lblTeam;
@property (nonatomic,retain)IBOutlet UIPickerView *pkvMinutes,*pkvTeam;
@property (nonatomic,retain)IBOutlet UIButton *btnPlay;
@property (nonatomic,retain)IBOutlet UIButton *btnBack;

-(IBAction)btnBack_click:(id)sender;
@end
