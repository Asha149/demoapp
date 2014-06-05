//
//  ViewExerciseViewController.h
//  BabyMaker
//
//  Created by ajeet Singh on 19/09/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ViewExerciseViewController : UIViewController
{
    UITableView *tblExercise;
    UIButton *btnBack;
    NSDateFormatter *dateFormatter,*DateToDisplayFormatter;
}
@property (nonatomic,retain) IBOutlet UITableView *tblExercise;
@property (nonatomic,retain) IBOutlet UIButton *btnBack;
@property (nonatomic,retain) IBOutlet NSString *dateString;

-(IBAction)btnbackClick:(id)sender;
@end
