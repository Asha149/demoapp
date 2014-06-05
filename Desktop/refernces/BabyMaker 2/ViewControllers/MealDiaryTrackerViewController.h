//
//  MealDiaryTrackerViewController.h
//  BabyMaker
//
//  Created by ajeet Singh on 13/08/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Kal.h"
#import "TKCalendarMonthView.h"

@interface MealDiaryTrackerViewController : UIViewController < UITableViewDelegate, TKCalendarMonthViewDelegate >
{
    UIScrollView *Scroll;
    NSDateFormatter *dateFormatter,*DateToDisplayFormatter;
    UITableView *dayEvents;
    UIButton *btnDateLabel,*btnPrevious,*btnNext;
}

@property (nonatomic,retain) IBOutlet UIScrollView *Scroll;
@property (nonatomic,retain) IBOutlet UIButton *btnMenu, *btnDetail, *btnDateLabel,*btnPrevious,*btnNext;
@property (nonatomic,retain) IBOutlet UITableView *dayEvents;
@property (nonatomic,retain) NSString *DateString;
@property (strong, nonatomic) TKCalendarMonthView *Cal;

-(IBAction)btnDateLabelClick:(id)sender;
-(IBAction)btnPreviousClick:(id)sender;
-(IBAction)btnNextClick:(id)sender;
@end
